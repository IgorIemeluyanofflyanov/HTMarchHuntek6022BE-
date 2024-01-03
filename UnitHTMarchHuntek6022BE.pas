unit UnitHTMarchHuntek6022BE;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Samples.Spin, Vcl.Mask;

type
  TFormHTMarchHuntek6022BE = class(TForm)
    img1: TPaintBox;
    stat1: TStatusBar;
    pnl1: TPanel;
    chk1Active: TCheckBox;
    lstm_nCH1VoltDIV: TListBox;
    lstm_nTimeDIV: TListBox;
    grp1: TGroupBox;
    se1: TSpinEdit;
    grpTrigger: TGroupBox;
    rgSlope: TRadioGroup;
    rgSweep: TRadioGroup;
    lbledtLevel: TSpinEdit;
    rgSource: TRadioGroup;
    lbledtHTrigPos: TSpinEdit;
    chkShiftTrigger: TCheckBox;
    rgCH1: TRadioGroup;
    rgCH2: TRadioGroup;
    GroupBoxLevel: TGroupBox;
    grpHoriz: TGroupBox;
    procedure FormCreate(Sender: TObject);
    procedure chk1ActiveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormHTMarchHuntek6022BE: TFormHTMarchHuntek6022BE;

implementation

{$R *.DFM}

uses System.Diagnostics, math;

const
  your_dll_name = 'HTMarch.dll';

type
  TSmallIntaRRAY = array of SMALLINT;
  PSmallIntaRRAY = ^TSmallIntaRRAY;

  // dsoCalibrate                   @1   ; dsoCalibrate
  // dsoCloseFlashLight             @2   ; dsoCloseFlashLight
  // dsoGetCalLevel                 @3   ; dsoGetCalLevel
  // dsoGetPackageSize              @4   ; dsoGetPackageSize
  // dsoOpenDevice                  @5   ; dsoOpenDevice
  // dsoOpenFlashLight              @6   ; dsoOpenFlashLight
  // dsoReadHardData                @7   ; dsoReadHardData
  // dsoReadPackageData             @8   ; dsoReadPackageData
  // dsoSetCalLevel                 @9   ; dsoSetCalLevel
  // dsoSetSquareFreq               @10  ; dsoSetSquareFreq
  // dsoSetTimeDIV                  @11  ; dsoSetTimeDIV
  // dsoSetVoltDIV                  @12  ; dsoSetVoltDIV
  // dsoStartDeviceCollect          @13  ; dsoStartDeviceCollect

function dsoOpenDevice(DeviceIndex: Word): Shortint; stdcall;
  external your_dll_name delayed;
function dsoSetVoltDIV(DeviceIndex: Word; nCH: Integer; nVoltDIV: Integer)
  : Shortint; stdcall; external your_dll_name delayed;
function dsoSetTimeDIV(DeviceIndex: Word; nTimeDIV: Integer): Shortint; stdcall;
  external your_dll_name delayed;

function dsoReadHardData(DeviceIndex: Word; pCH1Data: PSmallIntaRRAY;
  pCH2Data: PSmallIntaRRAY; nReadLen: Cardinal; pCalLevel: PSmallIntaRRAY;
  nCH1VoltDIV: Integer; nCH2VoltDIV: Integer; nTrigSweep: SMALLINT;
  nTrigSrc: SMALLINT; nTrigLevel: SMALLINT; nSlope: SMALLINT; nTimeDIV: Integer;
  nHTrigPos: SMALLINT; nDisLen: Cardinal; nTrigPoint: PCardinal;
  nInsertMode: SMALLINT): Shortint; stdcall; external your_dll_name delayed;

function dsoGetCalLevel(DeviceIndex: Word; level: PSmallIntaRRAY;
  nLen: SMALLINT): Word; stdcall; external your_dll_name delayed;
function dsoCalibrate(nDeviceIndex: Word; nTimeDIV: Integer;
  nCH1VoltDIV: Integer; nCH2VoltDIV: Integer; var pCalLevel: SMALLINT)
  : Shortint; stdcall; external your_dll_name delayed;
function dsoSetCalLevel(DeviceIndex: Word; var level: SMALLINT; nLen: SMALLINT)
  : Word; stdcall; external your_dll_name delayed;

procedure TFormHTMarchHuntek6022BE.FormCreate(Sender: TObject);
begin
  lstm_nCH1VoltDIV.ItemIndex := 5;
  lstm_nTimeDIV.ItemIndex := 4;

end;

procedure TFormHTMarchHuntek6022BE.chk1ActiveClick(Sender: TObject);
begin

  // 0: 20mV/DIV
  // 1: 50mV/DIV
  // 2: 100mV/DIV
  // 3: 200mV/DIV
  // 4: 500mV/DIV
  // 5: 1V/DIV
  // 6: 2V/DIV
  // 7: 5V/DIV
  var
  slist := TStringList.Create;
  with lstm_nTimeDIV do
    slist.DelimitedText := Items[ItemIndex];
  var
  nTimeDIV := slist[0].ToInteger;
  slist.Free;

  // 0 ~ 10 : 48MSa/s
  // 11: 16MSa/s
  // 12: 8MSa/s
  // 13: 4MSa/s
  // 14 ~ 24: 1MSa/s
  // 25: 500KSa/s
  // 26: 200KSa/s
  // 27: 100KSa

  if dsoOpenDevice(0) <> 1 then
    exit;

  var
    m_nCalData: TSmallIntaRRAY;

  System.SetLength(m_nCalData, 32);

  // GetMem(m_nCalData, 32 * SizeOf(SMALLINT));
  var
  m_nDevIndex := 0;
  dsoGetCalLevel(m_nDevIndex, PSmallIntaRRAY(m_nCalData), 32);
  var
  m_nCH1VoltDIV := lstm_nCH1VoltDIV.ItemIndex;
  dsoSetVoltDIV(m_nDevIndex, 0, m_nCH1VoltDIV);
  var
  m_nCH2VoltDIV := lstm_nCH1VoltDIV.ItemIndex;
  dsoSetVoltDIV(m_nDevIndex, 1, m_nCH2VoltDIV);
  dsoSetTimeDIV(m_nDevIndex, nTimeDIV);

  var
  nReadLen := se1.Value * 1000;
  // No Effect from 1024 to 10240 - same result - 64 mSec

  var
    pCH1Data: TSmallIntaRRAY;
  var
    pCH2Data: TSmallIntaRRAY;
  System.SetLength(pCH1Data, nReadLen);
  System.SetLength(pCH2Data, nReadLen);

  var
  SW := TStopwatch.StartNew;

  while chk1Active.Checked do
  begin



    // 4. Function declaration:
    // HTMARCH_API short WIN_API dsoReadHardData(
    // unsigned short DeviceIndex,
    // short* pCH1Data,
    // short* pCH2Data,
    // unsigned long nReadLen,
    // short* pCalLevel,
    // int nCH1VoltDIV,
    // int nCH2VoltDIV,
    // short nTrigSweep,
    // short nTrigSrc,
    // short nTrigLevel,
    // short nSlope,
    // int nTimeDIV,
    // short nHTrigPos,
    // unsigned long nDisLen,
    // unsigned long * nTrigPoint,
    // short nInsertMode);

    // Return value: Reading data, return ¡°-1¡±for failure and non ¡°-1¡±for success.
    // Parameter:
    // unsigned short DeviceIndex: Device index value
    // short* pCH1Data: CH1 data storage buffer pointer
    // short* pCH2Data: CH2 data storage buffer pointer
    // unsigned long nReadLen: The length of reading data
    // short* pCalLevel: Proofreading level (reference function dsoGetCalLevel)
    // int nCH1VoltDIV: The voltage of CH1
    // int nCH2VoltDIV: The voltage of CH2
    // short nTrigSweep: SWP MODE-0: AUTO; 1: Normal; 2: Single
    var
    nTrigSweep := rgSweep.ItemIndex;
    // short nTrigSrc: Trigger source - 0: CH1; 1: CH2
    var
    nTrigSrc := rgSource.ItemIndex;
    // short nTrigLevel: Trigger level - 0 ~ 255
    var
    nTrigLevel := lbledtLevel.Value; // 64;
    // short nSlope: Trigger Slope - 0: Rise; 1: Fall
    var
    nSlope := rgSlope.ItemIndex;

    // int nTimeDIV: Sampling rate

    var
    nHTrigPos :=lbledtHTrigPos.Value; // 50;
    // short nHTrigPos: Horizontal trigger position -0 ~ 100

    // unsigned long nDisLen: The length of the display data
    var
    nDisLen := img1.Width;

    var
      nTrigPoint: Cardinal := 0;
      // unsigned long * nTrigPoint: The index value of returned trigger point

    var
    nInsertMode :=0; // No effect ????
    // short nInsertMode: D-value mode - 0: Step D-value; 1: Line D-value; 2: SinX/X D-value

    SW.Reset;
    SW.Start;

    var
    nRe := dsoReadHardData(m_nDevIndex, PSmallIntaRRAY(pCH1Data),
      PSmallIntaRRAY(pCH2Data), nReadLen, PSmallIntaRRAY(m_nCalData),
      m_nCH1VoltDIV, m_nCH2VoltDIV, nTrigSweep, nTrigSrc, nTrigLevel, nSlope,
      nTimeDIV, nHTrigPos,
      nDisLen, // No effect
      @nTrigPoint, nInsertMode);

    SW.Stop;
    stat1.Panels[0].Text := SW.Elapsed.TotalMilliseconds.ToString;


    SW.Reset;
    SW.Start;

    var
    xScale := nReadLen div nDisLen;
    with img1 do
    begin

      Canvas.FillRect(Canvas.ClipRect);

      Canvas.Pen.Color := clRed;
      if nRe <> 1 then
        Canvas.Pen.Color := clGreen;

      Canvas.MoveTo(0, 100);

      var xShift := Math.ifthen( chkShiftTrigger.checked, nTrigPoint , 0);


      for var I := 0 to Pred(nDisLen) do
      begin
        var x :=i;
       var i1 := min( I * xScale + xShift, nReadLen-1) ;

       if rgCH2.ItemIndex=1 then
          x:= round(pCH2Data[i1] * nDisLen / 50);

          var y:= 100 + pCH1Data[i1];
        if i=0 then Canvas.MoveTo(x, y) else Canvas.LineTo(x, y);
      end;

      Canvas.Pen.Color := clBlue;

      if nRe <> 1 then
        Canvas.Pen.Color := clGreen;


      for var I := 0 to Pred(nDisLen) do
      begin
       var x :=i;
       var i1 := min( I * xScale + xShift, nReadLen-1) ;
        if rgCH1.ItemIndex=1 then
          x:= round(pCH1Data[i1] * nDisLen / 50);
        var y := 200 + pCH2Data[i1];

        if i=0 then Canvas.MoveTo(x, y) else Canvas.LineTo(x, y);
      end;

      Canvas.Rectangle(nTrigPoint div xScale, 0, nTrigPoint div xScale+1,Canvas.ClipRect.Height);

      Application.ProcessMessages;

    end;
    SW.Stop;
    stat1.Panels[1].Text := SW.Elapsed.TotalMilliseconds.ToString;

  end;

end;

procedure TFormHTMarchHuntek6022BE.FormClose(Sender: TObject; var Action:
    TCloseAction);
begin
chk1Active.Checked:= false;
end;

end.
