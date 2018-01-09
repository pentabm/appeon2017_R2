$PBExportHeader$pf_w_example_dataencrypt.srw
forward
global type pf_w_example_dataencrypt from pf_w_sheet
end type
type cb_close from pf_u_commandbutton within pf_w_example_dataencrypt
end type
type ddlb_1 from dropdownlistbox within pf_w_example_dataencrypt
end type
type st_1 from statictext within pf_w_example_dataencrypt
end type
type st_2 from statictext within pf_w_example_dataencrypt
end type
type ddlb_2 from dropdownlistbox within pf_w_example_dataencrypt
end type
type st_3 from statictext within pf_w_example_dataencrypt
end type
type sle_plain from singlelineedit within pf_w_example_dataencrypt
end type
type st_4 from statictext within pf_w_example_dataencrypt
end type
type sle_encrypted from singlelineedit within pf_w_example_dataencrypt
end type
type cb_1 from commandbutton within pf_w_example_dataencrypt
end type
type cb_2 from commandbutton within pf_w_example_dataencrypt
end type
type st_5 from statictext within pf_w_example_dataencrypt
end type
type sle_secretkey from singlelineedit within pf_w_example_dataencrypt
end type
type st_6 from statictext within pf_w_example_dataencrypt
end type
type st_7 from statictext within pf_w_example_dataencrypt
end type
type st_8 from statictext within pf_w_example_dataencrypt
end type
type sle_plain2 from singlelineedit within pf_w_example_dataencrypt
end type
type sle_hashed from singlelineedit within pf_w_example_dataencrypt
end type
type st_9 from statictext within pf_w_example_dataencrypt
end type
type cb_3 from commandbutton within pf_w_example_dataencrypt
end type
type st_10 from statictext within pf_w_example_dataencrypt
end type
type sle_base64_encode from singlelineedit within pf_w_example_dataencrypt
end type
type st_11 from statictext within pf_w_example_dataencrypt
end type
type st_12 from statictext within pf_w_example_dataencrypt
end type
type sle_base64_decode from singlelineedit within pf_w_example_dataencrypt
end type
type cb_4 from commandbutton within pf_w_example_dataencrypt
end type
type cb_5 from commandbutton within pf_w_example_dataencrypt
end type
type cbx_1 from checkbox within pf_w_example_dataencrypt
end type
end forward

global type pf_w_example_dataencrypt from pf_w_sheet
string title = "데이터 암호화 샘플 윈도우"
cb_close cb_close
ddlb_1 ddlb_1
st_1 st_1
st_2 st_2
ddlb_2 ddlb_2
st_3 st_3
sle_plain sle_plain
st_4 st_4
sle_encrypted sle_encrypted
cb_1 cb_1
cb_2 cb_2
st_5 st_5
sle_secretkey sle_secretkey
st_6 st_6
st_7 st_7
st_8 st_8
sle_plain2 sle_plain2
sle_hashed sle_hashed
st_9 st_9
cb_3 cb_3
st_10 st_10
sle_base64_encode sle_base64_encode
st_11 st_11
st_12 st_12
sle_base64_decode sle_base64_decode
cb_4 cb_4
cb_5 cb_5
cbx_1 cbx_1
end type
global pf_w_example_dataencrypt pf_w_example_dataencrypt

type variables
pf_n_cryptoapi inv_crypto

end variables

on pf_w_example_dataencrypt.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.st_2=create st_2
this.ddlb_2=create ddlb_2
this.st_3=create st_3
this.sle_plain=create sle_plain
this.st_4=create st_4
this.sle_encrypted=create sle_encrypted
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_5=create st_5
this.sle_secretkey=create sle_secretkey
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.sle_plain2=create sle_plain2
this.sle_hashed=create sle_hashed
this.st_9=create st_9
this.cb_3=create cb_3
this.st_10=create st_10
this.sle_base64_encode=create sle_base64_encode
this.st_11=create st_11
this.st_12=create st_12
this.sle_base64_decode=create sle_base64_decode
this.cb_4=create cb_4
this.cb_5=create cb_5
this.cbx_1=create cbx_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.ddlb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.ddlb_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.sle_plain
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.sle_encrypted
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.sle_secretkey
this.Control[iCurrent+14]=this.st_6
this.Control[iCurrent+15]=this.st_7
this.Control[iCurrent+16]=this.st_8
this.Control[iCurrent+17]=this.sle_plain2
this.Control[iCurrent+18]=this.sle_hashed
this.Control[iCurrent+19]=this.st_9
this.Control[iCurrent+20]=this.cb_3
this.Control[iCurrent+21]=this.st_10
this.Control[iCurrent+22]=this.sle_base64_encode
this.Control[iCurrent+23]=this.st_11
this.Control[iCurrent+24]=this.st_12
this.Control[iCurrent+25]=this.sle_base64_decode
this.Control[iCurrent+26]=this.cb_4
this.Control[iCurrent+27]=this.cb_5
this.Control[iCurrent+28]=this.cbx_1
end on

on pf_w_example_dataencrypt.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.ddlb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.ddlb_2)
destroy(this.st_3)
destroy(this.sle_plain)
destroy(this.st_4)
destroy(this.sle_encrypted)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_5)
destroy(this.sle_secretkey)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.sle_plain2)
destroy(this.sle_hashed)
destroy(this.st_9)
destroy(this.cb_3)
destroy(this.st_10)
destroy(this.sle_base64_encode)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.sle_base64_decode)
destroy(this.cb_4)
destroy(this.cb_5)
destroy(this.cbx_1)
end on

type ln_templeft from pf_w_sheet`ln_templeft within pf_w_example_dataencrypt
end type

type ln_tempright from pf_w_sheet`ln_tempright within pf_w_example_dataencrypt
end type

type ln_temptop from pf_w_sheet`ln_temptop within pf_w_example_dataencrypt
end type

type ln_tempbuttom from pf_w_sheet`ln_tempbuttom within pf_w_example_dataencrypt
end type

type ln_tempbutton from pf_w_sheet`ln_tempbutton within pf_w_example_dataencrypt
end type

type ln_tempstart from pf_w_sheet`ln_tempstart within pf_w_example_dataencrypt
end type

type cb_close from pf_u_commandbutton within pf_w_example_dataencrypt
integer x = 4279
integer y = 32
integer width = 274
integer height = 96
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = hangeul!
string text = "닫기"
string powertiptext = "해당 화면을 닫습니다."
boolean applydesign = false
boolean fixedtoright = true
end type

event clicked;call super::clicked;close(parent)
end event

type ddlb_1 from dropdownlistbox within pf_w_example_dataencrypt
integer x = 590
integer y = 440
integer width = 873
integer height = 476
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
string item[] = {"AES","RC4","Seed128"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within pf_w_example_dataencrypt
integer x = 590
integer y = 220
integer width = 544
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "암호화/복호화"
boolean focusrectangle = false
end type

type st_2 from statictext within pf_w_example_dataencrypt
integer x = 2578
integer y = 220
integer width = 475
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "HASH 처리"
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within pf_w_example_dataencrypt
integer x = 2569
integer y = 436
integer width = 873
integer height = 476
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
string item[] = {"MD5Hash","SHA256"}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within pf_w_example_dataencrypt
integer x = 590
integer y = 576
integer width = 439
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "암호화할 문자열"
boolean focusrectangle = false
end type

type sle_plain from singlelineedit within pf_w_example_dataencrypt
integer x = 590
integer y = 644
integer width = 1074
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within pf_w_example_dataencrypt
integer x = 590
integer y = 968
integer width = 416
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "암호화된 문자열"
boolean focusrectangle = false
end type

type sle_encrypted from singlelineedit within pf_w_example_dataencrypt
integer x = 590
integer y = 1036
integer width = 1074
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within pf_w_example_dataencrypt
integer x = 1669
integer y = 832
integer width = 402
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "암호화"
end type

event clicked;if pf_f_isemptystring(sle_plain.text) then
	messagebox('알림', '암호화할 문자열을 입력하세요')
	return
end if

if pf_f_isemptystring(sle_secretkey.text) then
	messagebox('알림', '암호화 시 사용될 키 문자열을 입력하세요')
	return
end if

pf_n_cryptoapi lnv_crypto
string ls_provider
string ls_encrypted

choose case ddlb_1.text
	case 'AES'
		// set the ProviderType
		lnv_crypto.iProviderType = lnv_crypto.PROV_RSA_AES
		
		// set the CryptoProvider
		ls_provider = lnv_crypto.of_GetDefaultProvider()
		lnv_crypto.iCryptoProvider = ls_provider
		
		// set the Encryption Algorithm
		lnv_crypto.iEncryptAlgorithm = lnv_crypto.CALG_AES_128
		
		ls_encrypted = lnv_crypto.of_Encrypt(sle_plain.text, sle_secretkey.text)
	case 'RC4'
		// set the ProviderType
		lnv_crypto.iProviderType = lnv_crypto.PROV_RSA_FULL
		
		// set the CryptoProvider
		ls_provider = lnv_crypto.of_GetDefaultProvider()
		lnv_crypto.iCryptoProvider = ls_provider
		
		// set the Encryption Algorithm
		lnv_crypto.iEncryptAlgorithm = lnv_crypto.CALG_RC4
		
		ls_encrypted = lnv_crypto.of_Encrypt(sle_plain.text, sle_secretkey.text)
	case 'Seed128'
		long ll_enclen
		
		ll_enclen = len(sle_plain.text) * 2
		if ll_enclen < 32 then 	ll_enclen = 32 + 1
		ls_encrypted = space(ll_enclen)
		
		gnv_extfunc.pf_seed128encrypt(sle_secretkey.text, sle_plain.text, ls_encrypted)
	case else
		messagebox('알림', '암호화 알고리즘을 선택하세요')
end choose

sle_encrypted.text = ls_encrypted

end event

type cb_2 from commandbutton within pf_w_example_dataencrypt
integer x = 1669
integer y = 1028
integer width = 402
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "복호화"
end type

event clicked;if pf_f_isemptystring(sle_encrypted.text) then
	messagebox('알림', '복호화할 문자열이 없습니다')
	return
end if

if pf_f_isemptystring(sle_secretkey.text) then
	messagebox('알림', '복호화 시 사용될 키 문자열을 입력하세요')
	return
end if

pf_n_cryptoapi lnv_crypto
string ls_provider
string ls_plaintext

choose case ddlb_1.text
	case 'AES'
		// set the ProviderType
		lnv_crypto.iProviderType = lnv_crypto.PROV_RSA_AES
		
		// set the CryptoProvider
		ls_provider = lnv_crypto.of_GetDefaultProvider()
		lnv_crypto.iCryptoProvider = ls_provider
		
		// set the Encryption Algorithm
		lnv_crypto.iEncryptAlgorithm = lnv_crypto.CALG_AES_128
		
		ls_plaintext = lnv_crypto.of_Decrypt(sle_encrypted.text, sle_secretkey.text)
	case 'RC4'
		// set the ProviderType
		lnv_crypto.iProviderType = lnv_crypto.PROV_RSA_FULL
		
		// set the CryptoProvider
		ls_provider = lnv_crypto.of_GetDefaultProvider()
		lnv_crypto.iCryptoProvider = ls_provider
		
		// set the Encryption Algorithm
		lnv_crypto.iEncryptAlgorithm = lnv_crypto.CALG_RC4
		
		ls_plaintext = lnv_crypto.of_Decrypt(sle_encrypted.text, sle_secretkey.text)
	case 'Seed128'
		ls_plaintext = space(len(sle_encrypted.text) * 2)
		gnv_extfunc.pf_seed128decrypt(sle_secretkey.text, sle_encrypted.text, ls_plaintext)
	case else
		messagebox('알림', '암호화 알고리즘을 선택하세요')
end choose

messagebox('복호화된 문자열', ls_plaintext)

end event

type st_5 from statictext within pf_w_example_dataencrypt
integer x = 590
integer y = 772
integer width = 416
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "암호화 키"
boolean focusrectangle = false
end type

type sle_secretkey from singlelineedit within pf_w_example_dataencrypt
integer x = 590
integer y = 836
integer width = 1074
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within pf_w_example_dataencrypt
integer x = 590
integer y = 356
integer width = 439
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "암호화 알고리즘"
boolean focusrectangle = false
end type

type st_7 from statictext within pf_w_example_dataencrypt
integer x = 2578
integer y = 356
integer width = 439
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "암호화 알고리즘"
boolean focusrectangle = false
end type

type st_8 from statictext within pf_w_example_dataencrypt
integer x = 2574
integer y = 568
integer width = 503
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "Hash처리 할 문자열"
boolean focusrectangle = false
end type

type sle_plain2 from singlelineedit within pf_w_example_dataencrypt
integer x = 2574
integer y = 644
integer width = 1074
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type sle_hashed from singlelineedit within pf_w_example_dataencrypt
integer x = 2574
integer y = 836
integer width = 1074
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type st_9 from statictext within pf_w_example_dataencrypt
integer x = 2574
integer y = 772
integer width = 503
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "Hash 처리된 문자열"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within pf_w_example_dataencrypt
integer x = 3653
integer y = 828
integer width = 402
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "Hash"
end type

event clicked;if pf_f_isemptystring(sle_plain2.text) then
	messagebox('알림', 'Hash 처리 할 문자열을 입력하세요')
	return
end if

string ls_hashed

choose case ddlb_2.text
	case 'MD5Hash'
		ls_hashed = space(32)
		gnv_extfunc.pf_MD5Hash(sle_plain2.text, ls_hashed)
	case 'SHA256'
		ls_hashed = space(64)
		gnv_extfunc.pf_SHA256Hash(sle_plain2.text, ls_hashed)
	case else
		messagebox('알림', '암호화 알고리즘을 선택하세요')
end choose

sle_hashed.text = ls_hashed

end event

type st_10 from statictext within pf_w_example_dataencrypt
integer x = 2578
integer y = 1068
integer width = 544
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "BASE64"
boolean focusrectangle = false
end type

type sle_base64_encode from singlelineedit within pf_w_example_dataencrypt
integer x = 2574
integer y = 1276
integer width = 1074
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type st_11 from statictext within pf_w_example_dataencrypt
integer x = 2574
integer y = 1192
integer width = 503
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "BASE64 Encoding"
boolean focusrectangle = false
end type

type st_12 from statictext within pf_w_example_dataencrypt
integer x = 2574
integer y = 1428
integer width = 503
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 20066866
string text = "BASE64 Decoding"
boolean focusrectangle = false
end type

type sle_base64_decode from singlelineedit within pf_w_example_dataencrypt
integer x = 2574
integer y = 1516
integer width = 1074
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 22040656
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within pf_w_example_dataencrypt
integer x = 3653
integer y = 1268
integer width = 402
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "Encoding"
end type

event clicked;if pf_f_isemptystring(sle_base64_encode.text) then
	messagebox('알림', 'BASE64 암호화할 문자열을 입력하세요')
	return
end if

pf_n_cryptoapi lnv_crypto
blob lblb_plain
string ls_plain, ls_encoded
integer i, j

ls_plain = upper(sle_base64_encode.text)
if cbx_1.checked = true then
	lblb_plain = blob(space(len(ls_plain) / 2), EncodingAnsi!)
	for i = 1 to len(ls_plain) step 2
		j ++
		setbyte(lblb_plain, j, lnv_crypto.of_hex2long(mid(ls_plain, i, 2)))
	next
else
	lblb_plain = blob(ls_plain, EncodingAnsi!)
end if

ls_encoded = lnv_crypto.of_encode64(lblb_plain)
sle_base64_decode.text = ls_encoded

end event

type cb_5 from commandbutton within pf_w_example_dataencrypt
integer x = 3653
integer y = 1508
integer width = 402
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "Decoding"
end type

event clicked;if pf_f_isemptystring(sle_base64_decode.text) then
	messagebox('알림', 'BASE64 복호화 할 문자열을 입력하세요')
	return
end if

pf_n_cryptoapi lnv_crypto
blob lblb_decoded
string ls_encoded
integer i, j

ls_encoded = sle_base64_decode.text
lblb_decoded = lnv_crypto.of_decode64(ls_encoded)
sle_base64_encode.text = string(lblb_decoded, EncodingAnsi!)

end event

type cbx_1 from checkbox within pf_w_example_dataencrypt
integer x = 3145
integer y = 1184
integer width = 823
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
string text = "Convert Hex string to Binary"
end type

