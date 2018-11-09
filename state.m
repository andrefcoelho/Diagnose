classdef state < handle
    properties
        name
        marked=0;
        initial=0;
        parent={};
        transitions={};
        next={};
    end
    methods
        function obj = state(varargin)
            if nargin>0
                obj.name = varargin{1};
                if nargin>1
                    obj.marked = varargin{2};
                    if nargin>2
                        obj.initial = varargin{3};
                        if nargin>4
                            obj.transitions = varargin{4};
                            obj.next = varargin{5};
                        end
                    end
                end
            end
            
        end
        function addTransition(thisObject,trans,next_state)
            thisObject.transitions{end+1} = trans;
            thisObject.next{end+1} = next_state;
            
        end
    end
end