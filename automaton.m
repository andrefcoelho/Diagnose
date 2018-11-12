classdef automaton < matlab.mixin.Copyable%hgsetget
    properties
        name;
        states={};
        alphabet={};
        init_states={};
        marked_states={};
    end
%     methods(Access = protected)
%         function cpObj = copyElement(obj)
%             % Make a shallow copy of all four properties
%             cpObj = copyElement@matlab.mixin.Copyable(obj);
%             % Make a deep copy of the DeepCp object
%             cpObj.DeepObj = copy(obj.DeepObj);
%         end
%     end
    methods
        function obj = automaton(Name)
            obj.name = Name;
        end
        function addState(thisObject, varargin)
            if nargin>1
                st=state(varargin{1:nargin-1});
                thisObject.states{end+1}=st;
                if nargin>2
                    if varargin{2}==1
                        thisObject.marked_states{end+1}=st.name;
                    end
                    if nargin>3
                        if varargin{3}==1
                            thisObject.init_states{end+1}=st.name;
                        end
                        if nargin>5
                            trans=varargin{4};
                            for i=1:length(trans)
                                if not(ismember(trans(i),thisObject.alphabet))
                                    thisObject.alphabet{end+1}=char(trans(i));
                                end
                            end
                        end
                    end
                end
            end
            thisObject.states{end}.parent=thisObject;
        end
        function obj=getState(thisObject, var)
            if ischar(var)
                array_obj=thisObject.states;
                obj={};
                for i=1:length(array_obj)
                    o=array_obj{i};
                    if o.name==var
                        obj=thisObject.states{i};
                        break;
                    end
                end
            else
                obj=thisObject.states{var};
            end
        end
        function array_obj=getAllStates(thisObject)
            array_obj=thisObject.states;
        end
        function markState(thisObject, name,marked)
            st=thisObject.getState(name);
            if not(isempty(st))
                st.marked=marked;
                if marked
                    if not(ismember(name,thisObject.marked_states))
                        thisObject.marked_states{end+1}=name;
                    end
                else
                    thisObject.marked_states(strcmp(name,thisObject.marked_states))=[];
                end
            end
            
        end
        function initialState(thisObject, name,initial)
            st=thisObject.getState(name);
            if not(isempty(st))
                st.initial=initial;
                if initial
                    if not(ismember(name,thisObject.init_states))
                        thisObject.init_states{end+1}=name;
                    end
                else
                    thisObject.init_states(strcmp(name,thisObject.init_states))=[];
                end
            end
            
        end
    end
end
