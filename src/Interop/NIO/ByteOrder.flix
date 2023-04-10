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


mod Interop.NIO {

    pub enum ByteOrder(##java.nio.ByteOrder)

}

mod Interop.NIO.ByteOrder { 

    use Interop.NIO.ByteOrder;
    use Interop.NIO.ByteOrder.{ByteOrder};

    pub def getHH(x: ByteOrder): ##java.nio.ByteOrder = 
        let ByteOrder(x1) = x;
        x1

    // Predates Enum

    pub def big_endian(): ByteOrder = 
        import static get java.nio.ByteOrder.BIG_ENDIAN: ##java.nio.ByteOrder \ {} as get_BIG_ENDIAN;
        get_BIG_ENDIAN() |> ByteOrder


    pub def little_endian(): ByteOrder = 
        import static get java.nio.ByteOrder.LITTLE_ENDIAN: ##java.nio.ByteOrder \ {} as get_LITTLE_ENDIAN;
        get_LITTLE_ENDIAN() |> ByteOrder


    pub def nativeOrder(): ByteOrder \ IO = 
        import static java.nio.ByteOrder.nativeOrder(): ##java.nio.ByteOrder \ IO;
        nativeOrder() |> ByteOrder


    pub def toString(bo: ByteOrder): String = 
        import java.nio.ByteOrder.toString(): String \ {};
        let ByteOrder(bo1) = bo;
        toString(bo1)

}
