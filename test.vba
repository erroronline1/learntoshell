sub test()

debug.print "this ist a test how syntax highlighting works for this extension"

end sub

Public Function importModules(ByVal libraries As Object) As Boolean
    Dim lib As Variant, modloop As Variant
    On Error Resume Next
    'Application.DisplayAlerts = False
    'rename existing modules and import external modules
    For Each lib In libraries
		If Len(Dir(libraries(lib))) > 0 Then
			With ThisWorkbook.VBProject.VBComponents
					'renaming to _old because sometimes modules are removed on finishing of the code only, resulting in enumeration of module names
					.Item(lib).name = lib & "_OLD"
					.Import libraries(lib)
			End With
		End If
    Next lib
    'if no external modules have been found rename existing modules to default name
    For Each lib In libraries
        Dim loaded As Boolean
        For Each modloop In ThisWorkbook.VBProject.VBComponents
            If (modloop.name = lib) Then loaded = True: Exit For
        Next modloop
        If loaded Then
            ThisWorkbook.VBProject.VBComponents.Remove ThisWorkbook.VBProject.VBComponents(lib & "_OLD")
        Else
            ThisWorkbook.VBProject.VBComponents(lib & "_OLD").name = lib
        End If
    Next lib
    Application.DisplayAlerts = True
    On Error GoTo 0
    importModules = True
End Function