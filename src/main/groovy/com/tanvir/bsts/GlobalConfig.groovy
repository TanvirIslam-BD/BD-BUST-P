package com.tanvir.bsts

class GlobalConfig {

    public static final def USER_TYPE = [
            ADMINISTRATOR: "ADMINISTRATOR",
            REGULAR_MEMBER: "REGULAR",
    ]

    public static final def COUNTER_TYPE = [
            AGENT: "AGENT",
            THIRD_PARTY: "THIRD PARTY",
    ]

    public static Integer itemsPerPage() {
        return 50
    }
}
