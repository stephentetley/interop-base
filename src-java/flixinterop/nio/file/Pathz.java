/*
 * Copyright 2022 Stephen Tetley
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

package flixinterop.nio.file;

import java.nio.file.Path;
import java.util.ArrayList;

public final class Pathz {

    public static Path ofArrayList(String first, ArrayList<String> more) throws Exception {
        String[] args = new String[more.size()];
        args = more.toArray(args);
        return Path.of(first, args);
    }

}
