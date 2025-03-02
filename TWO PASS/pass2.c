#include<stdio.h>
#include<stdlib.h>
#include<string.h>

char* SearchSymbol(char symbol[])
{
    FILE *f=fopen("symtab.txt","r");
    static char addr[50]="\0";
    char symb[100],line [500];
    while(fscanf(f,"%s\t%s",symb,addr)!=NULL)
    {
        if(strcmp(symbol,symb)==0)
        {
            fclose(f);
            return addr;
        }
    }
    fclose(f);
    strcpy(addr,"0");
    return addr;
}

char* searchOp(char op[])
{
    FILE *f=fopen("optab.txt","r");
    static char opcode[50]="\0";
    char operat[100];
    char line[200];
    while(fscanf(f,"%s\t%s",operat,opcode)!=NULL)
    {
        if(strcmp(op,operat)==0)
        {
            fclose(f);
            return opcode;
        }
    }
    fclose(f);
    strcpy(opcode,"00");
    return opcode;
}

void main()
{
    FILE *f1,*f2,*f3,*f4,*f5,*f6;
    f1=fopen("intermediate.txt","r");
    f3=fopen("assmlist.txt","w");
    f4=fopen("objectcode.txt","w");
    f6=fopen("length.txt","r");

    int length,start,addr,text_length;
    char *locctr,*op;
    char object_line[200],l,n;
    char label[100],opcode[100],operand[100],address[100],pgm[50];
    char line[100],line2[100];

    fscanf(f1,"%s\t%s\t%s\t%s",address,label,opcode,operand);
    strcpy(pgm,label);
    start=strtol(operand,NULL,16);
    //fscanf(f6,"%s\t%s",l,n);
    length=strtol((fgets(line,sizeof(line),f6)),NULL,16);

    fprintf(f3,"\t%s\t%s\t%s\n",label,opcode,operand);
    fprintf(f4,"H%s00%X0000%X\n",pgm,start,length);

    fscanf(f1,"%s\t%s\t%s\t%s",address,label,opcode,operand);
    while(strcmp(opcode,"END")!=0)
    {
        text_length=strtol(address,NULL,16);
        if(strcmp(label,"*")==0)
        {
            locctr=SearchSymbol(operand);
            if(locctr==0)
            {
                printf("ERROR: UNDEFINED SYMBOL\n\n");
            }
            op=searchOp(opcode);
            char obj[100];
            strcat(op,locctr);
            strcpy(obj,op);
            fprintf(f3,"%s\t\t%s\t%s\t%s\n",address,opcode,operand,obj);
            strcat(object_line,obj);
        }
        else if(strcmp(opcode,"WORD")==0)
        {
            int len=strlen(operand);
            char const_length[100]="\0";
            for(int i=len;i<6;i++)
            {
                strcat(const_length,"0");
            }
            strcat(const_length,operand);
            fprintf(f3,"%s\t%s\t%s\t%s\t%s\n",address,label,opcode,operand,const_length);
            strcat(object_line,const_length);
        }
        else  
        {
            fprintf(f3,"%s\t%s\t%s\t%s\n",address,label,opcode,operand);
        }
        fscanf(f1,"%s\t%s\t%s\t%s",address,label,opcode,operand);
    }
    fprintf(f3,"\t\t%s\t%x\t\n",opcode,start);
    text_length=text_length-start;
    fprintf(f4,"T00%X0%X%s\n",start,text_length,object_line);
    fprintf(f4,"E00%X\n",start);
    fclose(f1);
    fclose(f3);
    fclose(f4);
    fclose(f6);
}