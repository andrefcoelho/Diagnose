classdef automaton < matlab.mixin.Copyable %hgsetget
    properties
        name;
        states={};
        alphabet={};
        unobservable={};
        init_states={};
        marked_states={};
    end
    methods(Access = protected)
        % Override copyElement method:
        function cpObj = copyElement(obj)
            % Make a shallow copy of all four properties
            cpObj = copyElement@matlab.mixin.Copyable(obj);
            % Make a deep copy of the DeepCp object
            for i=1:length(obj.states);
                cpObj.states{i} = copy(obj.states{i});
            end
        end
    end
    methods
        function obj = automaton(Name)
            obj.name = Name;
        end
        function varargout=addState(thisObject, varargin)
            s_name=varargin{1};
            if ismember(s_name,thisObject.getStateNames)
                warning('State already exists')
                st=thisObject.getState(s_name);
            else
                if nargin>1
                    st=state(thisObject,varargin{1:nargin-1});
                end
            end
            if nargout>0
                varargout{1}=st;
            end
            
        end
        function varargout=getState(thisObject, var)
            %             varargout{1}=[];
            if ischar(var)
                array_obj=thisObject.states;
                varargout{1}={};
                for i=1:length(array_obj)
                    o=array_obj{i};
                    if strcmp(o.name,var)
                        varargout{1}=thisObject.states{i};
                        break;
                    end
                end
                if nargout>1
                    varargout{2}=i;
                end
            else
                varargout{1}=thisObject.states{var};
            end
        end
        function array_obj=getAllStates(thisObject)
            array_obj=thisObject.states;
        end
        function names=getStateNames(thisObject)
            if isempty(thisObject.states)
                names={};
            else
                for i=1:length(thisObject.states)
                    names{i}=thisObject.states{i}.name;
                end
            end
        end
        function markState(thisObject, name,marked)
            if isnumeric(name)
                st=thisObject.states{name};
                name=st.name;
            else
                st=thisObject.getState(name);
            end
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
        function removeStates(thisObject, names1)
            if ischar(names1)
                names{1}=names1;
            else
                names=names1;
            end
            n=[];
            for i=1:length(names)
                [x,ni]=thisObject.getState(char(names(i)));
                n=[n ni];
            end
            thisObject.states(n)=[];
            thisObject.init_states=setdiff(thisObject.init_states,names);
            thisObject.marked_states=setdiff(thisObject.marked_states,names);
                for i=1:length(thisObject.states)
                    next=thisObject.states{i}.next;
                    [thisObject.states{i}.transitions,i_tr]=setdiff(thisObject.states{i}.transitions,names);
                    thisObject.states{i}.next=next(i_tr);
                end
        end
        function G_inv=invert(thisObject)
            G_inv=copy(thisObject);
            G_inv.init_states=[];
            G_inv.marked_states=[];
            for i=1:length(G_inv.states)
                G_inv.states{i}.transitions=[];
                G_inv.states{i}.next=[];
                G_inv.markState(G_inv.states{i}.name,0);
                G_inv.initialState(G_inv.states{i}.name,0);
            end
            for i=1:length(thisObject.states)
                name_state=thisObject.states{i}.name;
                %mark initial states and make marked states initial
                if ismember(name_state,thisObject.init_states)
                    G_inv.markState(name_state,1)
                end
                if ismember(name_state,thisObject.marked_states)
                    G_inv.initialState(name_state,1)
                end
                trans=thisObject.states{i}.transitions;
                next=thisObject.states{i}.next;
                for j=1:length(trans)
                    state_inv=G_inv.getState(char(next(j)));
                    state_inv.addTransition(trans{j},name_state);
                end
            end
        end
    end
end
