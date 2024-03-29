Sub base()
    Dim Ticker As String
    Dim IRow, GreatestVolume, Vol As Long
    Dim YearlyChange, OpeningPrice, ClosingPrice, CurrentPrice, GreatestIncrease, GreatestDecrease As Double
    Dim TotalStock, PrintRow As Integer
    lRow = Cells(Rows.Count, 1).End(xlUp).Row
    Col = Cells(1, Columns.Count).End(xlToLeft).Column
    YearlyChange = 0
    PrintRow = 1
    GreatestDecrease = 0
    GreatestIncrease = 0
    GreatestVolume = 0
    'Insert cell columns 
    Range("I1").Value = "Ticker"
    Range("J1").Value = "Yearly Change"
    Range("K1").Value = "Percent Change"
    Range("L1").Value = "Total Stock Volume"
    Range("O1").Value = "Greatest % Increase"
    Range("O2").Value = "Greatest % Decrease"
    Range("O3").Value = "Greatest Total Volume"
    'Main loop
    For I = 2 To lRow
        Ticker = Cells(I, 1).Value
        OpeningPrice = Cells(I, 3).Value
        ClosingPrice = Cells(I, 6).Value
        Vol = Cells(I, 7).Value
        TotalStock = Vol + TotalStock 'RESET
        YearlyChange = YearlyChange + (ClosingPrice - OpeningPrice)
        If Cells(I + 1, 1).Value <> Cells(I, 1).Value Then
            PrintRow = PrintRow + 1
            Cells(PrintRow, 9).Value = Ticker
            Cells(PrintRow, 10).Value = YearlyChange
            Cells(PrintRow, 10).NumberFormat = "0.000000"
            'Conditional formating
            If (Cells(PrintRow, 10).Value) > 0 Then
                Cells(PrintRow, 10).Interior.ColorIndex = 4
            Else
                Cells(PrintRow, 10).Interior.ColorIndex = 3
            End If
            If (OpeningPrice = 0 Or ClosingPrice = 0) Then
                Cells(PrintRow, 11).Value = 0
            Else
                Cells(PrintRow, 11).Value = OpeningPrice / ClosingPrice - 1
            End If
            Cells(PrintRow, 11).NumberFormat = "0.00%"
            Cells(PrintRow, 12).Value = TotalStock
            If YearlyChange > 0 And YearlyChange > GreatestIncrease Then
                GreatestIncrease = YearlyChange
                Cells(1, 16).Value = Ticker
                Cells(1, 17).Value = GreatestIncrease
                Cells(1, 17).NumberFormat = "0.00%"
            ElseIf YearlyChange < 0 And YearlyChange < GreatestDecrease Then
                GreatestDecrease = YearlyChange
                Cells(2, 16).Value = Ticker
                Cells(2, 17).Value = GreatestDecrease
                Cells(2, 17).NumberFormat = "0.00%"
            End If
            If TotalStock > GreatestVolume Then
                GreatestVolume = TotalStock
                Cells(3, 16).Value = Ticker
                Cells(3, 17).Value = GreatestVolume
            End If
            TotalStock = 0
            YearlyChange = 0    
        End If
        
    Next I
End Sub
