local modem = peripheral.find("modem") or error("No modem attached", 0)
print(modem.getNamesRemote())