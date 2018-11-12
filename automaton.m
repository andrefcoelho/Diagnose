classdef automaton < hgsetget
    properties
        name;
        states={};
        alphabet={};
    end
    methods
        function obj = automaton(Name)
            obj.name = Name;
        end
        function addState(thisObject, varargin)
            if nargin>1
                thisObject.states{end+1}=state(varargin{1:nargin-1});
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
    end
end
