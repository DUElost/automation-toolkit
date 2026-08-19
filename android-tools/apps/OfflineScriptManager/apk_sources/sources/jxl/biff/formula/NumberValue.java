package jxl.biff.formula;
/* loaded from: classes.dex */
abstract class NumberValue extends Operand implements ParsedThing {
    @Override // jxl.biff.formula.ParseItem
    public void getString(StringBuffer stringBuffer) {
        stringBuffer.append(Double.toString(getValue()));
    }

    public abstract double getValue();
}
