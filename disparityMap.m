function varargout = disparityMap(varargin)
% DISPARITYMAP MATLAB code for disparityMap.fig
%      DISPARITYMAP, by itself, creates a new DISPARITYMAP or raises the existing
%      singleton*.
%
%      H = DISPARITYMAP returns the handle to a new DISPARITYMAP or the handle to
%      the existing singleton*.
%
%      DISPARITYMAP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DISPARITYMAP.M with the given input arguments.
%
%      DISPARITYMAP('Property','Value',...) creates a new DISPARITYMAP or raises
%      the existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before disparityMap_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to disparityMap_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help disparityMap

% Last Modified by GUIDE v2.5 11-Mar-2016 14:19:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @disparityMap_OpeningFcn, ...
    'gui_OutputFcn',  @disparityMap_OutputFcn, ...
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
end

% --- Executes just before disparityMap is made visible.
function disparityMap_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to disparityMap (see VARARGIN)

% Choose default command line output for disparityMap
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes disparityMap wait for user response (see UIRESUME)
% uiwait(handles.figure1);
end


% --- Outputs from this function are returned to the command line.
function varargout = disparityMap_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
    varargout{1} = handles.output;
end


% --- Executes on button press in leftImageBut.
function leftImageBut_Callback(hObject, eventdata, handles)
% hObject    handle to leftImageBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,FilePath ]= uigetfile('*.jpg','Select picture');
ExPath = fullfile(FilePath, FileName);
leftImage= imread(ExPath);
handles.leftImage=leftImage;
guidata(hObject, handles);
end


% --- Executes on button press in rightImageBut.
function rightImageBut_Callback(hObject, eventdata, handles)
% hObject    handle to rightImageBut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,FilePath ]= uigetfile('*.jpg','Select picture');
ExPath = fullfile(FilePath, FileName);
rightImage= imread(ExPath);
handles.rightImage=rightImage;
guidata(hObject, handles);
end


% --- Executes on selection change in similiarityMetric.
function similiarityMetric_Callback(hObject, eventdata, handles)
% hObject    handle to similiarityMetric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns similiarityMetric contents as cell array
%        contents{get(hObject,'Value')} returns selected item from similiarityMetric
end

% --- Executes during object creation, after setting all properties.
function similiarityMetric_CreateFcn(hObject, eventdata, handles)
% hObject    handle to similiarityMetric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on selection change in searchStrat.
function searchStrat_Callback(hObject, eventdata, handles)
% hObject    handle to searchStrat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns searchStrat contents as cell array
%        contents{get(hObject,'Value')} returns selected item from searchStrat
end

% --- Executes during object creation, after setting all properties.
function searchStrat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to searchStrat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on selection change in overallMethod.
function overallMethod_Callback(hObject, eventdata, handles)
% hObject    handle to overallMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns overallMethod contents as cell array
%        contents{get(hObject,'Value')} returns selected item from overallMethod
end

% --- Executes during object creation, after setting all properties.
function overallMethod_CreateFcn(hObject, eventdata, handles)
% hObject    handle to overallMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on selection change in featureChoice.
function featureChoice_Callback(hObject, eventdata, handles)
% hObject    handle to featureChoice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns featureChoice contents as cell array
%        contents{get(hObject,'Value')} returns selected item from featureChoice
end

% --- Executes during object creation, after setting all properties.
function featureChoice_CreateFcn(hObject, eventdata, handles)
% hObject    handle to featureChoice (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function supportWinSize_Callback(hObject, eventdata, handles)
% hObject    handle to supportWinSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of supportWinSize as text
%        str2double(get(hObject,'String')) returns contents of supportWinSize as a double
end

% --- Executes during object creation, after setting all properties.
function supportWinSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to supportWinSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function searchWinSize_Callback(hObject, eventdata, handles)
% hObject    handle to searchWinSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of searchWinSize as text
%        str2double(get(hObject,'String')) returns contents of searchWinSize as a double
end

% --- Executes during object creation, after setting all properties.
function searchWinSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to searchWinSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function imgSize_Callback(hObject, eventdata, handles)
% hObject    handle to imgSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of imgSize as text
%        str2double(get(hObject,'String')) returns contents of imgSize as a double
end

% --- Executes during object creation, after setting all properties.
function imgSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imgSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes on button press in execute.
function execute_Callback(hObject, eventdata, handles)
% hObject    handle to execute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    left = rgb2gray(handles.leftImage);
    right = rgb2gray(handles.rightImage);
    
    newSize =  str2num(get(handles.imgSize,'string'));
    
    [left, scale] = resizeToMaxDim(left, newSize);
    [right, scale] = resizeToMaxDim(right, newSize);
    
    mode = get(handles.overallMethod,'value');
    if mode == 1
        correlationWrapper(left, right, newSize, handles);
    elseif mode == 2
        featureWrapper(left, right, newSize, handles);
    end
    %figure, imshow(left);
    %figure, imshow(right);
    %size(left);
    %size(right);
    guidata(hObject, handles);
end

function [resizedImg, inverseScale] = resizeToMaxDim(image, newSize)
    [scale, inverseScale] = calculateScale(image, newSize);
    resizedImg = imresize(image, scale);    
end

function [scale, inverseScale] = calculateScale(image, newSize)
    [sizeY, sizeX, sizeZ] = size(image);
    if  sizeX >= sizeY
        scale = newSize/sizeX;
        inverseScale = sizeX/newSize;
    else
        scale = newSize/sizeY;
        inverseScale = sizeY/newSize;
    end
end

function [] = correlationWrapper(leftImg, rightImg, size, handles)
    supportWinSize = str2num(get(handles.supportWinSize,'string'));
    searchWinSize = str2num(get(handles.searchWinSize,'string'));
    simMetric = get(handles.similiarityMetric, 'Value');
    searchStrat = get(handles.searchStrat, 'Value');
    L = leftImg;
    R = rightImg;
end

function [] = featureWrapper(leftImg, rightImg, size, handles)
    featureChoice = get(handles.featureChoice, 'Value');
    L = leftImg;
    R = rightImg;
end



function baseline_Callback(hObject, eventdata, handles)
% hObject    handle to baseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of baseline as text
%        str2double(get(hObject,'String')) returns contents of baseline as a double
end

% --- Executes during object creation, after setting all properties.
function baseline_CreateFcn(hObject, eventdata, handles)
% hObject    handle to baseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


function focalLength_Callback(hObject, eventdata, handles)
% hObject    handle to focalLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of focalLength as text
%        str2double(get(hObject,'String')) returns contents of focalLength as a double
end

% --- Executes during object creation, after setting all properties.
function focalLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to focalLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


function dpi_Callback(hObject, eventdata, handles)
% hObject    handle to dpi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dpi as text
%        str2double(get(hObject,'String')) returns contents of dpi as a double
end

% --- Executes during object creation, after setting all properties.
function dpi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dpi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end
end


function minDist_Callback(hObject, eventdata, handles)
% hObject    handle to minDist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minDist as text
%        str2double(get(hObject,'String')) returns contents of minDist as a double
end

% --- Executes during object creation, after setting all properties.
function minDist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minDist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in calculateWinSize.
function calculateWinSize_Callback(hObject, eventdata, handles)
% hObject    handle to calculateWinSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    baseline = str2num(get(handles.baseline,'string'));
    focalLength = str2num(get(handles.focalLength,'string'));
    dpi = str2num(get(handles.dpi,'string'));
    minDist = str2num(get(handles.minDist,'string'));
    newSize =  str2num(get(handles.imgSize,'string'));
    [scale, inverseScale] = calculateScale(handles.leftImage, newSize);
    error = mmToPixels(5, dpi);
    suggestedSize = windowSizeCalc(baseline, focalLength, minDist, dpi, inverseScale) + error;
    set(handles.suggestedSearchWin, 'String', num2str(suggestedSize));
    guidata(hObject, handles);
end
