/*
 * Copyright 2019 Xilinx, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//#include "common/xf_headers.hpp"

#include "xf_houghlines_config.h"

#include "sw_canny0.h"

#include <iostream>


int main(int argc, char** argv) {

    // std::vector<float> outputrho(LINESMAX);
    // std::vector<float> outputtheta(LINESMAX);

    //float* outputrho = (float*)malloc(LINESMAX * sizeof(float));
    float* outputtheta = (float*)malloc(LINESMAX * sizeof(float));


//    houghlines_accel((ap_uint<PTR_WIDTH>*)sw_test_image_0, threshold, LINESMAX, outputrho, outputtheta, height, width);
    houghlines_accel((ap_uint<PTR_WIDTH>*)sw_test_image_0, outputtheta);

    FILE* fpre1 = fopen("HLSOUT.txt", "w");

    for (size_t i = 0; i < LINESMAX; i++) {
        fprintf(fpre1, "%f %f\n", outputtheta[i]);
        std::cout << outputtheta[i] << "\n";
    }

    fclose(fpre1);

    return 0;
}
