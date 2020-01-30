ProfileList := {}
Var := "test"
Value := "valore"
ProfileList.Insert(Var, {Name:"MyName",Password:Value,Server:"TheServer"})
ProfileList.Insert("AnotherName", {Name:"AnotherName",Password:"AnotherPassword",Server:"ThatServer"})

MsgBox, % "Here is the Password for MyName: " ProfileList["test"].Password
	 . "`nHere is the Password for AnotherName: " ProfileList["AnotherName"].Password