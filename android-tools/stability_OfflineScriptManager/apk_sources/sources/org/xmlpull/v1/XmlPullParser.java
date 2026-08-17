package org.xmlpull.v1;
/* loaded from: classes.dex */
public interface XmlPullParser {
    String getAttributeValue(String str, String str2);

    int getDepth();

    int getEventType();

    String getName();

    String getPositionDescription();

    int next();

    void require(int i, String str, String str2);
}
