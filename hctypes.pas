unit hctypes;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;
type
  //Used in mouse move event only
 hcMouseButton = (hMbLeft, hMbRight, hMbMiddle, hMbExtra1, hMbExtra2, hMbNone);

  hcBrushStype= (hcbsSolid,  hcbsClear, hcbsHorizontal,  hcbsVertical ,
  hcbsFDiagonal,  hcbsBDiagonal ,hcbsCross, DiagCross,  hcbsImage,
  hcbsPattern );

  TToolType = (
    TOOL_PEN,
    TOOL_MARQUEE,
    TOOL_ERASER,
    TOOL_LINE,
    TOOL_CONT_LINE,
    TOOL_CONT_LINE_STEP2,
    TOOL_RAYS,
    TOOL_CIRCLE,
    TOOL_ELLIPSE1,
    TOOL_ELLIPSE2,
    TOOL_RECTANGLE,
    TOOL_FILL,
    TOOL_SPRAY,
    TOOL_EYE_DROPPER,
    TOOL_TEXT,
    TOOL_ROUND_RECTANGLE,
    TOOL_TRIANGLE,
    TOOL_STAR,
    TOOL_BRUSH,
    TOOL_FREEFORM,
    TOOL_SELECT,
    TOOL_CURVE,
    TOOL_ZOOM,
    TOOL_MOVE,
    TOOL_SET_TRANSPARENT_COLOR,
    TOOL_GLOBAL_MAGIC_WAND,
    TOOL_LOCAL_MAGIC_WAND,
    TOOL_CANCEL
    );

implementation

end.

