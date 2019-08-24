pragma solidity >=0.4.21 <0.6.0;

contract EvalFactory {
    mapping(address => address) public evals;

    function deploy() public {
        require(evals[msg.sender] == address(0), "Contract already instantiated");

        Eval2 newEvaluator = new Eval2(msg.sender);

        evals[msg.sender] = address(newEvaluator);
    }
}

contract Eval2 {
    address owner;

    constructor(address _owner) public {
        owner = _owner;
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

    function eval(bytes memory code, bytes memory data) public returns (bytes32) {
        bytes32 statusOk = 0x0;
        bytes32 statusError = 0x0000000000000000000000000000000000000000000000000000000000000001;

        if (statusOk == statusError) {
            revert();
        }

        Stack memory stack;
        VM memory vm = VM(code, data, 0, stack);

        while (true) {
            uint8 op = vmOp(vm);
            emit Log(op);

            if (op == 0x00) {
                break;
            }

            if (op == 0x01) {
                opAdd(vm);
                continue;
            }

            if (op == 0x03) {
                opSub(vm);
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


            if (op == 0x34) {
                opCallValue(vm);
                continue;
            }

            //            // BALANCE
            //            if (op == 0x31) {
            //                opBalance(vm);
            //                continue;
            //            }
            //
            //            // ORIGIN
            //            if (op == 0x32) {
            //                opOrigin(vm);
            //                continue;
            //            }
            //
            //            // CALLER
            //            if (op == 0x33) {
            //                opCaller(vm);
            //                continue;
            //            }

            if (op == 0x35) {
                opCallDataLoad(vm);
                continue;
            }

            if (op == 0x36) {
                opCallDataSize(vm);
                continue;
            }

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

            if (op == 0x56) {
                opJump(vm);
                continue;
            }

            if (op == 0x57) {
                opJumpi(vm);
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

            revert(appendUintToString("Invalid opcode: ", op));
        }

        //        return statusOk;
        return stackPop(vm.stack);
    }

    function opAdd(VM memory vm) private {
        int256 b = int256(stackPop(vm.stack));
        int256 a = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(a + b));
        vm.pc++;
    }

    function opSub(VM memory vm) private {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(a - b));
        vm.pc++;
    }

    function opLt(VM memory vm) private {
        uint256 a = uint256(stackPop(vm.stack));
        uint256 b = uint256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(uint256(a < b ? 1 : 0)));

        vm.pc++;
    }

    function opGt(VM memory vm) private {
        uint256 a = uint256(stackPop(vm.stack));
        uint256 b = uint256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(uint256(a > b ? 1 : 0)));

        vm.pc++;
    }

    function opSLT(VM memory vm) private {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(uint256(a < b ? 1 : 0)));

        vm.pc++;
    }

    function opSGT(VM memory vm) private {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(uint256(a > b ? 1 : 0)));

        vm.pc++;
    }

    function opEQ(VM memory vm) private {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(uint256(a == b ? 1 : 0)));

        vm.pc++;
    }

    function opIsZero(VM memory vm) private {
        int256 a = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(uint256(a == 0 ? 1 : 0)));

        vm.pc++;
    }

    function opAnd(VM memory vm) private {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(a & b));

        vm.pc++;
    }

    function opOr(VM memory vm) private {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(a | b));

        vm.pc++;
    }

    function opXor(VM memory vm) private {
        int256 a = int256(stackPop(vm.stack));
        int256 b = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(a ^ b));

        vm.pc++;
    }

    function opNot(VM memory vm) private {
        int256 a = int256(stackPop(vm.stack));

        stackPush(vm.stack, bytes32(~a));

        vm.pc++;
    }

    function opCallValue(VM memory vm) private {
        stackPush(vm.stack, bytes32(msg.value));
        vm.pc++;
    }

    function opCallDataLoad(VM memory vm) private {
        uint256 idx = uint256(stackPop(vm.stack));

        stackPush(vm.stack, bytesToBytes32(vm.data, idx));

        vm.pc++;
    }

    function opCallDataSize(VM memory vm) private {
        stackPush(vm.stack, bytes32(vm.data.length));
        vm.pc++;
    }

    function opPop(VM memory vm) private {
        stackPop(vm.stack);
        vm.pc++;
    }

    function opMLoad(VM memory vm) private {
        uint256 offset = uint256(stackPop(vm.stack));

        uint256 ret;
        assembly {
            ret := mload(offset)
        }

        stackPush(vm.stack, bytes32(ret));
        vm.pc++;
    }

    function opMStore(VM memory vm) private {
        uint256 offset = uint256(stackPop(vm.stack));
        uint256 value = uint256(stackPop(vm.stack));

        assembly {
            mstore(offset, value)
        }

        vm.pc++;
    }

    function opJump(VM memory vm) private {
        uint256 destination = uint256(stackPop(vm.stack));

        vm.pc = destination;
    }

    function opJumpi(VM memory vm) private {
        uint256 destination = uint256(stackPop(vm.stack));
        uint256 condition = uint256(stackPop(vm.stack));

        if (condition > 0) {
            vm.pc = destination;
            return;
        }

        vm.pc++;
    }

    function opJumpdest(VM memory vm) private {
        vm.pc++;
    }

    function opPush(VM memory vm) private {
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

    function opDup(VM memory vm) private {
        uint8 dupOp = vmOp(vm);

        uint8 idx = dupOp - 0x80;

        stackPush(vm.stack, stackPeek(vm.stack, idx));
        vm.pc++;
    }

    function opSwap(VM memory vm) private {
        uint8 swapOp = vmOp(vm);

        uint8 idx = swapOp - 0x90 + 1;

        stackSwap(vm.stack, 0, idx);

        vm.pc++;
    }

    function vmOp(VM memory vm) private returns (uint8) {
        return uint8(vm.code[vm.pc]);
    }

    function stackPush(Stack memory stack, bytes32 item) private {
        stack.data[stack.height++] = item;
    }

    function stackPop(Stack memory stack) private returns (bytes32) {
        return stack.data[--stack.height];
    }

    function stackSwap(Stack memory stack, uint8 idx1, uint8 idx2) private {
        bytes32 a = stack.data[stack.height - idx1];
        bytes32 b = stack.data[stack.height - idx2];

        stack.data[idx1] = b;
        stack.data[idx2] = a;
    }

    function stackPeek(Stack memory stack, uint8 idx) private returns (bytes32) {
        return stack.data[stack.height - idx - 1];
    }

    // UTIL
    function bytesToBytes32(uint _offst, bytes memory _input, bytes32 _output) internal pure {
        assembly {
            mstore(_output, add(_input, _offst))
            mstore(add(_output, 32), add(add(_input, _offst), 32))
        }
    }

    function bytesToBytes32(bytes memory data, uint offset) private pure returns (bytes32) {
        bytes32 out;

        assembly {
            mstore(out, add(data, offset))
            mstore(add(out, 32), add(add(data, offset), 32))
        }

        return out;
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
