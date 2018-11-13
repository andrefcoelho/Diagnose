classdef automaton < matlab.mixin.Copyable %hgsetget
    properties
        name;
        states={};
        alphabet={};
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
        function removeStates(thisObject, names1)
            if ischar(names1)==1
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
                thisObject.states{i}.transitions=setdiff(thisObject.states{i}.transitions,names);
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
