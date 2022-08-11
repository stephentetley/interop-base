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


namespace Interop/Lang {

    pub enum ProcessBuilder[_: Region](##java.lang.ProcessBuilder)


}


namespace Interop/Lang/ProcessBuilder {

    use Interop/Lang.ProcessBuilder;
    use Interop/Lang.ProcessBuilder.{ProcessBuilder};

    use Interop/NIO/File.Path;
    use Interop/NIO/File.Path.{Path};
    use Interop/Lang.Process;
    use Interop/Lang.Process.{Process};


    pub def getHH(x: ProcessBuilder[r]): ##java.lang.ProcessBuilder = 
        let ProcessBuilder(x1) = x;
        x1


}
