```
~ # iw dev
phy#1
        Interface wlan1
                ifindex 5
                wdev 0x100000001
                addr 82:0c:43:26:60:00
                type managed
                txpower 0.00 dBm
                multicast TXQ:
                        qsz-byt qsz-pkt flows   drops   marks   overlmt hashcol tx-bytes        tx-packets
                        0       0       0       0       0       0       0       0               0
phy#0
        Interface wlan0
                ifindex 4
                wdev 0x1
                addr 00:0c:43:26:60:00
                type managed
                txpower 0.00 dBm
                multicast TXQ:
                        qsz-byt qsz-pkt flows   drops   marks   overlmt hashcol tx-bytes        tx-packets
                        0       0       0       0       0       0       0       0               0
~ # iw phy
Wiphy phy1
        wiphy index: 1
        max # scan SSIDs: 4
        max scan IEs length: 2190 bytes
        max # sched scan SSIDs: 0
        max # match sets: 0
        Retry short limit: 7
        Retry long limit: 4
        Coverage class: 0 (up to 0m)
        Device supports RSN-IBSS.
        Device supports AP-side u-APSD.
        Device supports T-DLS.
        Supported Ciphers:
                * WEP40 (00-0f-ac:1)
                * WEP104 (00-0f-ac:5)
                * TKIP (00-0f-ac:2)
                * CCMP-128 (00-0f-ac:4)
                * CCMP-256 (00-0f-ac:10)
                * GCMP-128 (00-0f-ac:8)
                * GCMP-256 (00-0f-ac:9)
                * CMAC (00-0f-ac:6)
                * CMAC-256 (00-0f-ac:13)
                * GMAC-128 (00-0f-ac:11)
                * GMAC-256 (00-0f-ac:12)
        Available Antennas: TX 0x3 RX 0x3
        Configured Antennas: TX 0x1c RX 0x1c
        Supported interface modes:
                 * IBSS
                 * managed
                 * AP
                 * AP/VLAN
                 * monitor
                 * P2P-client
                 * P2P-GO
        Band 2:
                Capabilities: 0x9ff
                        RX LDPC
                        HT20/HT40
                        SM Power Save disabled
                        RX Greenfield
                        RX HT20 SGI
                        RX HT40 SGI
                        TX STBC
                        RX STBC 1-stream
                        Max AMSDU length: 7935 bytes
                        No DSSS/CCK HT40
                Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
                Minimum RX AMPDU time spacing: 2 usec (0x04)
                HT TX/RX MCS rate indexes supported: 0-15
                VHT Capabilities (0x339a59f6):
                        Max MPDU length: 11454
                        Supported Channel Width: 160 MHz
                        RX LDPC
                        short GI (80 MHz)
                        short GI (160/80+80 MHz)
                        TX STBC
                        SU Beamformer
                        SU Beamformee
                        MU Beamformer
                        MU Beamformee
                        RX antenna pattern consistency
                        TX antenna pattern consistency
                VHT RX MCS set:
                        1 streams: MCS 0-9
                        2 streams: MCS 0-9
                        3 streams: not supported
                        4 streams: not supported
                        5 streams: not supported
                        6 streams: not supported
                        7 streams: not supported
                        8 streams: not supported
                VHT RX highest supported: 0 Mbps
                VHT TX MCS set:
                        1 streams: MCS 0-9
                        2 streams: MCS 0-9
                        3 streams: not supported
                        4 streams: not supported
                        5 streams: not supported
                        6 streams: not supported
                        7 streams: not supported
                        8 streams: not supported
                VHT TX highest supported: 0 Mbps
                VHT extended NSS: supported
                HE Iftypes: managed
                        HE MAC Capabilities (0x08011a000040):
                                +HTC HE Supported
                                Trigger Frame MAC Padding Duration: 2
                                OM Control
                                Maximum A-MPDU Length Exponent: 3
                                A-MSDU in A-MPDU
                        HE PHY Capabilities: (0x4c704e926d12f3164e3f00):
                                HE40/HE80/5GHz
                                HE160/5GHz
                                242 tone RUs/5GHz
                                Device Class: 1
                                LDPC Coding in Payload
                                HE SU PPDU with 1x HE-LTF and 0.8us GI
                                NDP with 4x HE-LTF and 3.2us GI
                                STBC Tx <= 80MHz
                                STBC Rx <= 80MHz
                                Full Bandwidth UL MU-MIMO
                                DCM Max Constellation: 2
                                DCM Max Constellation Rx: 2
                                SU Beamformer
                                SU Beamformee
                                Beamformee STS <= 80MHz: 3
                                Beamformee STS > 80MHz: 3
                                Sounding Dimensions <= 80MHz: 2
                                Sounding Dimensions > 80MHz: 2
                                Codebook Size SU Feedback
                                Codebook Size MU Feedback
                                Triggered CQI Feedback
                                Partial Bandwidth Extended Range
                                Partial Bandwidth DL MU-MIMO
                                PPE Threshold Present
                                Power Boost Factor ar
                                HE SU PPDU & HE PPDU 4x HE-LTF 0.8us GI
                                Max NC: 2
                                20MHz in 40MHz HE PPDU 2.4GHz
                                20MHz in 160/80+80MHz HE PPDU
                                80MHz in 160/80+80MHz HE PPDU
                                DCM Max BW: 1
                                Longer Than 16HE SIG-B OFDM Symbols
                                Non-Triggered CQI Feedback
                                TX 1024-QAM
                                RX 1024-QAM
                                RX Full BW SU Using HE MU PPDU with Compression SIGB
                                RX Full BW SU Using HE MU PPDU with Non-Compression SIGB
                        HE RX MCS and NSS set <= 80 MHz
                                1 streams: MCS 0-11
                                2 streams: MCS 0-11
                                3 streams: not supported
                                4 streams: not supported
                                5 streams: not supported
                                6 streams: not supported
                                7 streams: not supported
                                8 streams: not supported
                        HE TX MCS and NSS set <= 80 MHz
                                1 streams: MCS 0-11
                                2 streams: MCS 0-11
                                3 streams: not supported
                                4 streams: not supported
                                5 streams: not supported
                                6 streams: not supported
                                7 streams: not supported
                                8 streams: not supported
                        HE RX MCS and NSS set 160 MHz
                                1 streams: MCS 0-11
                                2 streams: MCS 0-11
                                3 streams: not supported
                                4 streams: not supported
                                5 streams: not supported
                                6 streams: not supported
                                7 streams: not supported
                                8 streams: not supported
                        HE TX MCS and NSS set 160 MHz
                                1 streams: MCS 0-11
                                2 streams: MCS 0-11
                                3 streams: not supported
                                4 streams: not supported
                                5 streams: not supported
                                6 streams: not supported
                                7 streams: not supported
                                8 streams: not supported
                        PPE Threshold 0x79 0x1c 0xc7 0x71 0x1c 0xc7 0x71
                HE Iftypes: AP
                        HE MAC Capabilities (0x00051a081044):
                                +HTC HE Supported
                                TWT Responder
                                BSR
                                OM Control
                                Maximum A-MPDU Length Exponent: 3
                                BQR
                                A-MSDU in A-MPDU
                                OM Control UL MU Data Disable RX
                        HE PHY Capabilities: (0x0c204e926f12afd0000c00):
                                HE40/HE80/5GHz
                                HE160/5GHz
                                LDPC Coding in Payload
                                NDP with 4x HE-LTF and 3.2us GI
                                STBC Tx <= 80MHz
                                STBC Rx <= 80MHz
                                Full Bandwidth UL MU-MIMO
                                DCM Max Constellation: 2
                                DCM Max Constellation Rx: 2
                                SU Beamformer
                                SU Beamformee
                                MU Beamformer
                                Beamformee STS <= 80MHz: 3
                                Beamformee STS > 80MHz: 3
                                Sounding Dimensions <= 80MHz: 2
                                Sounding Dimensions > 80MHz: 2
                                Codebook Size SU Feedback
                                Codebook Size MU Feedback
                                Triggered SU Beamforming Feedback
                                Triggered MU Beamforming Feedback
                                Partial Bandwidth Extended Range
                                PPE Threshold Present
                                Max NC: 2
                                STBC Tx > 80MHz
                                STBC Rx > 80MHz
                                TX 1024-QAM
                                RX 1024-QAM
                        HE RX MCS and NSS set <= 80 MHz
                                1 streams: MCS 0-11
                                2 streams: MCS 0-11
                                3 streams: not supported
                                4 streams: not supported
                                5 streams: not supported
                                6 streams: not supported
                                7 streams: not supported
                                8 streams: not supported
                        HE TX MCS and NSS set <= 80 MHz
                                1 streams: MCS 0-11
                                2 streams: MCS 0-11
                                3 streams: not supported
                                4 streams: not supported
                                5 streams: not supported
                                6 streams: not supported
                                7 streams: not supported
                                8 streams: not supported
                        HE RX MCS and NSS set 160 MHz
                                1 streams: MCS 0-11
                                2 streams: MCS 0-11
                                3 streams: not supported
                                4 streams: not supported
                                5 streams: not supported
                                6 streams: not supported
                                7 streams: not supported
                                8 streams: not supported
                        HE TX MCS and NSS set 160 MHz
                                1 streams: MCS 0-11
                                2 streams: MCS 0-11
                                3 streams: not supported
                                4 streams: not supported
                                5 streams: not supported
                                6 streams: not supported
                                7 streams: not supported
                                8 streams: not supported
                        PPE Threshold 0x79 0x1c 0xc7 0x71 0x1c 0xc7 0x71
                Bitrates (non-HT):
                        * 6.0 Mbps
                        * 9.0 Mbps
                        * 12.0 Mbps
                        * 18.0 Mbps
                        * 24.0 Mbps
                        * 36.0 Mbps
                        * 48.0 Mbps
                        * 54.0 Mbps
                Frequencies:
                        * 5180.0 MHz [36] (20.0 dBm) (no IR)
                        * 5200.0 MHz [40] (20.0 dBm) (no IR)
                        * 5220.0 MHz [44] (20.0 dBm) (no IR)
                        * 5240.0 MHz [48] (20.0 dBm) (no IR)
                        * 5260.0 MHz [52] (20.0 dBm) (no IR, radar detection)
                        * 5280.0 MHz [56] (20.0 dBm) (no IR, radar detection)
                        * 5300.0 MHz [60] (20.0 dBm) (no IR, radar detection)
                        * 5320.0 MHz [64] (20.0 dBm) (no IR, radar detection)
                        * 5500.0 MHz [100] (20.0 dBm) (no IR, radar detection)
                        * 5520.0 MHz [104] (20.0 dBm) (no IR, radar detection)
                        * 5540.0 MHz [108] (20.0 dBm) (no IR, radar detection)
                        * 5560.0 MHz [112] (20.0 dBm) (no IR, radar detection)
                        * 5580.0 MHz [116] (20.0 dBm) (no IR, radar detection)
                        * 5600.0 MHz [120] (20.0 dBm) (no IR, radar detection)
                        * 5620.0 MHz [124] (20.0 dBm) (no IR, radar detection)
                        * 5640.0 MHz [128] (20.0 dBm) (no IR, radar detection)
                        * 5660.0 MHz [132] (20.0 dBm) (no IR, radar detection)
                        * 5680.0 MHz [136] (20.0 dBm) (no IR, radar detection)
                        * 5700.0 MHz [140] (20.0 dBm) (no IR, radar detection)
                        * 5720.0 MHz [144] (20.0 dBm) (no IR, radar detection)
                        * 5745.0 MHz [149] (20.0 dBm) (no IR)
                        * 5765.0 MHz [153] (20.0 dBm) (no IR)
                        * 5785.0 MHz [157] (20.0 dBm) (no IR)
                        * 5805.0 MHz [161] (20.0 dBm) (no IR)
                        * 5825.0 MHz [165] (20.0 dBm) (no IR)
                        * 5845.0 MHz [169] (disabled)
                        * 5865.0 MHz [173] (disabled)
                        * 5885.0 MHz [177] (disabled)
        Supported commands:
                 * new_interface
                 * set_interface
                 * new_key
                 * start_ap
                 * new_station
                 * set_bss
                 * authenticate
                 * associate
                 * deauthenticate
                 * disassociate
                 * join_ibss
                 * remain_on_channel
                 * set_tx_bitrate_mask
                 * frame
                 * frame_wait_cancel
                 * set_wiphy_netns
                 * set_channel
                 * tdls_mgmt
                 * tdls_oper
                 * probe_client
                 * set_noack_map
                 * register_beacons
                 * start_p2p_device
                 * set_mcast_rate
                 * connect
                 * disconnect
                 * channel_switch
                 * set_qos_map
                 * set_multicast_to_unicast
                 * set_sar_specs
                 * assoc_mlo_reconf
        software interface modes (can always be added):
                 * AP/VLAN
                 * monitor
        valid interface combinations:
                 * #{ IBSS } <= 1, #{ AP } <= 16, #{ managed } <= 19,
                   total <= 19, #channels <= 1, STA/AP BI must match, radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz, 80 MHz, 160 MHz }

        HT Capability overrides:
                 * MCS: ff ff ff ff ff ff ff ff ff ff
                 * maximum A-MSDU length
                 * supported channel width
                 * short GI for 40 MHz
                 * max A-MPDU length exponent
                 * min MPDU start spacing
        Device supports TX status socket option.
        Device supports HT-IBSS.
        Device supports SAE with AUTHENTICATE command
        Device supports low priority scan.
        Device supports scan flush.
        Device supports AP scan.
        Device supports per-vif TX power setting
        P2P GO supports CT window setting
        P2P GO supports opportunistic powersave setting
        Driver supports full state transitions for AP/GO clients
        Driver supports a userspace MPM
        Device supports active monitor (which will ACK incoming frames)
        Driver/device bandwidth changes during BSS lifetime (AP/GO mode)
        Device supports configuring vdev MAC-addr on create.
        max # scan plans: 1
        max scan plan interval: -1
        max scan plan iterations: 0
        Supported TX frame types:
                 * IBSS: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * managed: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * AP: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * AP/VLAN: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * mesh point: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * P2P-client: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * P2P-GO: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * P2P-device: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * NAN: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
        Supported RX frame types:
                 * IBSS: 0x40 0xb0 0xc0 0xd0
                 * managed: 0x40 0xb0 0xd0
                 * AP: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
                 * AP/VLAN: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
                 * mesh point: 0xb0 0xc0 0xd0
                 * P2P-client: 0x40 0xd0
                 * P2P-GO: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
                 * P2P-device: 0x40 0xb0 0xd0
                 * NAN: 0xb0 0xd0
        Supported extended features:
                * [ VHT_IBSS ]: VHT-IBSS
                * [ RRM ]: RRM
                * [ BEACON_RATE_LEGACY ]: legacy beacon rate setting
                * [ BEACON_RATE_HT ]: HT beacon rate setting
                * [ BEACON_RATE_VHT ]: VHT beacon rate setting
                * [ FILS_STA ]: STA FILS (Fast Initial Link Setup)
                * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
                * [ CONTROL_PORT_OVER_NL80211 ]: control port over nl80211
                * [ ACK_SIGNAL_SUPPORT ]: ack signal level support
                * [ TXQS ]: FQ-CoDel-enabled intermediate TXQs
                * [ SCAN_RANDOM_SN ]: use random sequence numbers in scans
                * [ SCAN_MIN_PREQ_CONTENT ]: use probe request with only rate IEs in scans
                * [ CAN_REPLACE_PTK0 ]: can safely replace PTK 0 when rekeying
                * [ AIRTIME_FAIRNESS ]: airtime fairness scheduling
                * [ STA_TX_PWR ]: TX power control per station
                * [ AQL ]: Airtime Queue Limits (AQL)
                * [ CONTROL_PORT_NO_PREAUTH ]: disable pre-auth over nl80211 control port support
                * [ DEL_IBSS_STA ]: deletion of IBSS station support
                * [ SCAN_FREQ_KHZ ]: scan on kHz frequency support
                * [ CONTROL_PORT_OVER_NL80211_TX_STATUS ]: tx status for nl80211 control port support
                * [ FILS_DISCOVERY ]: FILS discovery frame transmission support
                * [ UNSOL_BCAST_PROBE_RESP ]: unsolicated broadcast probe response transmission support
                * [ BEACON_RATE_HE ]: HE beacon rate support (AP/mesh)
                * [ BSS_COLOR ]: BSS coloring support
                * [ POWERED_ADDR_CHANGE ]: can change MAC address while up
Wiphy phy0
        wiphy index: 0
        max # scan SSIDs: 4
        max scan IEs length: 2200 bytes
        max # sched scan SSIDs: 0
        max # match sets: 0
        Retry short limit: 7
        Retry long limit: 4
        Coverage class: 0 (up to 0m)
        Device supports RSN-IBSS.
        Device supports AP-side u-APSD.
        Device supports T-DLS.
        Supported Ciphers:
                * WEP40 (00-0f-ac:1)
                * WEP104 (00-0f-ac:5)
                * TKIP (00-0f-ac:2)
                * CCMP-128 (00-0f-ac:4)
                * CCMP-256 (00-0f-ac:10)
                * GCMP-128 (00-0f-ac:8)
                * GCMP-256 (00-0f-ac:9)
                * CMAC (00-0f-ac:6)
                * CMAC-256 (00-0f-ac:13)
                * GMAC-128 (00-0f-ac:11)
                * GMAC-256 (00-0f-ac:12)
        Available Antennas: TX 0x3 RX 0x3
        Configured Antennas: TX 0x3 RX 0x3
        Supported interface modes:
                 * IBSS
                 * managed
                 * AP
                 * AP/VLAN
                 * monitor
                 * P2P-client
                 * P2P-GO
        Band 1:
                Capabilities: 0x9ff
                        RX LDPC
                        HT20/HT40
                        SM Power Save disabled
                        RX Greenfield
                        RX HT20 SGI
                        RX HT40 SGI
                        TX STBC
                        RX STBC 1-stream
                        Max AMSDU length: 7935 bytes
                        No DSSS/CCK HT40
                Maximum RX AMPDU length 65535 bytes (exponent: 0x003)
                Minimum RX AMPDU time spacing: 2 usec (0x04)
                HT TX/RX MCS rate indexes supported: 0-15
                HE Iftypes: managed
                        HE MAC Capabilities (0x08011a000040):
                                +HTC HE Supported
                                Trigger Frame MAC Padding Duration: 2
                                OM Control
                                Maximum A-MPDU Length Exponent: 3
                                A-MSDU in A-MPDU
                        HE PHY Capabilities: (0x22704e926d09f30e4e3f00):
                                HE40/2.4GHz
                                242 tone RUs/2.4GHz
                                Device Class: 1
                                LDPC Coding in Payload
                                HE SU PPDU with 1x HE-LTF and 0.8us GI
                                NDP with 4x HE-LTF and 3.2us GI
                                STBC Tx <= 80MHz
                                STBC Rx <= 80MHz
                                Full Bandwidth UL MU-MIMO
                                DCM Max Constellation: 2
                                DCM Max Constellation Rx: 2
                                SU Beamformer
                                SU Beamformee
                                Beamformee STS <= 80MHz: 3
                                Beamformee STS > 80MHz: 3
                                Sounding Dimensions <= 80MHz: 1
                                Sounding Dimensions > 80MHz: 1
                                Codebook Size SU Feedback
                                Codebook Size MU Feedback
                                Triggered CQI Feedback
                                Partial Bandwidth Extended Range
                                Partial Bandwidth DL MU-MIMO
                                PPE Threshold Present
                                Power Boost Factor ar
                                HE SU PPDU & HE PPDU 4x HE-LTF 0.8us GI
                                Max NC: 1
                                20MHz in 40MHz HE PPDU 2.4GHz
                                20MHz in 160/80+80MHz HE PPDU
                                80MHz in 160/80+80MHz HE PPDU
                                DCM Max BW: 1
                                Longer Than 16HE SIG-B OFDM Symbols
                                Non-Triggered CQI Feedback
                                TX 1024-QAM
                                RX 1024-QAM
                                RX Full BW SU Using HE MU PPDU with Compression SIGB
                                RX Full BW SU Using HE MU PPDU with Non-Compression SIGB
                        HE RX MCS and NSS set <= 80 MHz
                                1 streams: MCS 0-11
                                2 streams: MCS 0-11
                                3 streams: not supported
                                4 streams: not supported
                                5 streams: not supported
                                6 streams: not supported
                                7 streams: not supported
                                8 streams: not supported
                        HE TX MCS and NSS set <= 80 MHz
                                1 streams: MCS 0-11
                                2 streams: MCS 0-11
                                3 streams: not supported
                                4 streams: not supported
                                5 streams: not supported
                                6 streams: not supported
                                7 streams: not supported
                                8 streams: not supported
                        PPE Threshold 0x19 0x1c 0xc7 0x71
                HE Iftypes: AP
                        HE MAC Capabilities (0x00051a081044):
                                +HTC HE Supported
                                TWT Responder
                                BSR
                                OM Control
                                Maximum A-MPDU Length Exponent: 3
                                BQR
                                A-MSDU in A-MPDU
                                OM Control UL MU Data Disable RX
                        HE PHY Capabilities: (0x02204e926f09afc8000c00):
                                HE40/2.4GHz
                                LDPC Coding in Payload
                                NDP with 4x HE-LTF and 3.2us GI
                                STBC Tx <= 80MHz
                                STBC Rx <= 80MHz
                                Full Bandwidth UL MU-MIMO
                                DCM Max Constellation: 2
                                DCM Max Constellation Rx: 2
                                SU Beamformer
                                SU Beamformee
                                MU Beamformer
                                Beamformee STS <= 80MHz: 3
                                Beamformee STS > 80MHz: 3
                                Sounding Dimensions <= 80MHz: 1
                                Sounding Dimensions > 80MHz: 1
                                Codebook Size SU Feedback
                                Codebook Size MU Feedback
                                Triggered SU Beamforming Feedback
                                Triggered MU Beamforming Feedback
                                Partial Bandwidth Extended Range
                                PPE Threshold Present
                                Max NC: 1
                                STBC Tx > 80MHz
                                STBC Rx > 80MHz
                                TX 1024-QAM
                                RX 1024-QAM
                        HE RX MCS and NSS set <= 80 MHz
                                1 streams: MCS 0-11
                                2 streams: MCS 0-11
                                3 streams: not supported
                                4 streams: not supported
                                5 streams: not supported
                                6 streams: not supported
                                7 streams: not supported
                                8 streams: not supported
                        HE TX MCS and NSS set <= 80 MHz
                                1 streams: MCS 0-11
                                2 streams: MCS 0-11
                                3 streams: not supported
                                4 streams: not supported
                                5 streams: not supported
                                6 streams: not supported
                                7 streams: not supported
                                8 streams: not supported
                        PPE Threshold 0x19 0x1c 0xc7 0x71
                Bitrates (non-HT):
                        * 1.0 Mbps (short preamble supported)
                        * 2.0 Mbps (short preamble supported)
                        * 5.5 Mbps (short preamble supported)
                        * 11.0 Mbps (short preamble supported)
                        * 6.0 Mbps
                        * 9.0 Mbps
                        * 12.0 Mbps
                        * 18.0 Mbps
                        * 24.0 Mbps
                        * 36.0 Mbps
                        * 48.0 Mbps
                        * 54.0 Mbps
                Frequencies:
                        * 2412.0 MHz [1] (20.0 dBm)
                        * 2417.0 MHz [2] (20.0 dBm)
                        * 2422.0 MHz [3] (20.0 dBm)
                        * 2427.0 MHz [4] (20.0 dBm)
                        * 2432.0 MHz [5] (20.0 dBm)
                        * 2437.0 MHz [6] (20.0 dBm)
                        * 2442.0 MHz [7] (20.0 dBm)
                        * 2447.0 MHz [8] (20.0 dBm)
                        * 2452.0 MHz [9] (20.0 dBm)
                        * 2457.0 MHz [10] (20.0 dBm)
                        * 2462.0 MHz [11] (20.0 dBm)
                        * 2467.0 MHz [12] (20.0 dBm) (no IR)
                        * 2472.0 MHz [13] (20.0 dBm) (no IR)
                        * 2484.0 MHz [14] (20.0 dBm) (no IR)
        Supported commands:
                 * new_interface
                 * set_interface
                 * new_key
                 * start_ap
                 * new_station
                 * set_bss
                 * authenticate
                 * associate
                 * deauthenticate
                 * disassociate
                 * join_ibss
                 * remain_on_channel
                 * set_tx_bitrate_mask
                 * frame
                 * frame_wait_cancel
                 * set_wiphy_netns
                 * set_channel
                 * tdls_mgmt
                 * tdls_oper
                 * probe_client
                 * set_noack_map
                 * register_beacons
                 * start_p2p_device
                 * set_mcast_rate
                 * connect
                 * disconnect
                 * channel_switch
                 * set_qos_map
                 * set_multicast_to_unicast
                 * set_sar_specs
                 * assoc_mlo_reconf
        software interface modes (can always be added):
                 * AP/VLAN
                 * monitor
        valid interface combinations:
                 * #{ IBSS } <= 1, #{ AP } <= 16, #{ managed } <= 19,
                   total <= 19, #channels <= 1, STA/AP BI must match, radar detect widths: { 20 MHz (no HT), 20 MHz, 40 MHz, 80 MHz, 160 MHz }

        HT Capability overrides:
                 * MCS: ff ff ff ff ff ff ff ff ff ff
                 * maximum A-MSDU length
                 * supported channel width
                 * short GI for 40 MHz
                 * max A-MPDU length exponent
                 * min MPDU start spacing
        Device supports TX status socket option.
        Device supports HT-IBSS.
        Device supports SAE with AUTHENTICATE command
        Device supports low priority scan.
        Device supports scan flush.
        Device supports AP scan.
        Device supports per-vif TX power setting
        P2P GO supports CT window setting
        P2P GO supports opportunistic powersave setting
        Driver supports full state transitions for AP/GO clients
        Driver supports a userspace MPM
        Device supports active monitor (which will ACK incoming frames)
        Driver/device bandwidth changes during BSS lifetime (AP/GO mode)
        Device supports configuring vdev MAC-addr on create.
        max # scan plans: 1
        max scan plan interval: -1
        max scan plan iterations: 0
        Supported TX frame types:
                 * IBSS: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * managed: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * AP: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * AP/VLAN: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * mesh point: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * P2P-client: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * P2P-GO: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * P2P-device: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
                 * NAN: 0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70 0x80 0x90 0xa0 0xb0 0xc0 0xd0 0xe0 0xf0
        Supported RX frame types:
                 * IBSS: 0x40 0xb0 0xc0 0xd0
                 * managed: 0x40 0xb0 0xd0
                 * AP: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
                 * AP/VLAN: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
                 * mesh point: 0xb0 0xc0 0xd0
                 * P2P-client: 0x40 0xd0
                 * P2P-GO: 0x00 0x20 0x40 0xa0 0xb0 0xc0 0xd0
                 * P2P-device: 0x40 0xb0 0xd0
                 * NAN: 0xb0 0xd0
        Supported extended features:
                * [ VHT_IBSS ]: VHT-IBSS
                * [ RRM ]: RRM
                * [ BEACON_RATE_LEGACY ]: legacy beacon rate setting
                * [ BEACON_RATE_HT ]: HT beacon rate setting
                * [ BEACON_RATE_VHT ]: VHT beacon rate setting
                * [ FILS_STA ]: STA FILS (Fast Initial Link Setup)
                * [ CQM_RSSI_LIST ]: multiple CQM_RSSI_THOLD records
                * [ CONTROL_PORT_OVER_NL80211 ]: control port over nl80211
                * [ ACK_SIGNAL_SUPPORT ]: ack signal level support
                * [ TXQS ]: FQ-CoDel-enabled intermediate TXQs
                * [ SCAN_RANDOM_SN ]: use random sequence numbers in scans
                * [ SCAN_MIN_PREQ_CONTENT ]: use probe request with only rate IEs in scans
                * [ CAN_REPLACE_PTK0 ]: can safely replace PTK 0 when rekeying
                * [ AIRTIME_FAIRNESS ]: airtime fairness scheduling
                * [ STA_TX_PWR ]: TX power control per station
                * [ AQL ]: Airtime Queue Limits (AQL)
                * [ CONTROL_PORT_NO_PREAUTH ]: disable pre-auth over nl80211 control port support
                * [ DEL_IBSS_STA ]: deletion of IBSS station support
                * [ SCAN_FREQ_KHZ ]: scan on kHz frequency support
                * [ CONTROL_PORT_OVER_NL80211_TX_STATUS ]: tx status for nl80211 control port support
                * [ FILS_DISCOVERY ]: FILS discovery frame transmission support
                * [ UNSOL_BCAST_PROBE_RESP ]: unsolicated broadcast probe response transmission support
                * [ BEACON_RATE_HE ]: HE beacon rate support (AP/mesh)
                * [ BSS_COLOR ]: BSS coloring support
                * [ POWERED_ADDR_CHANGE ]: can change MAC address while up
```
