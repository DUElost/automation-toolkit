package jxl.biff.formula;

import java.util.Stack;
import jxl.Cell;
import jxl.WorkbookSettings;
import jxl.biff.WorkbookMethods;
import jxl.common.Assert;
import jxl.common.Logger;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class TokenFormulaParser implements Parser {
    static /* synthetic */ Class class$jxl$biff$formula$TokenFormulaParser;
    private static Logger logger;
    private WorkbookMethods nameTable;
    private Cell relativeTo;
    private ParseItem root;
    private WorkbookSettings settings;
    private byte[] tokenData;
    private ExternalSheet workbook;
    private int pos = 0;
    private Stack tokenStack = new Stack();

    static {
        Class cls = class$jxl$biff$formula$TokenFormulaParser;
        if (cls == null) {
            cls = class$("jxl.biff.formula.TokenFormulaParser");
            class$jxl$biff$formula$TokenFormulaParser = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public TokenFormulaParser(byte[] bArr, Cell cell, ExternalSheet externalSheet, WorkbookMethods workbookMethods, WorkbookSettings workbookSettings) {
        this.tokenData = bArr;
        this.relativeTo = cell;
        this.workbook = externalSheet;
        this.nameTable = workbookMethods;
        this.settings = workbookSettings;
        Assert.verify(this.nameTable != null);
    }

    private void addOperator(Operator operator) {
        operator.getOperands(this.tokenStack);
        this.tokenStack.push(operator);
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private void handleMemoryFunction(SubExpression subExpression) {
        int i = this.pos;
        this.pos = i + subExpression.read(this.tokenData, i);
        Stack stack = this.tokenStack;
        this.tokenStack = new Stack();
        parseSubExpression(subExpression.getLength());
        ParseItem[] parseItemArr = new ParseItem[this.tokenStack.size()];
        int i2 = 0;
        while (!this.tokenStack.isEmpty()) {
            parseItemArr[i2] = (ParseItem) this.tokenStack.pop();
            i2++;
        }
        subExpression.setSubExpression(parseItemArr);
        this.tokenStack = stack;
        stack.push(subExpression);
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r2v96, types: [jxl.biff.formula.Attribute, java.lang.Object] */
    /* JADX WARN: Type inference failed for: r4v0, types: [jxl.biff.formula.TokenFormulaParser] */
    /* JADX WARN: Type inference failed for: r5v22 */
    /* JADX WARN: Type inference failed for: r5v23, types: [jxl.biff.formula.Operator] */
    /* JADX WARN: Type inference failed for: r5v39, types: [jxl.biff.formula.Attribute, java.lang.Object] */
    /* JADX WARN: Type inference failed for: r5v41, types: [jxl.biff.formula.VariableArgFunction] */
    /* JADX WARN: Type inference failed for: r5v46 */
    /* JADX WARN: Type inference failed for: r5v47 */
    /* JADX WARN: Type inference failed for: r5v48 */
    /* JADX WARN: Type inference failed for: r5v49 */
    /* JADX WARN: Type inference failed for: r5v50 */
    /* JADX WARN: Type inference failed for: r5v51 */
    /* JADX WARN: Type inference failed for: r5v52 */
    /* JADX WARN: Type inference failed for: r5v53 */
    /* JADX WARN: Type inference failed for: r5v54 */
    /* JADX WARN: Type inference failed for: r5v55 */
    /* JADX WARN: Type inference failed for: r5v56 */
    /* JADX WARN: Type inference failed for: r5v57 */
    /* JADX WARN: Type inference failed for: r5v58 */
    /* JADX WARN: Type inference failed for: r5v59 */
    /* JADX WARN: Type inference failed for: r5v60 */
    /* JADX WARN: Type inference failed for: r5v61 */
    /* JADX WARN: Type inference failed for: r5v62 */
    private void parseSubExpression(int i) {
        ParsedThing cellReference;
        int i2;
        int read;
        int i3;
        int read2;
        ?? r5;
        SubExpression memFunc;
        Stack stack = new Stack();
        int i4 = this.pos + i;
        while (true) {
            int i5 = this.pos;
            if (i5 >= i4) {
                return;
            }
            byte b2 = this.tokenData[i5];
            this.pos = i5 + 1;
            Token token = Token.getToken(b2);
            Token token2 = Token.UNKNOWN;
            if (token == token2) {
                throw new FormulaException(FormulaException.UNRECOGNIZED_TOKEN, b2);
            }
            Assert.verify(token != token2);
            if (token == Token.REF) {
                cellReference = new CellReference(this.relativeTo);
                i2 = this.pos;
                read = cellReference.read(this.tokenData, i2);
            } else if (token == Token.REFERR) {
                cellReference = new CellReferenceError();
                i2 = this.pos;
                read = cellReference.read(this.tokenData, i2);
            } else if (token == Token.ERR) {
                cellReference = new ErrorConstant();
                i2 = this.pos;
                read = cellReference.read(this.tokenData, i2);
            } else if (token == Token.REFV) {
                cellReference = new SharedFormulaCellReference(this.relativeTo);
                i2 = this.pos;
                read = cellReference.read(this.tokenData, i2);
            } else if (token == Token.REF3D) {
                cellReference = new CellReference3d(this.relativeTo, this.workbook);
                i2 = this.pos;
                read = cellReference.read(this.tokenData, i2);
            } else if (token == Token.AREA) {
                cellReference = new Area();
                i2 = this.pos;
                read = cellReference.read(this.tokenData, i2);
            } else if (token == Token.AREAV) {
                cellReference = new SharedFormulaArea(this.relativeTo);
                i2 = this.pos;
                read = cellReference.read(this.tokenData, i2);
            } else if (token == Token.AREA3D) {
                cellReference = new Area3d(this.workbook);
                i2 = this.pos;
                read = cellReference.read(this.tokenData, i2);
            } else if (token == Token.NAME) {
                cellReference = new Name();
                i2 = this.pos;
                read = cellReference.read(this.tokenData, i2);
            } else if (token == Token.NAMED_RANGE) {
                cellReference = new NameRange(this.nameTable);
                i2 = this.pos;
                read = cellReference.read(this.tokenData, i2);
            } else if (token == Token.INTEGER) {
                cellReference = new IntegerValue();
                i2 = this.pos;
                read = cellReference.read(this.tokenData, i2);
            } else if (token == Token.DOUBLE) {
                cellReference = new DoubleValue();
                i2 = this.pos;
                read = cellReference.read(this.tokenData, i2);
            } else if (token == Token.BOOL) {
                cellReference = new BooleanValue();
                i2 = this.pos;
                read = cellReference.read(this.tokenData, i2);
            } else if (token == Token.STRING) {
                cellReference = new StringValue(this.settings);
                i2 = this.pos;
                read = cellReference.read(this.tokenData, i2);
            } else if (token == Token.MISSING_ARG) {
                cellReference = new MissingArg();
                i2 = this.pos;
                read = cellReference.read(this.tokenData, i2);
            } else {
                if (token == Token.UNARY_PLUS) {
                    UnaryPlus unaryPlus = new UnaryPlus();
                    i3 = this.pos;
                    read2 = unaryPlus.read(this.tokenData, i3);
                    r5 = unaryPlus;
                } else if (token == Token.UNARY_MINUS) {
                    UnaryMinus unaryMinus = new UnaryMinus();
                    i3 = this.pos;
                    read2 = unaryMinus.read(this.tokenData, i3);
                    r5 = unaryMinus;
                } else if (token == Token.PERCENT) {
                    Percent percent = new Percent();
                    i3 = this.pos;
                    read2 = percent.read(this.tokenData, i3);
                    r5 = percent;
                } else if (token == Token.SUBTRACT) {
                    Subtract subtract = new Subtract();
                    i3 = this.pos;
                    read2 = subtract.read(this.tokenData, i3);
                    r5 = subtract;
                } else if (token == Token.ADD) {
                    Add add = new Add();
                    i3 = this.pos;
                    read2 = add.read(this.tokenData, i3);
                    r5 = add;
                } else if (token == Token.MULTIPLY) {
                    Multiply multiply = new Multiply();
                    i3 = this.pos;
                    read2 = multiply.read(this.tokenData, i3);
                    r5 = multiply;
                } else if (token == Token.DIVIDE) {
                    Divide divide = new Divide();
                    i3 = this.pos;
                    read2 = divide.read(this.tokenData, i3);
                    r5 = divide;
                } else if (token == Token.CONCAT) {
                    Concatenate concatenate = new Concatenate();
                    i3 = this.pos;
                    read2 = concatenate.read(this.tokenData, i3);
                    r5 = concatenate;
                } else if (token == Token.POWER) {
                    Power power = new Power();
                    i3 = this.pos;
                    read2 = power.read(this.tokenData, i3);
                    r5 = power;
                } else if (token == Token.LESS_THAN) {
                    LessThan lessThan = new LessThan();
                    i3 = this.pos;
                    read2 = lessThan.read(this.tokenData, i3);
                    r5 = lessThan;
                } else if (token == Token.LESS_EQUAL) {
                    LessEqual lessEqual = new LessEqual();
                    i3 = this.pos;
                    read2 = lessEqual.read(this.tokenData, i3);
                    r5 = lessEqual;
                } else if (token == Token.GREATER_THAN) {
                    GreaterThan greaterThan = new GreaterThan();
                    i3 = this.pos;
                    read2 = greaterThan.read(this.tokenData, i3);
                    r5 = greaterThan;
                } else if (token == Token.GREATER_EQUAL) {
                    GreaterEqual greaterEqual = new GreaterEqual();
                    i3 = this.pos;
                    read2 = greaterEqual.read(this.tokenData, i3);
                    r5 = greaterEqual;
                } else if (token == Token.NOT_EQUAL) {
                    NotEqual notEqual = new NotEqual();
                    i3 = this.pos;
                    read2 = notEqual.read(this.tokenData, i3);
                    r5 = notEqual;
                } else if (token == Token.EQUAL) {
                    Equal equal = new Equal();
                    i3 = this.pos;
                    read2 = equal.read(this.tokenData, i3);
                    r5 = equal;
                } else if (token == Token.PARENTHESIS) {
                    Parenthesis parenthesis = new Parenthesis();
                    i3 = this.pos;
                    read2 = parenthesis.read(this.tokenData, i3);
                    r5 = parenthesis;
                } else if (token == Token.ATTRIBUTE) {
                    r5 = new Attribute(this.settings);
                    int i6 = this.pos;
                    this.pos = i6 + r5.read(this.tokenData, i6);
                    if (r5.isSum()) {
                        addOperator(r5);
                    } else if (r5.isIf()) {
                        stack.push(r5);
                    }
                } else if (token == Token.FUNCTION) {
                    BuiltInFunction builtInFunction = new BuiltInFunction(this.settings);
                    i3 = this.pos;
                    read2 = builtInFunction.read(this.tokenData, i3);
                    r5 = builtInFunction;
                } else if (token == Token.FUNCTIONVARARG) {
                    r5 = new VariableArgFunction(this.settings);
                    int i7 = this.pos;
                    this.pos = i7 + r5.read(this.tokenData, i7);
                    if (r5.getFunction() != Function.ATTRIBUTE) {
                        addOperator(r5);
                    } else {
                        r5.getOperands(this.tokenStack);
                        Attribute attribute = stack.empty() ? new Attribute(this.settings) : (Attribute) stack.pop();
                        attribute.setIfConditions(r5);
                        this.tokenStack.push(attribute);
                    }
                } else {
                    if (token == Token.MEM_FUNC) {
                        memFunc = new MemFunc();
                    } else if (token == Token.MEM_AREA) {
                        memFunc = new MemArea();
                    }
                    handleMemoryFunction(memFunc);
                }
                this.pos = i3 + read2;
                addOperator(r5);
            }
            this.pos = i2 + read;
            this.tokenStack.push(cellReference);
        }
    }

    @Override // jxl.biff.formula.Parser
    public void adjustRelativeCellReferences(int i, int i2) {
        this.root.adjustRelativeCellReferences(i, i2);
    }

    @Override // jxl.biff.formula.Parser
    public void columnInserted(int i, int i2, boolean z) {
        this.root.columnInserted(i, i2, z);
    }

    @Override // jxl.biff.formula.Parser
    public void columnRemoved(int i, int i2, boolean z) {
        this.root.columnRemoved(i, i2, z);
    }

    @Override // jxl.biff.formula.Parser
    public byte[] getBytes() {
        return this.root.getBytes();
    }

    @Override // jxl.biff.formula.Parser
    public String getFormula() {
        StringBuffer stringBuffer = new StringBuffer();
        this.root.getString(stringBuffer);
        return stringBuffer.toString();
    }

    @Override // jxl.biff.formula.Parser
    public boolean handleImportedCellReferences() {
        this.root.handleImportedCellReferences();
        return this.root.isValid();
    }

    @Override // jxl.biff.formula.Parser
    public void parse() {
        parseSubExpression(this.tokenData.length);
        this.root = (ParseItem) this.tokenStack.pop();
        Assert.verify(this.tokenStack.empty());
    }

    @Override // jxl.biff.formula.Parser
    public void rowInserted(int i, int i2, boolean z) {
        this.root.rowInserted(i, i2, z);
    }

    @Override // jxl.biff.formula.Parser
    public void rowRemoved(int i, int i2, boolean z) {
        this.root.rowRemoved(i, i2, z);
    }
}
