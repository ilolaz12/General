Add-Type @"
  using System;
  using System.Runtime.InteropServices;

  public class WindowOperations {
    [DllImport("user32.dll")]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool EnumWindows(EnumWindowsProc lpEnumFunc, IntPtr lParam);

    [DllImport("user32.dll")]
    public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);

    [DllImport("user32.dll")]
    public static extern int SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int x, int y, int cx, int cy, int uFlags);

    public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);

    [StructLayout(LayoutKind.Sequential)]
    public struct RECT {
      public int Left;
      public int Top;
      public int Right;
      public int Bottom;
    }

    public static bool EnumTheWindows(IntPtr hWnd, IntPtr lParam) {
      RECT r;
      GetWindowRect(hWnd, out r);
      // Move window only if it is off-screen
      if (r.Left > System.Windows.SystemParameters.PrimaryScreenWidth || r.Top > System.Windows.SystemParameters.PrimaryScreenHeight || r.Right < 0 || r.Bottom < 0) {
        SetWindowPos(hWnd, (IntPtr)0, 50, 50, 0, 0, 0x0001 | 0x0040);
      }
      return true;
    }
  }
"@

[WindowOperations.EnumWindows]::EnumWindows([WindowOperations.EnumWindowsProc]::new([WindowOperations]::EnumTheWindows), [IntPtr]::Zero)
