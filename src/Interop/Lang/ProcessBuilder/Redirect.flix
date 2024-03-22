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

mod Interop.Lang.ProcessBuilder {

    ///
    /// Represents a Redirect.
    /// Immutable
    ///
    pub enum Redirect(##java.lang.ProcessBuilder$Redirect)



}

mod Interop.Lang.ProcessBuilder.Redirect {


    use Interop.Lang.ProcessBuilder.Redirect;
    use Interop.Lang.ProcessBuilder.Redirect.{Redirect};


    pub def getHH(m: Redirect): ##java.lang.ProcessBuilder$Redirect = 
        let Redirect(m1) = m;
        m1

    pub def equals(x: Redirect, y: Redirect): Bool =
        import java.lang.ProcessBuilder$Redirect.equals(##java.lang.Object): Bool \ {};
        let Redirect(x1) = x;
        let Redirect(y1) = y;
        equals(x1, checked_cast(y1))


    pub def discardz(): Redirect = 
        import static java_get_field java.lang.ProcessBuilder$Redirect.DISCARD: ##java.lang.ProcessBuilder$Redirect \ {} as get_DISCARD;
        get_DISCARD() |> Redirect

    pub def inherit(): Redirect = 
        import static java_get_field java.lang.ProcessBuilder$Redirect.INHERIT: ##java.lang.ProcessBuilder$Redirect \ {} as get_INHERIT;
        get_INHERIT() |> Redirect

    pub def pipe(): Redirect = 
        import static java_get_field java.lang.ProcessBuilder$Redirect.PIPE: ##java.lang.ProcessBuilder$Redirect \ {} as get_PIPE;
        get_PIPE() |> Redirect

}
