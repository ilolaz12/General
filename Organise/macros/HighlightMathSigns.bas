Attribute VB_Name = "Module1"
Sub HighlightMathSigns()
    Dim rng As Range
    Set rng = ActiveDocument.Content
    
    ' Format all plus signs (+) green
    With rng.Find
        .ClearFormatting
        .Text = "+"
        .Replacement.ClearFormatting
        .Replacement.Font.Color = wdColorTeal
        .Replacement.Text = "+"
        .Execute Replace:=wdReplaceAll, Format:=True
    End With
    
    ' Format hyphen-minus (-) red
    With rng.Find
        .ClearFormatting
        .Text = "-"
        .Replacement.ClearFormatting
        .Replacement.Font.Color = wdColorPink
        .Replacement.Text = "-"
        .Execute Replace:=wdReplaceAll, Format:=True
    End With
    
    ' Format true minus sign (-, Unicode U+2212) red
    With rng.Find
        .ClearFormatting
        .Text = ChrW(&H2212)
        .Replacement.ClearFormatting
        .Replacement.Font.Color = wdColorPink
        .Replacement.Text = ChrW(&H2212)
        .Execute Replace:=wdReplaceAll, Format:=True
    End With
    
    MsgBox "Highlighting complete!", vbInformation
End Sub

