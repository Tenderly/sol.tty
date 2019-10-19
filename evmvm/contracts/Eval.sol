pragma solidity ^0.5.11;

contract EvalFactory {
    mapping(address => address) public evals;

    function deploy() public {
        require(evals[msg.sender] == address(0), "Contract already instantiated");

        Eval newEvaluator = new Eval(msg.sender);

        evals[msg.sender] = address(newEvaluator);
    }
}

contract Eval {
    event Log(uint256 statuscode);

    struct Stack {
        bytes32[1024] data;
        uint256 height;
    }

    struct VM {
        bytes code;
        bytes data;
        uint256 pc;

        Stack stack;
    }

    address owner;

    constructor(address _owner) public {
        owner = _owner;
    }

    function() external payable {
    }

    function eval(bytes memory code, bytes memory data) public payable returns (bytes32) {
        Stack memory stack;
        VM memory vm = VM(code, data, 0, stack);

        while (true) {
            uint8 op = vmOp(vm);
            //                        if (vm.pc == 359) {
            //                                                stackPop(vm.stack);
            //                            return stackPop(vm.stack);
            //                return bytes32(uint256(op));
            //                        }

            if (op == 0x00) {
                break;
            }

            if (op == 0x01) {
                opAdd(vm);
                continue;
            }

            if (op == 0x02) {
                opMul(vm);
                continue;
            }

            if (op == 0x03) {
                opSub(vm);
                continue;
            }

            if (op == 0x04) {
                opDiv(vm);
                continue;
            }

            if (op == 0x05) {
                opSdiv(vm);
                continue;
            }

            if (op == 0x06) {
                opMod(vm);
                continue;
            }

            if (op == 0x07) {
                opSMod(vm);
                continue;
            }
            if (op == 0x08) {
                opAddMod(vm);
                continue;
            }
            if (op == 0x09) {
                opMulMod(vm);
                continue;
            }
            if (op == 0x0a) {
                opExp(vm);
                continue;
            }
            if (op == 0x0b) {
                opSignExtend(vm);
                continue;
            }

            if (op == 0x10) {
                opLt(vm);
                continue;
            }

            if (op == 0x11) {
                opGt(vm);
                continue;
            }

            if (op == 0x12) {
                opSLT(vm);
                continue;
            }

            if (op == 0x13) {
                opSGT(vm);
                continue;
            }

            if (op == 0x14) {
                opEQ(vm);
                continue;
            }

            if (op == 0x15) {
                opIsZero(vm);
                continue;
            }

            if (op == 0x16) {
                opAnd(vm);
                continue;
            }

            if (op == 0x17) {
                opOr(vm);
                continue;
            }

            if (op == 0x18) {
                opXor(vm);
                continue;
            }

            if (op == 0x19) {
                opNot(vm);
                continue;
            }

            if (op == 0x1a) {
                opByte(vm);
                continue;
            }

            if (op == 0x1b) {
                opShl(vm);
                continue;
            }

            if (op == 0x1c) {
                opShr(vm);
                continue;
            }

            if (op == 0x1d) {
                opSar(vm);
                continue;
            }

            if (op == 0x20) {
                opSha3(vm);
                continue;
            }

            if (op == 0x30) {
                opAddress(vm);
                continue;
            }

            if (op == 0x31) {
                opBalance(vm);
                continue;
            }

            if (op == 0x32) {
                opOrigin(vm);
                continue;
            }
            if (op == 0x33) {
                opCaller(vm);
                continue;
            }

            if (op == 0x34) {
                opCallValue(vm);
                continue;
            }

            if (op == 0x35) {
                opCallDataLoad(vm);
                continue;
            }

            if (op == 0x36) {
                opCallDataSize(vm);
                continue;
            }

            //@TODO: 0x37 CALLDATACOPY

            if (op == 0x38) {
                opCodeSize(vm);
                continue;
            }

            if (op == 0x39) {
                opCodeCopy(vm);
                continue;
            }

            //@TODO 0x3a GASPRICE

            if (op == 0x3B) {
                opExtCodeSize(vm);
                continue;
            }

            //@TODO: 0x3c EXTCODECOPY

            if (op == 0x3D) {
                opReturnDataSize(vm);
                continue;
            }

            if (op == 0x3E) {
                opReturnDataCopy(vm);
                continue;
            }

            //            0x40	BLOCKHASH	Get the hash of one of the 256 most recent complete blocks	-	20
            //        0x41	COINBASE	Get the block's beneficiary address	-	2
            //        0x42	TIMESTAMP	Get the block's timestamp	-	2
            //        0x43	NUMBER	Get the block's number	-	2
            //        0x44	DIFFICULTY	Get the block's difficulty	-	2
            //        0x45	GASLIMIT	Get the block's gas limit	-	2

            if (op == 0x50) {
                opPop(vm);
                continue;
            }

            if (op == 0x51) {
                opMLoad(vm);
                continue;
            }

            if (op == 0x52) {
                opMStore(vm);
                continue;
            }

            //0x53	MSTORE8	Save byte to memory	-	3

            //            0x54	SLOAD	Load word from storage	-	200
            //        0x55	SSTORE	Save word to storage	-	20000**

            if (op == 0x56) {
                opJump(vm);
                continue;
            }

            if (op == 0x57) {
                opJumpi(vm);
                continue;
            }

            //            0x58	GETPC	Get the value of the program counter prior to the increment	-	2
            //        0x59	MSIZE	Get the size of active memory in bytes	-	2

            if (op == 0x5a) {
                opGas(vm);
                continue;
            }

            if (op == 0x5b) {
                opJumpdest(vm);
                continue;
            }

            if (op >= 0x60 && op <= 0x7F) {
                opPush(vm);
                continue;
            }

            if (op >= 0x80 && op <= 0x8F) {
                opDup(vm);
                continue;
            }

            if (op >= 0x90 && op <= 0x9F) {
                opSwap(vm);
                continue;
            }

            if (op == 0xa0) {
                opLog0(vm);
                continue;
            }

            if (op == 0xa1) {
                opLog1(vm);
                continue;
            }

            if (op == 0xa2) {
                opLog2(vm);
                continue;
            }

            if (op == 0xa3) {
                opLog3(vm);
                continue;
            }

            if (op == 0xa4) {
                opLog4(vm);
                continue;
            }

            if (op == 0xF0) {
                opCreate(vm);
                continue;
            }

            if (op == 0xF1) {
                opCall(vm);
                continue;
            }

            if (op == 0xF2) {
                opCallCode(vm);
                continue;
            }

            if (op == 0xF3) {
                opReturn(vm);
                continue;
            }

            if (op == 0xF4) {
                opDelegateCall(vm);
                continue;
            }

            if (op == 0xFA) {
                opStaticCall(vm);
                continue;
            }

            if (op == 0xFD) {
                opRevert(vm);
                continue;
            }

            if (op == 0xFF) {
                opSelfDestruct(vm);
                continue;
            }

            revert(appendUintToString("Invalid opcode at PC: ", vm.pc));
        }

        return bytes32(uint256(0x0));
    }

    function opAdd(VM memory vm) private pure {
        int256 b = int256(stackPop(vm.stack));
        int256 a = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(a + b));
        vm.pc++;
    }

    function opMul(VM memory vm) private pure {
        int256 b = int256(stackPop(vm.stack));
        int256 a = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(a * b));
        vm.pc++;
    }

    function opSub(VM memory vm) private pure {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(a - b));
        vm.pc++;
    }

    function opDiv(VM memory vm) private pure {
        uint256 a = uint256(stackPop(vm.stack));
        uint256 b = uint256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(uint256(a / b)));
        vm.pc++;
    }

    function opSdiv(VM memory vm) private pure {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(a / b));
        vm.pc++;
    }

    function opMod(VM memory vm) private pure {
        uint256 a = uint256(stackPop(vm.stack));
        uint256 b = uint256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(a % b));
        vm.pc++;
    }

    function opSMod(VM memory vm) private pure {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(a % b));
        vm.pc++;
    }

    function opAddMod(VM memory vm) private pure {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));
        int256 n = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32((a + b) % n));
        vm.pc++;
    }

    function opMulMod(VM memory vm) private pure {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));
        int256 n = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32((a * b) % n));
        vm.pc++;
    }

    function opExp(VM memory vm) private pure {
        uint256 a = uint256(stackPop(vm.stack));
        uint256 b = uint256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(a ** b));
        vm.pc++;
    }

    function opSignExtend(VM memory vm) private pure {
        int256 b = int256(stackPop(vm.stack));
        int256 x = int256(stackPop(vm.stack));

        int256 res;
        assembly {res := signextend(x, b)}

        stackPush(vm.stack, bytes32(res));
        vm.pc++;
    }

    function opLt(VM memory vm) private pure {
        uint256 a = uint256(stackPop(vm.stack));
        uint256 b = uint256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(uint256(a < b ? 1 : 0)));

        vm.pc++;
    }

    function opGt(VM memory vm) private pure {
        uint256 a = uint256(stackPop(vm.stack));
        uint256 b = uint256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(uint256(a > b ? 1 : 0)));

        vm.pc++;
    }

    function opSLT(VM memory vm) private pure {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(uint256(a < b ? 1 : 0)));

        vm.pc++;
    }

    function opSGT(VM memory vm) private pure {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(uint256(a > b ? 1 : 0)));

        vm.pc++;
    }

    function opEQ(VM memory vm) private pure {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(uint256(a == b ? 1 : 0)));

        vm.pc++;
    }

    function opIsZero(VM memory vm) private pure {
        int256 a = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(uint256(a == 0 ? 1 : 0)));

        vm.pc++;
    }

    function opAnd(VM memory vm) private pure {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(a & b));

        vm.pc++;
    }

    function opOr(VM memory vm) private pure {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(a | b));

        vm.pc++;
    }

    function opXor(VM memory vm) private pure {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(a ^ b));

        vm.pc++;
    }

    function opNot(VM memory vm) private pure {
        int256 a = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(~a));

        vm.pc++;
    }

    function opByte(VM memory vm) private pure {
        int256 i = int256(stackPop(vm.stack));
        int256 x = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32((x >> (248 - i * 8)) & 0xFF));

        vm.pc++;
    }

    function opShl(VM memory vm) private pure {
        uint256 a = uint256(stackPop(vm.stack));
        uint256 b = uint256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(b << a));

        vm.pc++;
    }

    function opShr(VM memory vm) private pure {
        uint256 a = uint256(stackPop(vm.stack));
        uint256 b = uint256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(b >> a));

        vm.pc++;
    }

    function opSar(VM memory vm) private pure {
        uint256 a = uint256(stackPop(vm.stack));
        uint256 b = uint256(stackPop(vm.stack));

        uint256 res;
        assembly {res := sar(a, b)}

        stackPush(vm.stack, bytes32(res));

        vm.pc++;
    }

    function opSha3(VM memory vm) private pure {
        uint256 offset = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 length = uint256(stackPop(vm.stack));

        uint256 res;
        assembly {res := keccak256(offset, length)}

        stackPush(vm.stack, bytes32(res));

        vm.pc++;
    }

    function opAddress(VM memory vm) private view {
        // This will insert the proper bytes32 value to stack, but we will cheat a bit and try to not do any shifting.
        // stackPush(vm.stack, bytes32(uint256(address(this)) << 96));
        stackPush(vm.stack, bytes32(uint256(address(this))));

        vm.pc++;
    }

    function opBalance(VM memory vm) private view {
        address addr = address(uint256(stackPop(vm.stack)));

        stackPush(vm.stack, bytes32(addr.balance));

        vm.pc++;
    }

    function opOrigin(VM memory vm) private view {
        stackPush(vm.stack, bytes32(uint256(tx.origin)));

        vm.pc++;
    }

    function opCaller(VM memory vm) private view {
        stackPush(vm.stack, bytes32(uint256(msg.sender)));

        vm.pc++;
    }

    function opCallValue(VM memory vm) private view {
        stackPush(vm.stack, bytes32(msg.value));
        vm.pc++;
    }

    function opCallDataLoad(VM memory vm) private pure {
        uint256 idx = uint256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(bytesToBytes32(vm.data, idx)));

        vm.pc++;
    }

    function opCallDataSize(VM memory vm) private pure {
        stackPush(vm.stack, bytes32(vm.data.length));
        vm.pc++;
    }

    function opCodeSize(VM memory vm) private pure {
        stackPush(vm.stack, bytes32(vm.code.length));

        vm.pc++;
    }

    function opCodeCopy(VM memory vm) private pure {
        uint256 destOffset = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 offset = uint256(stackPop(vm.stack));
        uint256 length = uint256(stackPop(vm.stack));

        uint loops = (length + 31) / 32;
        assembly{mstore(destOffset, length)}
        for (uint i = 0; i < loops; i++) {
            bytes32 data = bytes32(bytesToBytes32(vm.code, offset + i * 32));
            assembly {
                mstore(add(destOffset, mul(32, add(1, i))), data)
            }
        }

        vm.pc++;
    }

    function opExtCodeSize(VM memory vm) private view {
        address addr = address(uint256(stackPop(vm.stack)));

        uint256 size;
        assembly {size := extcodesize(addr)}
        stackPush(vm.stack, bytes32(size));

        vm.pc++;
    }

    function opReturnDataSize(VM memory vm) private pure {
        uint256 size;
        assembly {size := returndatasize()}
        stackPush(vm.stack, bytes32(size));

        vm.pc++;
    }

    function opReturnDataCopy(VM memory vm) private pure {
        uint256 destOffset = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 offset = uint256(stackPop(vm.stack));
        uint256 length = uint256(stackPop(vm.stack));

        assembly {returndatacopy(destOffset, offset, length)}

        vm.pc++;
    }

    function opPop(VM memory vm) private pure {
        stackPop(vm.stack);
        vm.pc++;
    }

    function opMLoad(VM memory vm) private pure {
        uint256 offset = uint256(stackPop(vm.stack)) + 0x10000;

        uint256 ret;
        assembly {
            ret := mload(offset)
        }

        stackPush(vm.stack, bytes32(ret));
        vm.pc++;
    }

    function opMStore(VM memory vm) private pure {
        uint256 offsetVal = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 valueVal = uint256(stackPop(vm.stack));

        assembly {
            mstore(offsetVal, valueVal)
        }

        vm.pc++;
    }

    function opJump(VM memory vm) private pure {
        uint256 destination = uint256(stackPop(vm.stack));

        vm.pc = destination;
    }

    function opJumpi(VM memory vm) private pure {
        uint256 destination = uint256(stackPop(vm.stack));
        uint256 condition = uint256(stackPop(vm.stack));

        if (condition > 0) {
            vm.pc = destination;
            return;
        }

        vm.pc++;
    }

    function opGas(VM memory vm) private view {
        uint256 gasLeft;
        assembly {gasLeft := gas()}
        stackPush(vm.stack, bytes32(gasLeft));

        vm.pc++;
    }

    function opJumpdest(VM memory vm) private pure {
        vm.pc++;
    }

    function opPush(VM memory vm) private pure {
        uint8 pushOp = vmOp(vm);

        uint8 size = pushOp - 0x60 + 1;

        uint256 val = 0x0;
        for (uint8 j = 1; j <= size; j++) {
            val = val * 256 + uint8(vm.code[vm.pc + j]);
        }

        // Right-pad
        // val = val * (256 ** uint256(32 - size));

        stackPush(vm.stack, bytes32(val));
        vm.pc += size + 1;
    }

    function opDup(VM memory vm) private pure {
        uint8 dupOp = vmOp(vm);

        uint8 idx = dupOp - 0x80;

        stackPush(vm.stack, stackPeek(vm.stack, idx));
        vm.pc++;
    }

    function opSwap(VM memory vm) private pure {
        uint8 swapOp = vmOp(vm);

        uint8 idx = swapOp - 0x90 + 1;

        stackSwap(vm.stack, 0, idx);

        vm.pc++;
    }

    function opLog0(VM memory vm) private {
        uint256 dataOffset = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 dataSize = uint256(stackPop(vm.stack));

        assembly { log0(dataOffset, dataSize) }

        vm.pc++;
    }

    function opLog1(VM memory vm) private {
        uint256 dataOffset = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 dataSize = uint256(stackPop(vm.stack));
        bytes32 topic1 = stackPop(vm.stack);

        assembly { log1(dataOffset, dataSize, topic1) }

        vm.pc++;
    }

    function opLog2(VM memory vm) private {
        uint256 dataOffset = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 dataSize = uint256(stackPop(vm.stack));
        bytes32 topic1 = stackPop(vm.stack);
        bytes32 topic2 = stackPop(vm.stack);

        assembly { log2(dataOffset, dataSize, topic1, topic2) }

        vm.pc++;
    }

    function opLog3(VM memory vm) private {
        uint256 dataOffset = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 dataSize = uint256(stackPop(vm.stack));
        bytes32 topic1 = stackPop(vm.stack);
        bytes32 topic2 = stackPop(vm.stack);
        bytes32 topic3 = stackPop(vm.stack);

        assembly { log3(dataOffset, dataSize, topic1, topic2, topic3) }

        vm.pc++;
    }

    function opLog4(VM memory vm) private {
        uint256 dataOffset = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 dataSize = uint256(stackPop(vm.stack));
        bytes32 topic1 = stackPop(vm.stack);
        bytes32 topic2 = stackPop(vm.stack);
        bytes32 topic3 = stackPop(vm.stack);
        bytes32 topic4 = stackPop(vm.stack);

        assembly { log4(dataOffset, dataSize, topic1, topic2, topic3, topic4) }

        vm.pc++;
    }

    function opCreate(VM memory vm) private {
        uint256 value = uint256(stackPop(vm.stack));
        uint256 offset = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 length = uint256(stackPop(vm.stack));

        //@TODO: Test this.
        address addr;
        assembly {addr := create(value, offset, length)}

        stackPush(vm.stack, bytes32(uint256(addr)));

        vm.pc++;
    }

    function opCall(VM memory vm) private {
        uint256 gasVal = uint256(stackPop(vm.stack));
        uint256 addrVal = uint256(stackPop(vm.stack)) << 96;
        uint256 valueVal = uint256(stackPop(vm.stack));
        uint256 argsOffsetVal = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 argsLengthVal = uint256(stackPop(vm.stack));
        uint256 retOffsetVal = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 retLengthVal = uint256(stackPop(vm.stack));

        bool success;
        assembly {success := call(gasVal, addrVal, valueVal, argsOffsetVal, argsLengthVal, retOffsetVal, retLengthVal)}

        stackPush(vm.stack, bytes32(uint256(success ? 0x1 : 0x0)));

        vm.pc++;
    }

    function opCallCode(VM memory vm) private {
        uint256 gasVal = uint256(stackPop(vm.stack));
        uint256 addrVal = uint256(stackPop(vm.stack)) << 96;
        uint256 valueVal = uint256(stackPop(vm.stack));
        uint256 argsOffsetVal = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 argsLengthVal = uint256(stackPop(vm.stack));
        uint256 retOffsetVal = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 retLengthVal = uint256(stackPop(vm.stack));

        bool success;
        assembly {success := callcode(gasVal, addrVal, valueVal, argsOffsetVal, argsLengthVal, retOffsetVal, retLengthVal)}

        stackPush(vm.stack, bytes32(uint256(success ? 0x1 : 0x0)));

        vm.pc++;
    }

    function opReturn(VM memory vm) private pure {
        uint256 offset = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 length = uint256(stackPop(vm.stack));

        assembly {return (offset, length)}
    }

    function opDelegateCall(VM memory vm) private {
        uint256 gasVal = uint256(stackPop(vm.stack));
        uint256 addrVal = uint256(stackPop(vm.stack)) << 96;
        uint256 argsOffsetVal = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 argsLengthVal = uint256(stackPop(vm.stack));
        uint256 retOffsetVal = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 retLengthVal = uint256(stackPop(vm.stack));

        bool success;
        assembly {success := delegatecall(gasVal, addrVal, argsOffsetVal, argsLengthVal, retOffsetVal, retLengthVal)}

        stackPush(vm.stack, bytes32(uint256(success ? 0x1 : 0x0)));

        vm.pc++;
    }

    function opStaticCall(VM memory vm) private view {
        uint256 gasVal = uint256(stackPop(vm.stack));
        uint256 addrVal = uint256(stackPop(vm.stack)) << 96;
        uint256 argsOffsetVal = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 argsLengthVal = uint256(stackPop(vm.stack));
        uint256 retOffsetVal = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 retLengthVal = uint256(stackPop(vm.stack));

        bool success;
        assembly {success := staticcall(gasVal, addrVal, argsOffsetVal, argsLengthVal, retOffsetVal, retLengthVal)}

        stackPush(vm.stack, bytes32(uint256(success ? 0x1 : 0x0)));

        vm.pc++;
    }

    function opRevert(VM memory vm) private pure {
        uint256 offset = uint256(stackPop(vm.stack)) + 0x10000;
        uint256 length = uint256(stackPop(vm.stack));

        assembly {revert(offset, length)}

        vm.pc++;
    }

    function opSelfDestruct(VM memory vm) private {
        uint256 addrVal = uint256(stackPop(vm.stack)) << 96;

        assembly {selfdestruct(addrVal)}

        vm.pc++;
    }

    function vmOp(VM memory vm) private pure returns (uint8) {
        return uint8(vm.code[vm.pc]);
    }

    function stackPush(Stack memory stack, bytes32 item) private pure {
        stack.data[stack.height++] = item;
    }

    function stackPop(Stack memory stack) private pure returns (bytes32) {
        return stack.data[--stack.height];
    }

    function stackSwap(Stack memory stack, uint8 idx1, uint8 idx2) private pure {
        bytes32 a = stack.data[stack.height - 1 - idx1];
        bytes32 b = stack.data[stack.height - 1 - idx2];

        stack.data[stack.height - 1 - idx1] = b;
        stack.data[stack.height - 1 - idx2] = a;
    }

    function stackPeek(Stack memory stack, uint8 idx) private pure returns (bytes32) {
        return stack.data[stack.height - idx - 1];
    }

    // UTIL
    function bytesToBytes32(bytes memory data, uint offset) private pure returns (uint256) {
        uint256 x;
        assembly {
            x := mload(add(data, add(0x20, offset)))
        }
        return x;
    }


    // DEBUGGING
    function uintToString(uint v) private pure returns (string memory str) {
        uint maxlength = 100;
        bytes memory reversed = new bytes(maxlength);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = byte(uint8(48 + remainder));
        }
        bytes memory s = new bytes(i);
        for (uint j = 0; j < i; j++) {
            s[j] = reversed[i - 1 - j];
        }
        str = string(s);
    }

    function appendUintToString(string memory inStr, uint v) private pure returns (string memory str) {
        uint maxlength = 100;
        bytes memory reversed = new bytes(maxlength);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = byte(uint8(48 + remainder));
        }
        bytes memory inStrb = bytes(inStr);
        bytes memory s = new bytes(inStrb.length + i);
        uint j;
        for (j = 0; j < inStrb.length; j++) {
            s[j] = inStrb[j];
        }
        for (j = 0; j < i; j++) {
            s[j + inStrb.length] = reversed[i - 1 - j];
        }
        str = string(s);
    }
}
