# create a function called add_hecbench_test

function(add_hecbench_test TEST_NAME)
    add_test(
        NAME ${TEST_NAME}-hecbench-compile
        COMMAND bash -c "export PATH=$PATH:${CMAKE_BINARY_DIR}/bin && cd ${CMAKE_SOURCE_DIR}/HeCBench/${TEST_NAME} && make"
    )

    add_test(
        NAME ${TEST_NAME}-hecbench-execute
        COMMAND bash -c "export PATH=$PATH:${CMAKE_BINARY_DIR}/bin && cd ${CMAKE_SOURCE_DIR}/HeCBench/${TEST_NAME} && make && make run || echo 'HIP_SKIP_THIS_TEST'"
    )

    set_property(TEST ${TEST_NAME}-hecbench-execute PROPERTY SKIP_REGULAR_EXPRESSION "HIP_SKIP_THIS_TEST")
    set_property(TEST ${TEST_NAME}-hecbench-compile PROPERTY LABELS HeCBench)
    set_property(TEST ${TEST_NAME}-hecbench-execute PROPERTY LABELS HeCBench)

    message(STATUS "Adding HeCBench test: ${TEST_NAME}")
endfunction()

add_hecbench_test(streamcluster-hip)
add_hecbench_test(grep-hip)
add_hecbench_test(determinant-hip)
add_hecbench_test(clock-hip)
add_hecbench_test(babelstream-hip)
add_hecbench_test(lud-hip)
add_hecbench_test(ga-hip)
add_hecbench_test(cbsfil-hip)
add_hecbench_test(fresnel-hip)
add_hecbench_test(su3-hip)
add_hecbench_test(sptrsv-hip)
add_hecbench_test(d2q9-bgk-hip)
add_hecbench_test(relu-hip)
add_hecbench_test(minkowski-hip)
add_hecbench_test(depixel-hip)
add_hecbench_test(nn-hip)
add_hecbench_test(minimap2-hip)
add_hecbench_test(shmembench-hip)
add_hecbench_test(knn-hip)
add_hecbench_test(wedford-hip)
add_hecbench_test(dp-hip)
add_hecbench_test(heat-hip)
add_hecbench_test(cross-hip)
add_hecbench_test(hellinger-hip)
add_hecbench_test(dropout-hip)
add_hecbench_test(xsbench-hip)
add_hecbench_test(fluidSim-hip)
add_hecbench_test(dispatch-hip)
add_hecbench_test(gpp-hip)
add_hecbench_test(hogbom-hip)
add_hecbench_test(warpsort-hip)
add_hecbench_test(radixsort2-hip)
add_hecbench_test(particle-diffusion-hip)
add_hecbench_test(channelSum-hip)
add_hecbench_test(md-hip)
add_hecbench_test(mriQ-hip)
add_hecbench_test(meanshift-hip)
add_hecbench_test(rainflow-hip)
add_hecbench_test(car-hip)
add_hecbench_test(marchingCubes-hip)
add_hecbench_test(backprop-hip)
add_hecbench_test(ss-hip)
add_hecbench_test(lr-hip)
add_hecbench_test(warpselect-hip)
add_hecbench_test(concurrentKernels-hip)
add_hecbench_test(zeropoint-hip)
add_hecbench_test(reaction-hip)
add_hecbench_test(pointwise-hip)
add_hecbench_test(mcmd-hip)
add_hecbench_test(atomicIntrinsics-hip)
add_hecbench_test(extend2-hip)
add_hecbench_test(aobench-hip)
add_hecbench_test(columnarSolver-hip)
add_hecbench_test(sosfil-hip)
add_hecbench_test(is-hip)
add_hecbench_test(b+tree-hip)
add_hecbench_test(simplemoc-hip)
add_hecbench_test(inversek2j-hip)
add_hecbench_test(p2p-hip)
add_hecbench_test(snake-hip)
add_hecbench_test(gc-hip)
add_hecbench_test(fpdc-hip)
add_hecbench_test(assert-hip)
add_hecbench_test(feynman-kac-hip)
add_hecbench_test(heat2d-hip)
add_hecbench_test(lid-driven-cavity-hip)
add_hecbench_test(crossEntropy-hip)
add_hecbench_test(mandelbrot-hip)
add_hecbench_test(simpleSpmv-hip)
add_hecbench_test(slu-hip)
add_hecbench_test(rowwiseMoments-hip)
add_hecbench_test(hexciton-hip)
add_hecbench_test(tonemapping-hip)
add_hecbench_test(contract-hip)
add_hecbench_test(pcc-hip)
add_hecbench_test(svd3x3-hip)
add_hecbench_test(colorwheel-hip)
add_hecbench_test(lulesh-hip)
add_hecbench_test(iso2dfd-hip)
add_hecbench_test(bsearch-hip)
add_hecbench_test(fdtd3d-hip)
add_hecbench_test(interleave-hip)
add_hecbench_test(flame-hip)
add_hecbench_test(gd-hip)
add_hecbench_test(easyWave-hip)
add_hecbench_test(present-hip)
add_hecbench_test(heartwall-hip)
add_hecbench_test(pool-hip)
add_hecbench_test(geodesic-hip)
add_hecbench_test(deredundancy-hip)
add_hecbench_test(gru-hip)
add_hecbench_test(epistasis-hip)
add_hecbench_test(fhd-hip)
add_hecbench_test(sobel-hip)
add_hecbench_test(dslash-hip)
add_hecbench_test(complex-hip)
add_hecbench_test(adv-hip)
add_hecbench_test(jenkins-hash-hip)
add_hecbench_test(cm-hip)
add_hecbench_test(mrc-hip)
add_hecbench_test(myocyte-hip)
add_hecbench_test(cooling-hip)
add_hecbench_test(bfs-hip)
add_hecbench_test(leukocyte-hip)
add_hecbench_test(linearprobing-hip)
add_hecbench_test(libor-hip)
add_hecbench_test(stencil1d-hip)
add_hecbench_test(scel-hip)
add_hecbench_test(nbnxm-hip)
add_hecbench_test(shuffle-hip)
add_hecbench_test(damage-hip)
add_hecbench_test(glu-hip)
add_hecbench_test(cmembench-hip)
add_hecbench_test(qrg-hip)
add_hecbench_test(tqs-hip)
add_hecbench_test(burger-hip)
add_hecbench_test(coordinates-hip)
add_hecbench_test(d3q19-bgk-hip)
add_hecbench_test(qtclustering-hip)
add_hecbench_test(geam-hip)
add_hecbench_test(chacha20-hip)
add_hecbench_test(aes-hip)
add_hecbench_test(interval-hip)
add_hecbench_test(all-pairs-distance-hip)
add_hecbench_test(binomial-hip)
add_hecbench_test(nw-hip)
add_hecbench_test(unfold-hip)
add_hecbench_test(wordcount-hip)
add_hecbench_test(phmm-hip)
add_hecbench_test(hausdorff-hip)
add_hecbench_test(sc-hip)
add_hecbench_test(ecdh-hip)
add_hecbench_test(softmax-hip)
add_hecbench_test(projectile-hip)
add_hecbench_test(matrixT-hip)
add_hecbench_test(thomas-hip)
add_hecbench_test(ge-spmm-hip)
add_hecbench_test(ntt-hip)
add_hecbench_test(bm3d-hip)
add_hecbench_test(randomAccess-hip)
add_hecbench_test(hypterm-hip)
add_hecbench_test(mixbench-hip)
add_hecbench_test(dpid-hip)
add_hecbench_test(atan2-hip)
add_hecbench_test(rng-wallace-hip)
add_hecbench_test(threadfence-hip)
add_hecbench_test(laplace3d-hip)
add_hecbench_test(winograd-hip)
add_hecbench_test(maxFlops-hip)
add_hecbench_test(ddbp-hip)
add_hecbench_test(gabor-hip)
add_hecbench_test(rtm8-hip)
add_hecbench_test(tensorT-hip)
add_hecbench_test(michalewicz-hip)
add_hecbench_test(ced-hip)
add_hecbench_test(segment-reduce-hip)
add_hecbench_test(haccmk-hip)
add_hecbench_test(minimod-hip)
add_hecbench_test(laplace-hip)
add_hecbench_test(aligned-types-hip)
add_hecbench_test(kurtosis-hip)
add_hecbench_test(match-hip)
add_hecbench_test(langford-hip)
add_hecbench_test(entropy-hip)
add_hecbench_test(hungarian-hip)
add_hecbench_test(lda-hip)
add_hecbench_test(pso-hip)
add_hecbench_test(bspline-vgh-hip)
add_hecbench_test(bitpacking-hip)
add_hecbench_test(attention-hip)
add_hecbench_test(recursiveGaussian-hip)
add_hecbench_test(cc-hip)
add_hecbench_test(minmax-hip)
add_hecbench_test(reverse-hip)
add_hecbench_test(langevin-hip)
add_hecbench_test(prefetch-hip)
add_hecbench_test(pathfinder-hip)
add_hecbench_test(degrid-hip)
add_hecbench_test(kalman-hip)
add_hecbench_test(rsbench-hip)
add_hecbench_test(wsm5-hip)
add_hecbench_test(fsm-hip)
add_hecbench_test(simpleMultiDevice-hip)
add_hecbench_test(split-hip)
add_hecbench_test(mask-hip)
add_hecbench_test(lombscargle-hip)
add_hecbench_test(bitonic-sort-hip)
add_hecbench_test(graphB+-hip)
add_hecbench_test(swish-hip)
add_hecbench_test(amgmk-hip)
add_hecbench_test(conversion-hip)
add_hecbench_test(scan3-hip)
add_hecbench_test(fft-hip)
add_hecbench_test(p4-hip)
add_hecbench_test(rfs-hip)
add_hecbench_test(mis-hip)
add_hecbench_test(egs-hip)
add_hecbench_test(lanczos-hip)
add_hecbench_test(clink-hip)
add_hecbench_test(permutate-hip)
add_hecbench_test(debayer-hip)
add_hecbench_test(lsqt-hip)
add_hecbench_test(mallocFree-hip)
add_hecbench_test(s8n-hip)
add_hecbench_test(multinomial-hip)
add_hecbench_test(haversine-hip)
add_hecbench_test(merkle-hip)
add_hecbench_test(cmp-hip)
add_hecbench_test(crs-hip)
add_hecbench_test(tissue-hip)
add_hecbench_test(sort-hip)
add_hecbench_test(expdist-hip)
add_hecbench_test(medianfilter-hip)
add_hecbench_test(jacobi-hip)
add_hecbench_test(extrema-hip)
add_hecbench_test(face-hip)
add_hecbench_test(srad-hip)
add_hecbench_test(divergence-hip)
add_hecbench_test(multimaterial-hip)
add_hecbench_test(diamond-hip)
add_hecbench_test(si-hip)
add_hecbench_test(cfd-hip)
add_hecbench_test(nbody-hip)
add_hecbench_test(mmcsf-hip)
add_hecbench_test(prna-hip)
add_hecbench_test(mdh-hip)
add_hecbench_test(rushlarsen-hip)
add_hecbench_test(sobol-hip)
add_hecbench_test(gibbs-hip)
add_hecbench_test(xlqc-hip)
add_hecbench_test(kmeans-hip)
add_hecbench_test(atomicReduction-hip)
add_hecbench_test(bilateral-hip)
add_hecbench_test(score-hip)
add_hecbench_test(atomicSystemWide-hip)
add_hecbench_test(ert-hip)
add_hecbench_test(tridiagonal-hip)
add_hecbench_test(hbc-hip)
add_hecbench_test(fpc-hip)
add_hecbench_test(triad-hip)
add_hecbench_test(floydwarshall-hip)
add_hecbench_test(affine-hip)
add_hecbench_test(lrn-hip)
add_hecbench_test(miniFE-hip)
add_hecbench_test(wlcpow-hip)
add_hecbench_test(addBiasResidualLayerNorm-hip)
add_hecbench_test(axhelm-hip)
add_hecbench_test(convolution1D-hip)
add_hecbench_test(sampling-hip)
add_hecbench_test(md5hash-hip)
add_hecbench_test(lif-hip)
add_hecbench_test(gemmEx-hip)
add_hecbench_test(ldpc-hip)
add_hecbench_test(scan2-hip)
add_hecbench_test(vote-hip)
add_hecbench_test(sheath-hip)
add_hecbench_test(memtest-hip)
add_hecbench_test(black-scholes-hip)
add_hecbench_test(kmc-hip)
add_hecbench_test(f16max-hip)
add_hecbench_test(zoom-hip)
add_hecbench_test(bincount-hip)
add_hecbench_test(cobahh-hip)
add_hecbench_test(gmm-hip)
add_hecbench_test(pitch-hip)
add_hecbench_test(loopback-hip)
add_hecbench_test(bwt-hip)
add_hecbench_test(idivide-hip)
add_hecbench_test(floydwarshall2-hip)
add_hecbench_test(keogh-hip)
add_hecbench_test(sparkler-hip)
add_hecbench_test(matrix-rotate-hip)
add_hecbench_test(radixsort-hip)
add_hecbench_test(surfel-hip)
add_hecbench_test(sssp-hip)
add_hecbench_test(spm-hip)
add_hecbench_test(eigenvalue-hip)
add_hecbench_test(halo-finder-hip)
add_hecbench_test(metropolis-hip)
add_hecbench_test(atomicAggregate-hip)
add_hecbench_test(zmddft-hip)
add_hecbench_test(dxtc1-hip)
add_hecbench_test(mnist-hip)
add_hecbench_test(bsw-hip)
add_hecbench_test(chi2-hip)
add_hecbench_test(mf-sgd-hip)
add_hecbench_test(norm2-hip)
add_hecbench_test(sw4ck-hip)
add_hecbench_test(quicksort-hip)
add_hecbench_test(hmm-hip)
add_hecbench_test(daphne-hip)
add_hecbench_test(ising-hip)
add_hecbench_test(background-subtract-hip)
add_hecbench_test(doh-hip)
add_hecbench_test(hybridsort-hip)
add_hecbench_test(memcpy-hip)
add_hecbench_test(bh-hip)
add_hecbench_test(sad-hip)
add_hecbench_test(log2-hip)
add_hecbench_test(layout-hip)
add_hecbench_test(collision-hip)
add_hecbench_test(lfib4-hip)
add_hecbench_test(bitcracker-hip)
add_hecbench_test(flip-hip)
add_hecbench_test(ring-hip)
add_hecbench_test(che-hip)
add_hecbench_test(convolutionSeparable-hip)
add_hecbench_test(testSNAP-hip)
add_hecbench_test(dct8x8-hip)
add_hecbench_test(nonzero-hip)
add_hecbench_test(morphology-hip)
add_hecbench_test(zerocopy-hip)
add_hecbench_test(seam-carving-hip)
add_hecbench_test(minibude-hip)
add_hecbench_test(grrt-hip)
add_hecbench_test(lebesgue-hip)
add_hecbench_test(atomicCost-hip)
add_hecbench_test(secp256k1-hip)
add_hecbench_test(nlll-hip)
add_hecbench_test(aop-hip)
add_hecbench_test(scan-hip)
add_hecbench_test(rodrigues-hip)
add_hecbench_test(stencil3d-hip)
add_hecbench_test(aidw-hip)
add_hecbench_test(boxfilter-hip)
add_hecbench_test(bonds-hip)
add_hecbench_test(urng-hip)
add_hecbench_test(mtf-hip)
add_hecbench_test(nosync-hip)
add_hecbench_test(logprob-hip)
add_hecbench_test(mr-hip)
add_hecbench_test(matern-hip)
add_hecbench_test(keccaktreehash-hip)
add_hecbench_test(ccs-hip)
add_hecbench_test(adam-hip)
add_hecbench_test(goulash-hip)
add_hecbench_test(distort-hip)
add_hecbench_test(filter-hip)
add_hecbench_test(pns-hip)
add_hecbench_test(logan-hip)
add_hecbench_test(gelu-hip)
add_hecbench_test(overlap-hip)
add_hecbench_test(vanGenuchten-hip)
add_hecbench_test(dense-embedding-hip)
add_hecbench_test(saxpy-ompt-hip)
add_hecbench_test(segsort-hip)
add_hecbench_test(bmf-hip)
add_hecbench_test(murmurhash3-hip)
add_hecbench_test(clenergy-hip)
add_hecbench_test(bscan-hip)
add_hecbench_test(particlefilter-hip)
add_hecbench_test(dwconv-hip)
add_hecbench_test(wyllie-hip)
add_hecbench_test(lavaMD-hip)
add_hecbench_test(s3d-hip)
add_hecbench_test(fwt-hip)
add_hecbench_test(copy-hip)
add_hecbench_test(ans-hip)
add_hecbench_test(tc-hip)
add_hecbench_test(lci-hip)
add_hecbench_test(nqueen-hip)
add_hecbench_test(jaccard-hip)
add_hecbench_test(nms-hip)
add_hecbench_test(asta-hip)
add_hecbench_test(gaussian-hip)
add_hecbench_test(pnpoly-hip)
add_hecbench_test(minisweep-hip)
add_hecbench_test(attentionMultiHead-hip)
add_hecbench_test(voxelizer-hip)
add_hecbench_test(frechet-hip)
add_hecbench_test(romberg-hip)
add_hecbench_test(tsa-hip)
add_hecbench_test(histogram-hip)
add_hecbench_test(ne-hip)
add_hecbench_test(atomicCAS-hip)
add_hecbench_test(bezier-surface-hip)
add_hecbench_test(vol2col-hip)
add_hecbench_test(popcount-hip)
add_hecbench_test(mt-hip)
add_hecbench_test(perplexity-hip)
add_hecbench_test(compute-score-hip)
add_hecbench_test(rsc-hip)
add_hecbench_test(accuracy-hip)
add_hecbench_test(henry-hip)
add_hecbench_test(miniWeather-hip)
add_hecbench_test(sortKV-hip)
add_hecbench_test(overlay-hip)
add_hecbench_test(resnet-kernels-hip)
add_hecbench_test(tpacf-hip)
add_hecbench_test(maxpool3d-hip)
add_hecbench_test(channelShuffle-hip)
add_hecbench_test(merge-hip)
add_hecbench_test(crc64-hip)
add_hecbench_test(vmc-hip)
add_hecbench_test(bn-hip)
add_hecbench_test(frna-hip)
add_hecbench_test(hotspot3D-hip)
add_hecbench_test(remap-hip)
add_hecbench_test(chemv-hip)
add_hecbench_test(gamma-correction-hip)
add_hecbench_test(pad-hip)
add_hecbench_test(hotspot-hip)
add_hecbench_test(eikonal-hip)
add_hecbench_test(tensorAccessor-hip)
add_hecbench_test(ccsd-trpdrv-hip)
add_hecbench_test(resize-hip)
add_hecbench_test(f16sp-hip)
add_hecbench_test(particles-hip)
add_hecbench_test(atomicPerf-hip)
add_hecbench_test(sa-hip)
add_hecbench_test(mkl-sgemm-hip)
add_hecbench_test(stddev-hip)
add_hecbench_test(mcpr-hip)
add_hecbench_test(ace-hip)
add_hecbench_test(perlin-hip)
add_hecbench_test(page-rank-hip)
add_hecbench_test(tsp-hip)
add_hecbench_test(stsg-hip)
add_hecbench_test(concat-hip)
add_hecbench_test(hwt1d-hip)
add_hecbench_test(sph-hip)
add_hecbench_test(asmooth-hip)
add_hecbench_test(openmp-hip)