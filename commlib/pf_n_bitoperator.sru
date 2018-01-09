HA$PBExportHeader$pf_n_bitoperator.sru
$PBExportComments$$$HEX22$$44beb8d2f0c5b0c0200030aea5b244c72000c0c9d0c658d594b2200024c60cbe1dc8b8d2200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_n_bitoperator from pf_n_nonvisualobject
end type
end forward

global type pf_n_bitoperator from pf_n_nonvisualobject
end type
global pf_n_bitoperator pf_n_bitoperator

type prototypes
function uint pf_BitwiseOR_uint(uint op1, uint op2) library "pentalib.dll"
function ulong pf_BitwiseOR_ulong(ulong op1, ulong op2) library "pentalib.dll"
function uint pf_BitwiseAND_uint(uint op1, uint op2) library "pentalib.dll"
function ulong pf_BitwiseAND_ulong(ulong op1, ulong op2) library "pentalib.dll"
function uint pf_BitwiseXOR_uint(uint op1, uint op2) library "pentalib.dll"
function ulong pf_BitwiseXOR_ulong(ulong op1, ulong op2) library "pentalib.dll"
function uint pf_BitwiseNOT_uint(uint op1) library "pentalib.dll"
function ulong pf_BitwiseNOT_ulong(ulong op1) library "pentalib.dll"
function uint pf_BitwiseRShift_uint(uint op1, int cnt) library "pentalib.dll"
function ulong pf_BitwiseRShift_ulong(ulong op1, int cnt) library "pentalib.dll"
function uint pf_BitwiseLShift_uint(uint op1, int cnt) library "pentalib.dll"
function ulong pf_BitwiseLShift_ulong(ulong op1, int cnt) library "pentalib.dll"

end prototypes

type variables

end variables

forward prototypes
public function unsignedinteger of_bitwiseand (unsignedinteger ai_op1, unsignedinteger ai_op2)
public function unsignedlong of_bitwiseand (unsignedlong al_op1, unsignedlong al_op2)
public function unsignedinteger of_bitwiseor (unsignedinteger ai_op1, unsignedinteger ai_op2)
public function unsignedlong of_bitwiseor (unsignedlong al_op1, unsignedlong al_op2)
public function unsignedinteger of_bitwisexor (unsignedinteger ai_op1, unsignedinteger ai_op2)
public function unsignedlong of_bitwisexor (unsignedlong al_op1, unsignedlong al_op2)
public function unsignedinteger of_bitwisenot (unsignedinteger ai_op1)
public function unsignedlong of_bitwisenot (unsignedlong al_op1)
public function unsignedinteger of_rightshift (unsignedinteger ai_op1, integer ai_cnt)
public function unsignedlong of_rightshift (unsignedlong al_op1, integer ai_cnt)
public function unsignedinteger of_leftshift (unsignedinteger ai_op1, integer ai_cnt)
public function unsignedlong of_leftshift (unsignedlong al_op1, integer ai_cnt)
end prototypes

public function unsignedinteger of_bitwiseand (unsignedinteger ai_op1, unsignedinteger ai_op2);return pf_bitwiseand_uint(ai_op1, ai_op2)

end function

public function unsignedlong of_bitwiseand (unsignedlong al_op1, unsignedlong al_op2);return pf_bitwiseand_ulong(al_op1, al_op2)

end function

public function unsignedinteger of_bitwiseor (unsignedinteger ai_op1, unsignedinteger ai_op2);return pf_bitwiseor_uint(ai_op1, ai_op2)

end function

public function unsignedlong of_bitwiseor (unsignedlong al_op1, unsignedlong al_op2);return pf_bitwiseor_ulong(al_op1, al_op2)

end function

public function unsignedinteger of_bitwisexor (unsignedinteger ai_op1, unsignedinteger ai_op2);return pf_bitwisexor_uint(ai_op1, ai_op2)

end function

public function unsignedlong of_bitwisexor (unsignedlong al_op1, unsignedlong al_op2);return pf_bitwisexor_ulong(al_op1, al_op2)

end function

public function unsignedinteger of_bitwisenot (unsignedinteger ai_op1);return pf_bitwisenot_uint(ai_op1)

end function

public function unsignedlong of_bitwisenot (unsignedlong al_op1);return pf_bitwisenot_ulong(al_op1)

end function

public function unsignedinteger of_rightshift (unsignedinteger ai_op1, integer ai_cnt);return pf_bitwiseRshift_uint(ai_op1, ai_cnt)

end function

public function unsignedlong of_rightshift (unsignedlong al_op1, integer ai_cnt);return pf_bitwiseRshift_ulong(al_op1, ai_cnt)

end function

public function unsignedinteger of_leftshift (unsignedinteger ai_op1, integer ai_cnt);return pf_bitwiseLshift_uint(ai_op1, ai_cnt)

end function

public function unsignedlong of_leftshift (unsignedlong al_op1, integer ai_cnt);return pf_bitwiseLshift_ulong(al_op1, ai_cnt)

end function

on pf_n_bitoperator.create
call super::create
end on

on pf_n_bitoperator.destroy
call super::destroy
end on

