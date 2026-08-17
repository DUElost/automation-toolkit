package com.sun.activation.registries;

import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class MailcapTokenizer {
    public static final int EOI_TOKEN = 5;
    public static final int EQUALS_TOKEN = 61;
    public static final int SEMICOLON_TOKEN = 59;
    public static final int SLASH_TOKEN = 47;
    public static final int START_TOKEN = 1;
    public static final int STRING_TOKEN = 2;
    public static final int UNKNOWN_TOKEN = 0;
    private String data;
    private int dataLength;
    private int dataIndex = 0;
    private int currentToken = 1;
    private String currentTokenValue = BuildConfig.FLAVOR;
    private boolean isAutoquoting = false;
    private char autoquoteChar = ';';

    public MailcapTokenizer(String str) {
        this.data = str;
        this.dataLength = str.length();
    }

    private static String fixEscapeSequences(String str) {
        int length = str.length();
        StringBuffer stringBuffer = new StringBuffer();
        stringBuffer.ensureCapacity(length);
        int i = 0;
        while (i < length) {
            char charAt = str.charAt(i);
            if (charAt == '\\' && i < length - 1) {
                i++;
                charAt = str.charAt(i);
            }
            stringBuffer.append(charAt);
            i++;
        }
        return stringBuffer.toString();
    }

    private static boolean isControlChar(char c2) {
        return Character.isISOControl(c2);
    }

    private static boolean isSpecialChar(char c2) {
        if (c2 != '\"' && c2 != ',' && c2 != '/' && c2 != '(' && c2 != ')') {
            switch (c2) {
                case ':':
                case ';':
                case '<':
                case '=':
                case '>':
                case '?':
                case '@':
                    break;
                default:
                    switch (c2) {
                        case '[':
                        case '\\':
                        case ']':
                            break;
                        default:
                            return false;
                    }
            }
        }
        return true;
    }

    private static boolean isStringTokenChar(char c2) {
        return (isSpecialChar(c2) || isControlChar(c2) || isWhiteSpaceChar(c2)) ? false : true;
    }

    private static boolean isWhiteSpaceChar(char c2) {
        return Character.isWhitespace(c2);
    }

    public static String nameForToken(int i) {
        return i != 0 ? i != 1 ? i != 2 ? i != 5 ? i != 47 ? i != 59 ? i != 61 ? "really unknown" : "'='" : "';'" : "'/'" : "EOI" : "string" : "start" : "unknown";
    }

    private void processAutoquoteToken() {
        int i;
        int i2 = this.dataIndex;
        boolean z = false;
        while (true) {
            i = this.dataIndex;
            if (i >= this.dataLength || z) {
                break;
            } else if (this.data.charAt(i) != this.autoquoteChar) {
                this.dataIndex++;
            } else {
                z = true;
            }
        }
        this.currentToken = 2;
        this.currentTokenValue = fixEscapeSequences(this.data.substring(i2, i));
    }

    private void processStringToken() {
        int i = this.dataIndex;
        while (true) {
            int i2 = this.dataIndex;
            if (i2 >= this.dataLength || !isStringTokenChar(this.data.charAt(i2))) {
                break;
            }
            this.dataIndex++;
        }
        this.currentToken = 2;
        this.currentTokenValue = this.data.substring(i, this.dataIndex);
    }

    public int getCurrentToken() {
        return this.currentToken;
    }

    public String getCurrentTokenValue() {
        return this.currentTokenValue;
    }

    public int nextToken() {
        Character ch;
        if (this.dataIndex < this.dataLength) {
            while (true) {
                int i = this.dataIndex;
                if (i >= this.dataLength || !isWhiteSpaceChar(this.data.charAt(i))) {
                    break;
                }
                this.dataIndex++;
            }
            int i2 = this.dataIndex;
            if (i2 < this.dataLength) {
                char charAt = this.data.charAt(i2);
                if (this.isAutoquoting) {
                    if (charAt == ';' || charAt == '=') {
                        this.currentToken = charAt;
                        ch = new Character(charAt);
                        this.currentTokenValue = ch.toString();
                        this.dataIndex++;
                    } else {
                        processAutoquoteToken();
                    }
                } else if (isStringTokenChar(charAt)) {
                    processStringToken();
                } else {
                    if (charAt == '/' || charAt == ';' || charAt == '=') {
                        this.currentToken = charAt;
                        ch = new Character(charAt);
                    } else {
                        this.currentToken = 0;
                        ch = new Character(charAt);
                    }
                    this.currentTokenValue = ch.toString();
                    this.dataIndex++;
                }
                return this.currentToken;
            }
        }
        this.currentToken = 5;
        this.currentTokenValue = null;
        return this.currentToken;
    }

    public void setIsAutoquoting(boolean z) {
        this.isAutoquoting = z;
    }
}
