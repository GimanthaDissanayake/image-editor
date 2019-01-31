function varargout = imageEditor(varargin)
% IMAGEEDITOR MATLAB code for imageEditor.fig
%      IMAGEEDITOR, by itself, creates a new IMAGEEDITOR or raises the existing
%      singleton*.
%
%      H = IMAGEEDITOR returns the handle to a new IMAGEEDITOR or the handle to
%      the existing singleton*.
%
%      IMAGEEDITOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGEEDITOR.M with the given input arguments.
%
%      IMAGEEDITOR('Property','Value',...) creates a new IMAGEEDITOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imageEditor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imageEditor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imageEditor

% Last Modified by GUIDE v2.5 16-Jan-2019 19:52:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageEditor_OpeningFcn, ...
                   'gui_OutputFcn',  @imageEditor_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before imageEditor is made visible.
function imageEditor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imageEditor (see VARARGIN)
global originalImage
originalImage=0;
% Choose default command line output for imageEditor
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imageEditor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = imageEditor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnLoadImage.
function btnLoadImage_Callback(hObject, eventdata, handles)
% hObject    handle to btnLoadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage
[FileName,PathName]=uigetfile ({'*.*'}, 'File Selector');
name=strcat(PathName,FileName);
originalImage=imread(name);
axes(handles.axes1);
imshow(originalImage);

info=imfinfo(name);
set(handles.lblSize, 'String', info.FileSize/1024);
set(handles.lblFormat, 'String', info.Format);
set(handles.lblWidth, 'String', info.Width);
set(handles.lblHeight, 'String', info.Height);
set(handles.lblBitDepth, 'String', info.BitDepth);
set(handles.lblColorType, 'String', info.ColorType);


% --- Executes on button press in btnSaveImage.
function btnSaveImage_Callback(hObject, eventdata, handles)
% hObject    handle to btnSaveImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cpyImage
[filename,pathname] = uiputfile({'*.jpg'},'File Path');
name=fullfile(pathname,filename);
imwrite(cpyImage,name);


% --- Executes on button press in rbGreenComponent.
function rbGreenComponent_Callback(hObject, eventdata, handles)
% hObject    handle to rbGreenComponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage cpyImage
cpyImage=originalImage;
allBlack = zeros(size(cpyImage, 1), size(cpyImage, 2), 'uint8');
axes(handles.axes2);
I=cat(3,allBlack,cpyImage(:,:,2),allBlack);
imshow(I);
cpyImage=I;
% Hint: get(hObject,'Value') returns toggle state of rbGreenComponent


% --- Executes on button press in rbThreshold.
function rbThreshold_Callback(hObject, eventdata, handles)
% hObject    handle to rbThreshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage cpyImage
level=graythresh(originalImage);
cpyImage = im2bw(originalImage,level);
axes(handles.axes2);
imshow(cpyImage);

axes(handles.axes3);
imhist(cpyImage);
% Hint: get(hObject,'Value') returns toggle state of rbThreshold


% --- Executes on button press in rbNoise.
function rbNoise_Callback(hObject, eventdata, handles)
% hObject    handle to rbNoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage cpyImage
cpyImage= imnoise(originalImage,'salt & pepper');
axes(handles.axes2);
imshow(cpyImage);
% Hint: get(hObject,'Value') returns toggle state of rbNoise


% --- Executes on button press in rbGrayscale.
function rbGrayscale_Callback(hObject, eventdata, handles)
% hObject    handle to rbGrayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage cpyImage
cpyImage=rgb2gray(originalImage);
axes(handles.axes2);
imshow(cpyImage);

axes(handles.axes3);
imhist(cpyImage);

% Hint: get(hObject,'Value') returns toggle state of rbGrayscale


% --- Executes on button press in rbBlacknWhite.
function rbBlacknWhite_Callback(hObject, eventdata, handles)
% hObject    handle to rbBlacknWhite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage cpyImage
cpyImage=im2bw(originalImage);
axes(handles.axes2);
imshow(cpyImage);

axes(handles.axes3);
imhist(cpyImage);
% Hint: get(hObject,'Value') returns toggle state of rbBlacknWhite


% --- Executes on button press in rbRedComp.
function rbRedComp_Callback(hObject, eventdata, handles)
% hObject    handle to rbRedComp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage cpyImage
cpyImage=originalImage;
allBlack = zeros(size(cpyImage, 1), size(cpyImage, 2), 'uint8');
I=cat(3,cpyImage(:,:,1),allBlack,allBlack);
axes(handles.axes2);
imshow(I);
cpyImage=I;
% Hint: get(hObject,'Value') returns toggle state of rbRedComp


% --- Executes on button press in tbBlueComponent.
function tbBlueComponent_Callback(hObject, eventdata, handles)
% hObject    handle to tbBlueComponent (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage cpyImage
cpyImage=originalImage;
allBlack = zeros(size(cpyImage, 1), size(cpyImage, 2), 'uint8');
axes(handles.axes2);
I=cat(3,allBlack,allBlack,cpyImage(:,:,1));
imshow(I);
cpyImage=I;
% Hint: get(hObject,'Value') returns toggle state of tbBlueComponent


% --- Executes on button press in btnSaveHistogram.
function btnSaveHistogram_Callback(hObject, eventdata, handles)
% hObject    handle to btnSaveHistogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F = getframe(handles.axes3);
Image = frame2im(F);
[filename,pathname] = uiputfile({'*.jpg'},'File Path');
name=fullfile(pathname,filename);
imwrite(Image,name);

% --- Executes on button press in rbResize.
function rbResize_Callback(hObject, eventdata, handles)
% hObject    handle to rbResize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage cpyImage
cpyImage = imresize(originalImage,0.5);
axes(handles.axes2);
imshow(cpyImage);
% Hint: get(hObject,'Value') returns toggle state of rbResize


% --- Executes on button press in rbCrop.
function rbCrop_Callback(hObject, eventdata, handles)
% hObject    handle to rbCrop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage cpyImage
figure
imshow(originalImage);
cpyImage=imcrop;
axes(handles.axes2);
imshow(cpyImage);
% Hint: get(hObject,'Value') returns toggle state of rbCrop


% --- Executes on button press in rbHFlip.
function rbHFlip_Callback(hObject, eventdata, handles)
% hObject    handle to rbHFlip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage cpyImage
cpyImage = flip(originalImage ,2);
axes(handles.axes2);
imshow(cpyImage);
% Hint: get(hObject,'Value') returns toggle state of rbHFlip


% --- Executes on button press in rbVFlip.
function rbVFlip_Callback(hObject, eventdata, handles)
% hObject    handle to rbVFlip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage cpyImage
cpyImage = flip(originalImage ,1);
axes(handles.axes2);
imshow(cpyImage);
% Hint: get(hObject,'Value') returns toggle state of rbVFlip
