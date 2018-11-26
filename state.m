classdef state < matlab.mixin.Copyable %handle
    properties
        name
        marked=0;
        initial=0;
        parent={};
        transitions={};
        next={};
        predecessor;
        color;
        d;
        f;
    end
    methods
        function obj = state(parent,varargin)
            obj.parent=parent;
            if nargin>1
                obj.name = varargin{1};
                parent.states{end+1}=obj;
                if nargin>2
                    obj.marked = varargin{2};
                    if varargin{2}==1
                        parent.marked_states{end+1}=obj.name;
                    end
                    if nargin>3
                        obj.initial = varargin{3};
                        if varargin{3}==1
                            parent.init_states{end+1}=obj.name;
                        end
                        if nargin>5
                            if nargin>6
                                obj.addTransition(varargin{4},varargin{5},varargin{6});
                            else
                                obj.addTransition(varargin{4},varargin{5});
                            end
                        end
                    end
                end
            end
        end
        function addTransition(thisObject,varargin)
            if ischar(varargin{1})
                trans={};
                trans{1}=varargin{1};
            else
                trans=varargin{1};
            end
            if ischar(varargin{2})
                next_state={};
                next_state{1}=varargin{2};
            else
                next_state=varargin{2};
            end
            if nargin>3
                if ischar(varargin{2})
                    obsv={};
                    obsv{1}=varargin{3};
                else
                    obsv=varargin{3};
                end
            end
            assert(length(trans)==length(next_state));
            for i=1:length(trans)
                thisObject.transitions{end+1} = char(trans(i));
                thisObject.next{end+1} = char(next_state(i));
                if not(ismember(trans(i),thisObject.parent.alphabet))
                    thisObject.parent.alphabet{end+1}=char(trans(i));
                end
                if nargin>3
                    if not(obsv(i))
                        if not(ismember(trans(i),thisObject.parent.unobservable))
                            thisObject.parent.unobservable{end+1}=char(trans(i));
                        end
                    end
                end
            end
        end        
    end
end