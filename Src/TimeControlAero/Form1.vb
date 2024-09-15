'****************************************************************************
'    TimeControlAero
'    Copyright (C) 2024 CJH.
'
'    This program is free software: you can redistribute it and/or modify
'    it under the terms of the GNU General Public License as published by
'    the Free Software Foundation, either version 3 of the License, or
'    (at your option) any later version.
'
'    This program is distributed in the hope that it will be useful,
'    but WITHOUT ANY WARRANTY; without even the implied warranty of
'    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'    GNU General Public License for more details.
'
'    You should have received a copy of the GNU General Public License
'    along with this program.  If not, see <http://www.gnu.org/licenses/>.
'****************************************************************************
'/*****************************************************\
'*                                                     *
'*     TimeControlAero - Form1.vb                      *
'*                                                     *
'*     Copyright (c) CJH.                              *
'*                                                     *
'*     The main time form.                             *
'*                                                     *
'\*****************************************************/
Imports Microsoft.Win32

Public Class Form1
    Declare Auto Function DwmIsCompositionEnabled Lib "dwmapi.dll" Alias "DwmIsCompositionEnabled" (ByRef pfEnabled As Boolean) As Integer
    Declare Auto Function DwmExtendFrameIntoClientArea Lib "dwmapi.dll" Alias "DwmExtendFrameIntoClientArea" (ByVal hWnd As IntPtr, ByRef pMargin As Margins) As Integer
    Public Structure Margins
        Public Left As Integer
        Public Right As Integer
        Public Top As Integer
        Public Bottom As Integer
    End Structure
    Dim pMargins As New Margins With {.Top = Me.Height, .Bottom = Me.Height, .Left = Me.Width, .Right = Me.Width}

    'API移动窗体
    Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As IntPtr, ByVal wMsg As Integer, ByVal wParam As Integer, ByVal lParam As Integer) As Boolean
    Declare Function ReleaseCapture Lib "user32" Alias "ReleaseCapture" () As Boolean
    Const WM_SYSCOMMAND = &H112
    Const SC_MOVE = &HF010&
    Const HTCAPTION = 2
    Private Sub Form1_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles MyBase.MouseDown
        ReleaseCapture()
        SendMessage(Me.Handle, WM_SYSCOMMAND, SC_MOVE + HTCAPTION, 0)
    End Sub
    Private Sub Label1_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles Label1.MouseDown
        ReleaseCapture()
        SendMessage(Me.Handle, WM_SYSCOMMAND, SC_MOVE + HTCAPTION, 0)
    End Sub
    Private Sub Form1_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        ' 获取当前窗体的 DPI
        Dim currentDpiX As Single = Me.CreateGraphics().DpiX
        Dim currentDpiY As Single = Me.CreateGraphics().DpiY
        '计算缩放比例
        Dim scaleX As Single = currentDpiX / 96
        Dim scaleY As Single = currentDpiY / 96
        Me.Size = New Point(125 * scaleX, 69 * scaleY)
        Me.Location = New Size(-140 * scaleX, -75 * scaleY)
        Dim en As Boolean = False
        Me.TransparencyKey = Color.FromArgb(250, 250, 1)
        Me.BackColor = Me.TransparencyKey
        If System.Environment.OSVersion.Version.Major >= 6 Then  '如果是Vista系统或以上
            DwmIsCompositionEnabled(en)  '取得是否开启了Aero效果
            If en Then
                DwmExtendFrameIntoClientArea(Me.Handle, pMargins)
            Else
                MessageBox.Show("没有启用Aero主题。程序将无法显示Aero界面。", "时钟小工具 - 错误", MessageBoxButtons.OK, MessageBoxIcon.Error)
                Me.BackColor = Color.White
                Me.FormBorderStyle = Windows.Forms.FormBorderStyle.FixedToolWindow
                Me.Text = ""
            End If
        Else '非Vista系统上的提示
            MessageBox.Show("仅支持 Windows Vista (NT6.0) 以上版本系统使用本程序。", "时钟小工具 - 错误", MessageBoxButtons.OK, MessageBoxIcon.Error)
            Me.BackColor = Color.White
            Me.FormBorderStyle = Windows.Forms.FormBorderStyle.FixedToolWindow
            Me.Text = ""
        End If
        Label1.Text = Format(Now(), "HH:mm:ss")
        Timer1.Enabled = True
        Me.Location = New Size((System.Windows.Forms.SystemInformation.PrimaryMonitorSize.Width - Me.Width) / 2, 5)
    End Sub

    Private Sub Form1_Paint(ByVal sender As Object, ByVal e As System.Windows.Forms.PaintEventArgs) Handles Me.Paint
        If System.Environment.OSVersion.Version.Major >= 6 Then
            Dim g As Graphics = e.Graphics
            Using sBrush = New SolidBrush(SystemColors.Control) '重绘
                g.FillRectangle(sBrush, pMargins.Left, pMargins.Top, Me.ClientRectangle.Width - pMargins.Left - pMargins.Right, Me.ClientRectangle.Height - pMargins.Top - pMargins.Bottom)
            End Using
        End If
    End Sub


    Private Sub Timer1_Tick(sender As System.Object, e As System.EventArgs) Handles Timer1.Tick
        Label1.Text = Format(Now(), "HH:mm:ss")
    End Sub

    'Private Sub SystemEvents_UserPreferenceChanged(ByVal sender As Object, ByVal e As UserPreferenceChangedEventArgs)
    '    If e.Category = UserPreferenceCategory.VisualStyle Then
    '        Dim en As Boolean = False
    '        If System.Environment.OSVersion.Version.Major >= 6 Then  '如果是Vista系统或以上
    '            DwmIsCompositionEnabled(en)  '取得是否开启了Aero效果
    '            If en Then
    '                DwmExtendFrameIntoClientArea(Me.Handle, pMargins)
    '            End If
    '        End If
    '    End If
    'End Sub


    Private Sub extm_Click(sender As System.Object, e As System.EventArgs) Handles extm.Click
        If (MessageBox.Show("确定退出时钟小工具吗？", "时钟小工具", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) = DialogResult.Yes) Then
            End
        End If
    End Sub

    Private Sub abm_Click(sender As System.Object, e As System.EventArgs) Handles abm.Click
        MessageBox.Show("时钟小工具 Aero 版" & vbCrLf & "版本：" & My.Application.Info.Version.ToString & vbCrLf & "版权所有 © 2024 CJH。", "关于时钟小工具 Aero 版", MessageBoxButtons.OK, MessageBoxIcon.Information)
    End Sub
End Class
