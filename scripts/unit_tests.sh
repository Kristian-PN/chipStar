#!/bin/bash

set -e

host=`hostname`
echo "Running on ${hostname}"
# If not on Salami read the file /opt/actions-runner/num-threads.txt and set the number of threads to the value in the file
# if the file does not exist, set the number of threads to 24
if [ "$host" = "salami" ]; then
  num_threads=1
else
  if [ -f "/opt/actions-runner/num-threads.txt" ]; then
    num_threads=$(cat /opt/actions-runner/num-threads.txt)
  else
    num_threads=$(nproc)
  fi
fi

num_tries=1
# deafult timeout is 30 minutes
timeout=1800

# Check if at least one argument is provided
if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <debug|release> <llvm-15|llvm-16|llvm-17|llvm-18> [--skip-build] [--num-tries=$num_tries] [--num-threads=$num_threads] [--timeout=$timeout]"
  exit 1
fi

# Check if the first argument is either "debug" or "release"
if [ "$1" != "debug" ] && [ "$1" != "release" ]; then
  echo "Error: Invalid argument. Must be either 'debug' or 'release'."
  exit 1
fi

# Set the build type based on the argument
build_type=$(echo "$1" | tr '[:lower:]' '[:upper:]')

if [ "$host" = "salami" ]; then
  if [ "$2" == "llvm-15" ]; then
    LLVM=llvm-17
    CLANG=llvm/17.0
  else
    echo "$2"
    echo "Invalid 2nd argument. Use  'llvm-15'."
    exit 1
  fi
else
  if [ "$2" == "llvm-15" ]; then
    LLVM=llvm-15
    CLANG=llvm/15.0-unpatched-spirv
  elif [ "$2" == "llvm-16" ]; then
    LLVM=llvm-16
    CLANG=llvm/16.0-unpatched-spirv
  elif [ "$2" == "llvm-17" ]; then
    LLVM=llvm-17
    CLANG=llvm/17.0-unpatched-spirv
  elif [ "$2" == "llvm-18" ]; then
    LLVM=llvm-18
    CLANG=llvm/18.0-unpatched-spirv
  else
    echo "$2"
    echo "Invalid 2nd argument. Use either 'llvm-15', 'llvm-16', 'llvm-17' or 'llvm-18'."
    exit 1
  fi
fi

shift
shift

for arg in "$@"
do
  case $arg in
    --num-threads=*)
      num_threads="${arg#*=}"
      shift
      ;;
    --num-threads)
      shift
      num_threads="$1"
      shift
      ;;
    --num-tries=*)
      num_tries="${arg#*=}"
      shift
      ;;
    --num-tries)
      shift
      num_tries="$1"
      shift
      ;;
    --skip-build)
      skip_build=true
      shift
      ;;
    --timeout=*)
      timeout="${arg#*=}"
      shift
      ;;
    --timeout)
      shift
      timeout="$1"
      shift
      ;;
    *)
      ;;
  esac
done


# Print out the arguments
echo "build_type  = ${build_type}"
echo "LLVM        = ${LLVM}"
echo "CLANG       = ${CLANG}"
echo "num_tries   = ${num_tries}"
echo "num_threads = ${num_threads}"
echo "skip_build  = ${skip_build}"
echo "timeout     = ${timeout}"

# source /opt/intel/oneapi/setvars.sh intel64 &> /dev/null
if [ "$host" != "salami" ]; then
  source /etc/profile.d/modules.sh &> /dev/null
fi
export IGC_EnableDPEmulation=1
export OverrideDefaultFP64Settings=1
export CHIP_LOGLEVEL=err
export POCL_KERNEL_CACHE=0

# set event timeout to be 10 less than timeout
export CHIP_L0_EVENT_TIMEOUT=$(($timeout - 10))

# Use OpenCL for building/test discovery to prevent Level Zero from being used in multi-thread/multi-process environment
if [ "$host" = "salami" ]; then
  # module use  /home/kristian/apps/modulefiles
  # module load $CLANG
else
  module use ~/modulefiles
  module load oneapi/2024.1.0 $CLANG opencl/dgpu 
fi

output=$(clinfo -l 2>&1 | grep "Platform #0")
echo $output
if [ $? -ne 0 ]; then
    echo "clinfo failed to execute."
    exit 1
fi

# check if the output is empty
if [ -z "$output" ]; then
    echo "No OpenCL devices detected."
    exit 1
fi

if [ $skip_build ]; then
  echo "Skipping build step"
  cd build
else
  if [ "$host" = "salami" ]; then
    CHIP_OPTIONS="-DLLVM_CONFIG_BIN=/opt/llvm/17.0/bin/llvm-config -DCHIP_MALI_GPU_WORKAROUNDS=ON -DCHIP_SKIP_TESTS_WITH_DOUBLES=ON"
    build_threads=1
  else
    CHIP_OPTIONS="-DCHIP_BUILD_HIPBLAS=ON"
    build_threads=`nproc`
  fi
  # Build the project
  echo "Building project..."
  rm -rf HIPCC
  rm -rf HIP
  rm -rf bitcode/ROCm-Device-Libs
  rm -rf hip-tests
  rm -rf hip-testsuite

  git submodule update --init
  rm -rf build
  rm -rf *_result.txt
  mkdir build
  cd build

  echo "building with $CLANG"
  cmake ../ -DCMAKE_BUILD_TYPE="$build_type"  ${CHIP_OPTIONS}
  make all build_tests install -j ${build_threads} #&> /dev/null
  echo "chipStar build complete." 
fi

if [ "$host" != "salami" ]; then
  module unload opencl/dgpu
fi


# module load HIP/hipBLAS/main/release # for libCEED NOTE: Must be after build step otherwise it will cause link issues.


if [ "$host" = "salami" ]; then
  # Test OpenCL iGPU
  echo "begin igpu_opencl_failed_tests"
  # module load opencl/igpu
  # module list
  ../scripts/check.py ./ igpu opencl --num-threads=${num_threads} --timeout=$timeout --num-tries=$num_tries --modules=off | tee igpu_opencl_make_check_result.txt
  # module unload opencl/igpu
  echo "end igpu_opencl_failed_tests"
else
  # Test Level Zero iGPU
  echo "begin igpu_level0_failed_tests"
  # module load level-zero/igpu
  # module list
  ../scripts/check.py ./ igpu level0 --num-threads=${num_threads} --timeout=$timeout --num-tries=$num_tries --modules=on | tee igpu_level0_make_check_result.txt
  # module unload level-zero/igpu
  echo "end igpu_level0_failed_tests"

  # Test Level Zero dGPU
  echo "begin dgpu_level0_failed_tests"
  # module load level-zero/dgpu
  # module list
  ../scripts/check.py ./ dgpu level0 --num-threads=${num_threads} --timeout=$timeout --num-tries=$num_tries --modules=on | tee dgpu_level0_make_check_result.txt
  # module unload level-zero/dgpu
  echo "end dgpu_level0_failed_tests"

  # Test OpenCL iGPU
  echo "begin igpu_opencl_failed_tests"
  # module load opencl/igpu
  # module list
  ../scripts/check.py ./ igpu opencl --num-threads=${num_threads} --timeout=$timeout --num-tries=$num_tries --modules=on | tee igpu_opencl_make_check_result.txt
  # module unload opencl/igpu
  echo "end igpu_opencl_failed_tests"

  # Test OpenCL dGPU
  echo "begin dgpu_opencl_failed_tests"
  # module load intel/opencl # sets ICD
  # module load opencl/dgpu # sets CHIP_BE
  # module list
  ../scripts/check.py ./ dgpu opencl --num-threads=${num_threads} --timeout=$timeout --num-tries=$num_tries --modules=on | tee dgpu_opencl_make_check_result.txt
  # module unload opencl/dgpu intel/opencl
  echo "end dgpu_opencl_failed_tests"
fi


function check_tests {
  file="$1"
  if ! grep -q "The following tests FAILED" "$file"; then
    echo "PASS"
    return 0
  else
    echo "FAIL"
    grep -E "The following tests FAILED:" -A 1000 "$file" | sed '/^$/q' | tail -n +2
    return 1
  fi
}

overall_status=0
set +e
echo "RESULTS:"
for test_result in dgpu_opencl_make_check_result.txt \
                   igpu_opencl_make_check_result.txt \
                   igpu_level0_make_check_result.txt \
                   dgpu_level0_make_check_result.txt
do
  echo -n "${test_result}: "
  check_tests "${test_result}"
  test_status=$?
  if [ $test_status -eq 1 ]; then
    overall_status=1
  fi
done

exit $overall_status
