"""
Lazy Loading Dataflow

## Lazy Loading Pipe Query System:
# VerticesVerticesPipe
Start with Vertices (1 or more) to get all the other Vertices connected to it.

"""
from ozpcenter.recommend import recommend_utils


class Pipeline(object):
    """
    A Pipeline is a linear composite of Pipes.
    """

    def __init__(self, starts=None, pipes=None):
        """
        Initialize Pipeline
        """
        self.pipes = pipes or []

        self.starts = False

        if starts:
            self.starts = True
            self.pipes.insert(0, starts)

        self.as_map = {}

        self.start_pipe = None
        self.end_pipe = None

        if self.pipes:
            self.set_pipes()

    def set_starts(self, starts):
        """
        Set Start

        Args:
            Iterator of objects
        """
        self.starts = True
        self.pipes.insert(0, starts)

        if self.pipes:
            self.set_pipes()

    def get_starts(self):
        """
        Get start iterable
        """
        return self.start_pipe

    def set_pipes(self):
        """
        constructing the pipeline chain
        """
        pipeline_size = len(self.pipes)
        self.start_pipe = self.pipes[0]
        self.end_pipe = self.pipes[-1]

        for i in list(range(1, pipeline_size)):
            self.pipes[i].set_starts(self.pipes[i - 1])

    def refresh_as_pipes(self):
        """
        As Pipes
        """
        for pipe in self.pipes:
            current_type_str = str(pipe.__class__)
            if current_type_str == 'AsPipe':
                self.as_map[pipe.get_name()] = pipe

    def get_pipes(self):
        """
        Get Pipes
        """
        return self.pipes

    def add_pipe(self, iterable):
        """
        Add Pipe
        """
        self.pipes.append(iterable)
        self.set_pipes()

    def remove(self):
        """
        Remove Pipe
        """
        raise recommend_utils.UnsupportedOperationException()

    def has_next(self):
        """
        Determines if there is another object that can be emitted
        """
        return self.end_pipe.has_next()

    def next(self):
        """
        Get the next objected emitted

        Return:
            Object
        """
        return self.end_pipe.next()

    def iterate(self):
        """
        This will iterate all the objects out of the pipeline.
        """
        # if self.starts is None:
        #     raise Exception('No Start Iterator set')

        if not self.pipes:
            raise Exception('No Start Iterator set')

        try:
            while True:
                self.next()
        except recommend_utils.FastNoSuchElementException:
            # Ignore FastNoSuchElementException
            pass

    def to_list(self):
        """
        Drains the pipeline into a list
        """
        # if self.starts is None:
        #     raise Exception('No Start Iterator set')
        if not self.pipes:
            raise Exception('No Start Iterator set')

        output = []
        try:
            while True:
                output.append(self.next())
        except recommend_utils.FastNoSuchElementException:
            # Ignore FastNoSuchElementException
            pass
        return output

    def count(self):
        """
        Count the number of objects in an pipeline
        """
        # if self.starts is None:
        #     raise Exception('No Start Iterator set')

        if not self.pipes:
            raise Exception('No Start Iterator set')

        count = 0
        try:
            while True:
                self.next()
                count = count + 1
        except recommend_utils.FastNoSuchElementException:
            # Ignore FastNoSuchElementException
            pass
        return count

    def size(self):
        """
        Number of pipes in the pipeline
        """
        return len(self.pipes)

    def __str__(self):
        """
        Pipeline String
        """
        return '[{}]'.format(', '.join([str(pipe) for pipe in self.pipes]))
