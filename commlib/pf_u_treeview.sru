HA$PBExportHeader$pf_u_treeview.sru
$PBExportComments$$$HEX7$$0cd3ccc604d508b884c7a9c62000$$ENDHEX$$TreeView $$HEX7$$e8ceb8d264b8200085c7c8b2e4b2$$ENDHEX$$.
forward
global type pf_u_treeview from treeview
end type
end forward

global type pf_u_treeview from treeview
integer width = 549
integer height = 476
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "$$HEX5$$d1b940c72000e0ac15b5$$ENDHEX$$"
long textcolor = 22172242
borderstyle borderstyle = stylelowered!
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
event type boolean pfe_ispowerframecontrol ( )
end type
global pf_u_treeview pf_u_treeview

type variables
public:
	boolean FixedToRight
	boolean FixedToBottom
	boolean ScaleToRight
	boolean ScaleToBottom

end variables

forward prototypes
public function string of_getclassname ()
public function integer of_movechildren (long al_oldparent, long al_newparent)
end prototypes

event type boolean pfe_ispowerframecontrol();return true

end event

public function string of_getclassname ();return 'pf_u_treeview'

end function

public function integer of_movechildren (long al_oldparent, long al_newparent);// $$HEX23$$54ba74b244c574c75cd158c7200058d504c7200054ba74b2e4b4200004c758ce7cb92000c0bcbdac69d5c8b2e4b2$$ENDHEX$$
// $$HEX2$$acb934d1$$ENDHEX$$: 1=$$HEX2$$31c1f5ac$$ENDHEX$$, -1=$$HEX2$$e4c228d3$$ENDHEX$$

long ll_child, ll_movedchild
treeviewitem ltvi_child

ll_child = this.finditem(ChildTreeItem!, al_oldparent)
do while ll_child > 0
	this.getitem(ll_child, ltvi_child)
	
	setnull(ltvi_child.itemhandle)
	ll_movedchild = this.insertitemlast(al_newparent, ltvi_child)
	if ll_movedchild = -1 then return -1
	
	// Move the children of the child that was found
	this.of_movechildren(ll_child, ll_movedchild)
	
	// Check for more children at the original level
	ll_child = this.finditem(NextTreeItem!, ll_child)
loop

return 1

end function

on pf_u_treeview.create
end on

on pf_u_treeview.destroy
end on

