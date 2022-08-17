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


namespace Interop/Flix/WrappedRegion {


    /// Flix cannot currently handle complex instances, must make a wrapper for each 
    /// type used...

    /// pub enum WrappedRegion[t: Type, _: Region] with Eq, Order, ToString { 
    ///     case WrappedRegion(t) 
    /// }

    /// instance Scoped[WrappedRegion[t]] {
    ///     pub def regionOf(_: WrappedRegion[t, r]): Region[r] = () as Region[r]
    /// }

    /// ///
    /// /// Returns a new mutable WrappedRegion.
    /// ///
    /// pub def new(_: Region[r], a: t): WrappedRegion[t, r] \ Write(r) = WrappedRegion(a) as \ Write(r)


    ///
    /// Wrap String with a REgion so it can implement ImpCharSequence, ImpAppendable...
    /// 
    pub enum StringWithRegion[_: Region] with Eq, Order, ToString { 
        case StringWithRegion(String) 
    }


    instance Scoped[StringWithRegion] {
        pub def regionOf(_: StringWithRegion[r]): Region[r] = () as Region[r]
    }


    ///
    /// Returns a StringWithRegion.
    ///
    pub def mkStringWithRegion(_: Region[r], s: String): StringWithRegion[r] \ Write(r) = StringWithRegion(s) as \ Write(r)



}
