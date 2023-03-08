/*
 * Copyright 2023 Stephen Tetley
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package flixinterop.text;

import java.text.ChoiceFormat;
import java.util.List;

public final class ChoiceFormatz {

    public static ChoiceFormat newChoiceFormat(List<Double> limits, List<String> formats) throws Exception {
        double[] arrlimits = new double[limits.size()];
        String[] arrformats = new String[formats.size()];
        arrlimits = limits.stream().mapToDouble(Double::doubleValue).toArray();
        arrformats = formats.toArray(arrformats);
        return new ChoiceFormat(arrlimits, arrformats);
    }

}
