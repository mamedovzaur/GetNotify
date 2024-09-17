unit Unit52;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, StdCtrls;

type
  TForm52 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    IdHTTP1: TIdHTTP;
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    status,notifynum,notifyurl:string;
  end;

var
  Form52: TForm52;

implementation

{$R *.dfm}

function PostExample: string;
var
  lHTTP: TIdHTTP;
  lParamList: TStringList;
begin
  lParamList := TStringList.Create;
  lParamList.Add('login=m.zaur');
  lParamList.Add('password=m.zaur');

  lHTTP := TIdHTTP.Create;
  try
    Result := lHTTP.Post('http://172.16.125.33/proID/api/notification/getNotifications.php', lParamList);
  finally
    lHTTP.Free;
    lParamList.Free;
  end;
end;


function Split(const StringParam: String; const DelimChar: String): Variant;

var
  sTMP  : string;
  sa      : array of string;
  n,i,y   : Integer;

begin
  try
      sTMP:=StringParam;
      n:=Pos(DelimChar, sTMP)-1;
      i:=0;
      y:=Length(DelimChar);

    while n>0 do begin
      i:=i+1;
      SetLength(sa,i);
      sa[i-1]:=Copy(sTMP,1,n);

      Delete(sTMP,1,n+y);

      n:=Pos(DelimChar, sTMP)-1;
    end;
      i:=i+1;
      n:=Length(sTMP);
      SetLength(sa,i);
      sa[i-1]:=Copy(sTMP,1,n);
      Result:=sa;
  finally
      sTMP:='';
      sa:=nil;
  end;
end;

procedure GetNotify();
var
S:String;
s1: array of string;

begin
S:=PostExample();
S:=StringReplace(S,'{','',[rfReplaceAll]);
S:=StringReplace(S,'}','',[rfReplaceAll]);
S:=StringReplace(S,'"','',[rfReplaceAll]);

s1:=Split(S,',');

form52.status:=StringReplace(s1[0],'status:','',[rfReplaceAll]);
form52.notifynum:=StringReplace(s1[1],'unreadNotifNum:','',[rfReplaceAll]);
form52.notifyurl:=StringReplace(s1[2],'lastNotifURL:','',[rfReplaceAll]);
end;


procedure TForm52.Button1Click(Sender: TObject);
begin
GetNotify();
Memo1.Lines.Add('state='+status);
Memo1.Lines.Add('notifynum='+notifynum);
Memo1.Lines.Add('notifyurl='+notifyurl);
end;

end.
