import winreg


def get_long_paths_enabled():
    try:
        key_path = r"SYSTEM\CurrentControlSet\Control\FileSystem"
        with winreg.OpenKey(
            winreg.HKEY_LOCAL_MACHINE, key_path, 0, winreg.KEY_READ
        ) as key:
            value, _ = winreg.QueryValueEx(key, "LongPathsEnabled")
            return value
    except FileNotFoundError:
        return None
    except PermissionError:
        print("Permission denied")
        return None


def set_long_paths_enabled(enable=True):
    try:
        key_path = r"SYSTEM\CurrentControlSet\Control\FileSystem"
        with winreg.OpenKey(
            winreg.HKEY_LOCAL_MACHINE, key_path, 0, winreg.KEY_SET_VALUE
        ) as key:
            winreg.SetValueEx(
                key, "LongPathsEnabled", 0, winreg.REG_DWORD, 1 if enable else 0
            )
        print(f"LongPathsEnabled set to {enable}")
    except PermissionError:
        print("Permission denied")


if __name__ == "__main__":

    print("Long paths enabled:", get_long_paths_enabled())
