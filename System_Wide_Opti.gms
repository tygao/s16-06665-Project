$ TITLE  BATCHREACT
$ OFFSYMXREF
$ OFFSYMLIST

OPTION LIMROW=0;
OPTION LIMCOL=0;

* VARIABLES AND THEIR MEANING
POSITIVE VARIABLES X1,X2,X3,X4,X5,X6,X7,a,b,c,d,e,f,C1,C2,C3,C4,C5,C6,Tin,Tout,delH,k,Ca;
*X1 Salicylic Acid kg per batch
*X2 Acetic Anhydride kg per batch
*X3 Aspirin kg per batch
*X4 Acetic Acid kg per batch
*X5 Toluene kg per batch
*X6 Conversion
*X7 Water used in utility;

Parameters
M1 Mole mass of Salicylic Acid /0.1381/
M2 Mole mass of Acetic Anhydride /0.1021/
M3 Mole mass of Aspirin /0.1802/
M4 Mole mass of Acetic Acid /0.0601/
M5 Mole mass of toluene /0.0921/
Mw Mole mass of water /0.018/

VARIABLE OBJ;

* EQUATIONS FOR THE NLP
EQUATIONS E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,E18,E19,E20,E21,E22,E23,E24,E25,E26,E27,E28;

* INITIALLY WE WILL DECLARE ALL THE VALUES WE KNOW
* COST OF SALICYLIC ACID
E1..a =E= 5667.8;
* COST OF ACETIC ANHYDRIDE
E2..b =E= 2009.24;
* COST OF ASPIRIN
E3..c =E= 8881.6;
* COST OF ACETIC ACID
E4..d =E= 42.65;
* COST OF TOLUENE
E5..e =E= 313.7;
* COST OF UTILITY WATER (USED FOR HEATING), WE CONSIDER IT TO BE UNITY
E6..f =E= 1;
* HEAT CAPACITY OF SALICYLIC ACID
E7..C1 =E= 161;
* HEAT CAPACITY OF ACETIC ANHYDRIDE
E8..C2 =E= 168.2;
* HEAT CAPACITY OF ASPIRIN
E9..C3 =E= 227;
* HEAT CAPACITY OF ACETIC ACID
E10..C4 =E= 139.7;
* HEAT CAPACITY OF TOLUENE
E11..C5 =E= 155.96;
* HEAT CAPACITY OF WATER
E12..C6 =E= 75.6;
* TEMPERATURE AT WHICH INPUT IS CHARGED IN REACTOR
E13..Tin =E= 302;
* TEMPERATURE AT WHICH THE OUTPUT IS RECEIVED FROM THE REACTOR
E14..Tout =E= 333;
* HEAT OF REACTION
E15..delH =E= 23500;
* RATE CONSTANT
E16..K =E= 0.002;
* EXIT CONCENTRATION OF A
E17..Ca =E= 2.865;
* MAXIMUM REACTOR CAPACITY (BASIS OF 10000KG)
E18..X3+X4+X5+((1-X6)*X1)+((1-0.667*X6)*X2) =L= 10000;
* ENERGY BALANCE
E19..X7*C6*(Tout-Tin) =E= (X1*C1/M1+X2*C2/M2+X5*C5/M5)*Tin-(X3*C3/M3+X4*C4/M4+X5*C5/M5+0.1*X1*C1/M1+0.408*X2*C2/M2)*Tout+(-delH*K*Ca*((0.1*X1+0.48*X2+X3+X4+X5)/(1.1821)));
* ASPIRIN TARGET PRODUCTION
E20..X3 =G= 3526.4;
* SIMULTANEOUS ACETIC ACID PRODUCTION
E21..X4 =G= 1175.422;
* CONSIDERING THE KETENE REACTOR MECHANISM AND CONVERSION
E22..X2 =G= 2.86*X4;
* CONSIDERING PERFORMANCE EQUATION FOR THE REACTOR
E23..X1 =G= 2702.53;
E24..X6 =G= 0.88;
E25..X6 =L= 0.948;
* CONSIDERING STOICHIOMETRY PROPORTIONS
E26..X5 =E= 0.868*X1;
E27..X6*X1*0.1802-X3*0.1318 =E= 0;

* OBJECTIVE FUNCTION
E28.. OBJ =E= ((-X6*X1*a)+(c*X3)+((-0.01-0.6603*X6)*X2*b+(1.11*X4*d))+(-0.02*X5*e)-f*X7)/66.69;

* Initial Values
X1.L = 0;
X2.L = 0;
X3.L = 0;
X4.L = 0;
X5.L = 0;
X6.L = 0;
X7.L = 0;


MODEL BATCHREACT /ALL/;

SOLVE BATCHREACT USING NLP MAXIMISING OBJ;
* Use SNOPT solver to optimize
OPTION NLP = IPOPT;
