package jxl.biff.formula;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Stack;
import jxl.WorkbookSettings;
import jxl.biff.WorkbookMethods;
import jxl.biff.formula.FormulaException;
import jxl.common.Logger;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class StringFormulaParser implements Parser {
    static /* synthetic */ Class class$jxl$biff$formula$StringFormulaParser;
    private static Logger logger;
    private Stack arguments;
    private ExternalSheet externalSheet;
    private String formula;
    private WorkbookMethods nameTable;
    private ParseContext parseContext;
    private String parsedFormula;
    private ParseItem root;
    private WorkbookSettings settings;

    static {
        Class cls = class$jxl$biff$formula$StringFormulaParser;
        if (cls == null) {
            cls = class$("jxl.biff.formula.StringFormulaParser");
            class$jxl$biff$formula$StringFormulaParser = cls;
        }
        logger = Logger.getLogger(cls);
    }

    public StringFormulaParser(String str, ExternalSheet externalSheet, WorkbookMethods workbookMethods, WorkbookSettings workbookSettings, ParseContext parseContext) {
        this.formula = str;
        this.settings = workbookSettings;
        this.externalSheet = externalSheet;
        this.nameTable = workbookMethods;
        this.parseContext = parseContext;
    }

    static /* synthetic */ Class class$(String str) {
        try {
            return Class.forName(str);
        } catch (ClassNotFoundException e) {
            throw new NoClassDefFoundError(e.getMessage());
        }
    }

    private ArrayList getTokens() {
        ArrayList arrayList = new ArrayList();
        Yylex yylex = new Yylex(new StringReader(this.formula));
        yylex.setExternalSheet(this.externalSheet);
        yylex.setNameTable(this.nameTable);
        while (true) {
            try {
                ParseItem yylex2 = yylex.yylex();
                if (yylex2 == null) {
                    break;
                }
                arrayList.add(yylex2);
            } catch (IOException e) {
                logger.warn(e.toString());
            } catch (Error unused) {
                FormulaException.FormulaMessage formulaMessage = FormulaException.LEXICAL_ERROR;
                StringBuffer stringBuffer = new StringBuffer();
                stringBuffer.append(this.formula);
                stringBuffer.append(" at char  ");
                stringBuffer.append(yylex.getPos());
                throw new FormulaException(formulaMessage, stringBuffer.toString());
            }
        }
        return arrayList;
    }

    private void handleFunction(StringFunction stringFunction, Iterator it, Stack stack) {
        ParseItem parseCurrent = parseCurrent(it);
        if (stringFunction.getFunction(this.settings) == Function.UNKNOWN) {
            throw new FormulaException(FormulaException.UNRECOGNIZED_FUNCTION);
        }
        if (stringFunction.getFunction(this.settings) == Function.SUM && this.arguments == null) {
            Attribute attribute = new Attribute(stringFunction, this.settings);
            attribute.add(parseCurrent);
            stack.push(attribute);
            return;
        }
        if (stringFunction.getFunction(this.settings) == Function.IF) {
            Attribute attribute2 = new Attribute(stringFunction, this.settings);
            VariableArgFunction variableArgFunction = new VariableArgFunction(this.settings);
            int size = this.arguments.size();
            while (r2 < size) {
                variableArgFunction.add((ParseItem) this.arguments.get(r2));
                r2++;
            }
            attribute2.setIfConditions(variableArgFunction);
            stack.push(attribute2);
        } else if (stringFunction.getFunction(this.settings).getNumArgs() != 255) {
            BuiltInFunction builtInFunction = new BuiltInFunction(stringFunction.getFunction(this.settings), this.settings);
            int numArgs = stringFunction.getFunction(this.settings).getNumArgs();
            if (numArgs == 1) {
                builtInFunction.add(parseCurrent);
            } else {
                Stack stack2 = this.arguments;
                if ((stack2 == null && numArgs != 0) || (stack2 != null && numArgs != stack2.size())) {
                    throw new FormulaException(FormulaException.INCORRECT_ARGUMENTS);
                }
                while (r2 < numArgs) {
                    builtInFunction.add((ParseItem) this.arguments.get(r2));
                    r2++;
                }
            }
            stack.push(builtInFunction);
        } else {
            Stack stack3 = this.arguments;
            if (stack3 == null) {
                VariableArgFunction variableArgFunction2 = new VariableArgFunction(stringFunction.getFunction(this.settings), parseCurrent != null ? 1 : 0, this.settings);
                if (parseCurrent != null) {
                    variableArgFunction2.add(parseCurrent);
                }
                stack.push(variableArgFunction2);
                return;
            }
            int size2 = stack3.size();
            VariableArgFunction variableArgFunction3 = new VariableArgFunction(stringFunction.getFunction(this.settings), size2, this.settings);
            ParseItem[] parseItemArr = new ParseItem[size2];
            for (int i = 0; i < size2; i++) {
                parseItemArr[(size2 - i) - 1] = (ParseItem) this.arguments.pop();
            }
            while (r2 < size2) {
                variableArgFunction3.add(parseItemArr[r2]);
                r2++;
            }
            stack.push(variableArgFunction3);
            this.arguments.clear();
            this.arguments = null;
        }
    }

    private void handleOperand(Operand operand, Stack stack) {
        boolean z = operand instanceof IntegerValue;
        if (!z) {
            stack.push(operand);
        } else if (z) {
            IntegerValue integerValue = (IntegerValue) operand;
            if (integerValue.isOutOfRange()) {
                stack.push(new DoubleValue(integerValue.getValue()));
            } else {
                stack.push(integerValue);
            }
        }
    }

    private ParseItem parseCurrent(Iterator it) {
        Stack stack = new Stack();
        Stack stack2 = new Stack();
        boolean z = false;
        Stack stack3 = null;
        ParseItem parseItem = null;
        while (it.hasNext() && !z) {
            ParseItem parseItem2 = (ParseItem) it.next();
            parseItem2.setParseContext(this.parseContext);
            if (parseItem2 instanceof Operand) {
                handleOperand((Operand) parseItem2, stack);
            } else if (parseItem2 instanceof StringFunction) {
                handleFunction((StringFunction) parseItem2, it, stack);
            } else if (parseItem2 instanceof Operator) {
                Operator operator = (Operator) parseItem2;
                if (operator instanceof StringOperator) {
                    StringOperator stringOperator = (StringOperator) operator;
                    operator = (stack.isEmpty() || (parseItem instanceof Operator)) ? stringOperator.getUnaryOperator() : stringOperator.getBinaryOperator();
                }
                if (!stack2.empty()) {
                    Operator operator2 = (Operator) stack2.peek();
                    if (operator.getPrecedence() >= operator2.getPrecedence() && (operator.getPrecedence() != operator2.getPrecedence() || !(operator instanceof UnaryOperator))) {
                        stack2.pop();
                        operator2.getOperands(stack);
                        stack.push(operator2);
                    }
                }
                stack2.push(operator);
            } else if (parseItem2 instanceof ArgumentSeparator) {
                while (!stack2.isEmpty()) {
                    Operator operator3 = (Operator) stack2.pop();
                    operator3.getOperands(stack);
                    stack.push(operator3);
                }
                if (stack3 == null) {
                    stack3 = new Stack();
                }
                stack3.push(stack.pop());
                stack.clear();
            } else if (parseItem2 instanceof OpenParentheses) {
                ParseItem parseCurrent = parseCurrent(it);
                Parenthesis parenthesis = new Parenthesis();
                parseCurrent.setParent(parenthesis);
                parenthesis.add(parseCurrent);
                stack.push(parenthesis);
            } else if (parseItem2 instanceof CloseParentheses) {
                z = true;
            }
            parseItem = parseItem2;
        }
        while (!stack2.isEmpty()) {
            Operator operator4 = (Operator) stack2.pop();
            operator4.getOperands(stack);
            stack.push(operator4);
        }
        ParseItem parseItem3 = stack.empty() ? null : (ParseItem) stack.pop();
        if (stack3 != null && parseItem3 != null) {
            stack3.push(parseItem3);
        }
        this.arguments = stack3;
        if (!stack.empty() || !stack2.empty()) {
            Logger logger2 = logger;
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append("Formula ");
            stringBuffer.append(this.formula);
            stringBuffer.append(" has a non-empty parse stack");
            logger2.warn(stringBuffer.toString());
        }
        return parseItem3;
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
        byte[] bytes = this.root.getBytes();
        if (this.root.isVolatile()) {
            byte[] bArr = new byte[bytes.length + 4];
            System.arraycopy(bytes, 0, bArr, 4, bytes.length);
            bArr[0] = Token.ATTRIBUTE.getCode();
            bArr[1] = 1;
            return bArr;
        }
        return bytes;
    }

    @Override // jxl.biff.formula.Parser
    public String getFormula() {
        if (this.parsedFormula == null) {
            StringBuffer stringBuffer = new StringBuffer();
            this.root.getString(stringBuffer);
            this.parsedFormula = stringBuffer.toString();
        }
        return this.parsedFormula;
    }

    @Override // jxl.biff.formula.Parser
    public boolean handleImportedCellReferences() {
        this.root.handleImportedCellReferences();
        return this.root.isValid();
    }

    @Override // jxl.biff.formula.Parser
    public void parse() {
        this.root = parseCurrent(getTokens().iterator());
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
