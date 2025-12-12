# Чтобы развернуть eM Client из трея

```ini
LeftMouseUpAction=!Execute ["C:\Program Files (x86)\eM Client\MailClient.exe" ]
```

---

## Чтобы развернуть eM Client из трея с помощью Lua в Rainmeter

```Lua
function RestoreEMClient()
 os.execute('start "" "C:\\Program Files (x86)\\eM Client\\MailClient.exe"')
end
```

```ini
LeftMouseUpAction=[!CommandMeasure SettingsScript "RestoreEMClient()"]
```





LeftMouseUpAction=!Execute ["C:\Program Files (x86)\eM Client\MailClient.exe" ]
