package jxl.biff;

import jxl.common.Logger;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public abstract class HeaderFooter {
    private static final String BOLD_TOGGLE = "&B";
    private static final String CENTRE = "&C";
    private static final String DATE = "&D";
    private static final String DOUBLE_UNDERLINE_TOGGLE = "&E";
    private static final String ITALICS_TOGGLE = "&I";
    private static final String LEFT_ALIGN = "&L";
    private static final String OUTLINE_TOGGLE = "&O";
    private static final String PAGENUM = "&P";
    private static final String RIGHT_ALIGN = "&R";
    private static final String SHADOW_TOGGLE = "&H";
    private static final String STRIKETHROUGH_TOGGLE = "&S";
    private static final String SUBSCRIPT_TOGGLE = "&Y";
    private static final String SUPERSCRIPT_TOGGLE = "&X";
    private static final String TIME = "&T";
    private static final String TOTAL_PAGENUM = "&N";
    private static final String UNDERLINE_TOGGLE = "&U";
    private static final String WORKBOOK_NAME = "&F";
    private static final String WORKSHEET_NAME = "&A";
    static /* synthetic */ Class class$jxl$biff$HeaderFooter;
    private static Logger logger;
    private Contents centre;
    private Contents left;
    private Contents right;

    /* loaded from: classes.dex */
    protected static class Contents {
        private StringBuffer contents;

        /* JADX INFO: Access modifiers changed from: protected */
        public Contents() {
            this.contents = new StringBuffer();
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public Contents(String str) {
            this.contents = new StringBuffer(str);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public Contents(Contents contents) {
            this.contents = new StringBuffer(contents.getContents());
        }

        private void appendInternal(char c2) {
            if (this.contents == null) {
                this.contents = new StringBuffer();
            }
            this.contents.append(c2);
        }

        private void appendInternal(String str) {
            if (this.contents == null) {
                this.contents = new StringBuffer();
            }
            this.contents.append(str);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void append(String str) {
            appendInternal(str);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void appendDate() {
            appendInternal(HeaderFooter.DATE);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void appendPageNumber() {
            appendInternal(HeaderFooter.PAGENUM);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void appendTime() {
            appendInternal(HeaderFooter.TIME);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void appendTotalPages() {
            appendInternal(HeaderFooter.TOTAL_PAGENUM);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void appendWorkSheetName() {
            appendInternal(HeaderFooter.WORKSHEET_NAME);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void appendWorkbookName() {
            appendInternal(HeaderFooter.WORKBOOK_NAME);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void clear() {
            this.contents = null;
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public boolean empty() {
            StringBuffer stringBuffer = this.contents;
            return stringBuffer == null || stringBuffer.length() == 0;
        }

        protected String getContents() {
            StringBuffer stringBuffer = this.contents;
            return stringBuffer != null ? stringBuffer.toString() : BuildConfig.FLAVOR;
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void setFontName(String str) {
            appendInternal("&\"");
            appendInternal(str);
            appendInternal('\"');
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public boolean setFontSize(int i) {
            String num;
            if (i < 1 || i > 99) {
                return false;
            }
            if (i < 10) {
                StringBuffer stringBuffer = new StringBuffer();
                stringBuffer.append("0");
                stringBuffer.append(i);
                num = stringBuffer.toString();
            } else {
                num = Integer.toString(i);
            }
            appendInternal('&');
            appendInternal(num);
            return true;
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void toggleBold() {
            appendInternal(HeaderFooter.BOLD_TOGGLE);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void toggleDoubleUnderline() {
            appendInternal(HeaderFooter.DOUBLE_UNDERLINE_TOGGLE);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void toggleItalics() {
            appendInternal(HeaderFooter.ITALICS_TOGGLE);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void toggleOutline() {
            appendInternal(HeaderFooter.OUTLINE_TOGGLE);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void toggleShadow() {
            appendInternal(HeaderFooter.SHADOW_TOGGLE);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void toggleStrikethrough() {
            appendInternal(HeaderFooter.STRIKETHROUGH_TOGGLE);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void toggleSubScript() {
            appendInternal(HeaderFooter.SUBSCRIPT_TOGGLE);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void toggleSuperScript() {
            appendInternal(HeaderFooter.SUPERSCRIPT_TOGGLE);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        public void toggleUnderline() {
            appendInternal(HeaderFooter.UNDERLINE_TOGGLE);
        }
    }

    static {
        Class cls = class$jxl$biff$HeaderFooter;
        if (cls == null) {
            cls = class$("jxl.biff.HeaderFooter");
            class$jxl$biff$HeaderFooter = cls;
        }
        logger = Logger.getLogger(cls);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public HeaderFooter() {
        this.left = createContents();
        this.right = createContents();
        this.centre = createContents();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public HeaderFooter(String str) {
        if (str == null || str.length() == 0) {
            this.left = createContents();
            this.right = createContents();
            this.centre = createContents();
            return;
        }
        int i = 0;
        int indexOf = str.indexOf(LEFT_ALIGN);
        int indexOf2 = str.indexOf(RIGHT_ALIGN);
        int indexOf3 = str.indexOf(CENTRE);
        if (indexOf == 0) {
            if (indexOf3 != -1) {
                this.left = createContents(str.substring(2, indexOf3));
                i = indexOf3;
            } else if (indexOf2 != -1) {
                this.left = createContents(str.substring(2, indexOf2));
                i = indexOf2;
            } else {
                this.left = createContents(str.substring(2));
                i = str.length();
            }
        }
        if (i == indexOf3 || (indexOf == -1 && indexOf2 == -1 && indexOf3 == -1)) {
            if (indexOf2 != -1) {
                this.centre = createContents(str.substring(i + 2, indexOf2));
                i = indexOf2;
            } else {
                this.centre = createContents(str.substring(i == indexOf3 ? i + 2 : i));
                i = str.length();
            }
        }
        if (i == indexOf2) {
            this.right = createContents(str.substring(i + 2));
            str.length();
        }
        if (this.left == null) {
            this.left = createContents();
        }
        if (this.centre == null) {
            this.centre = createContents();
        }
        if (this.right == null) {
            this.right = createContents();
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public HeaderFooter(HeaderFooter headerFooter) {
        this.left = createContents(headerFooter.left);
        this.right = createContents(headerFooter.right);
        this.centre = createContents(headerFooter.centre);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void clear() {
        this.left.clear();
        this.right.clear();
        this.centre.clear();
    }

    protected abstract Contents createContents();

    protected abstract Contents createContents(String str);

    protected abstract Contents createContents(Contents contents);

    /* JADX INFO: Access modifiers changed from: protected */
    public Contents getCentreText() {
        return this.centre;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public Contents getLeftText() {
        return this.left;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public Contents getRightText() {
        return this.right;
    }

    public String toString() {
        StringBuffer stringBuffer = new StringBuffer();
        if (!this.left.empty()) {
            stringBuffer.append(LEFT_ALIGN);
            stringBuffer.append(this.left.getContents());
        }
        if (!this.centre.empty()) {
            stringBuffer.append(CENTRE);
            stringBuffer.append(this.centre.getContents());
        }
        if (!this.right.empty()) {
            stringBuffer.append(RIGHT_ALIGN);
            stringBuffer.append(this.right.getContents());
        }
        return stringBuffer.toString();
    }
}
