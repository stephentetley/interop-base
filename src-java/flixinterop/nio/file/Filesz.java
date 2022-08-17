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

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.OpenOption;
import java.nio.file.Path;
import java.util.List;

public final class Filesz {

    public static Path writeString(Path path, CharSequence csq, Charset cs, List<OpenOption> options) throws Exception {
        OpenOption[] args = new OpenOption[options.size()];
        args = options.toArray(args);
        return Files.writeString(path, csq, cs, args);
    }

    public static Path writeString(Path path, CharSequence csq, List<OpenOption> options) throws Exception {
        OpenOption[] args = new OpenOption[options.size()];
        args = options.toArray(args);
        return Files.writeString(path, csq, args);
    }

}
