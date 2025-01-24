-- Global "constants" and enumerations

XPING_VERSION = "0.0.1"

SERVER = "SERVER"

-- Application status and navigation
STATUS = {
	OFFLINE = 1,
	LOGGING = 2,
	LOGGED = 3,
	LOG_ERROR = 4,
	PREFLIGHT = 5,
	MENU = 6,
	REQUESTS = 7,
	METAR = 8,
	ATIS = 9,
	MESSAGE_LIST = 10,
	PDC = 11
}

-- Possible client networks
NETWORK = {
	IVAO = "IVAO",
	VATSIM = "VATSIM"
}

-- ACARS message types
MESSAGE_TYPE = {
	PING = "ping",
	POLL = "poll",
	PEEK = "peek",
	INFOREQ = "inforeq",
	PROGRESS = "progress",
	CPDLC = "cpdlc",
	TELEX = "telex",
	POSREQ = "posreq",
	POSITION = "position",
	DATAREQ = "datareq"
}

-- UI Colors
UI_COLOR = {
	BLUE = 0xFFA89300
}