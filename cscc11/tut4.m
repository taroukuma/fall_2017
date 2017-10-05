warning('off');

% Gradient descent test - First, we will set up an array with inputs and outputs.
% The array will have 5 columns - these will correspond to:
% x_1   x_2   x_3   bias   y
%
% That is, we can have up to 3 input variables, the bias term, and the corresponding
% output. Below I will set up values only for x_1, but you will try this later with
% multiple variables by filling in values for x_2 and x_3.

w2=[.345 .12]';				% x_1 comes from a linear function y=.345x + .12
inp=[0:.05:1]';				% And I will define it in the interval [0 1]
Ex=zeros(size(inp,1),5);
Ex(:,1)=inp;	
Ex(:,2)=ones(size(inp,1),1);		% x_2 and x_3 will be set to 1 for now, change later
Ex(:,3)=ones(size(inp,1),1);		% to try multi-input regression
Ex(:,4)=ones(size(inp,1),1);		% bias term is one for every input row
Ex(:,5)=Ex(:,[1 4])*w2;			% Finally, output, y = .345*x_1 + .12
Ex(:,5)=Ex(:,5)+((rand(size(inp,1),1)-.5)*.1);	% Add some noise to the output. Change
							% the scale to add more or less noise.

							
inIdx=[1]; 	% Indices of input columns to use (choose from 1, 2, 3), in this case the
		% code will use the first column as input. Later on, when you add data to the
		% columns for x_2 and x_3, you can make inIdx=[1 2 3] to have the code use
		% all input columns, or use inIdx=[1 3], for example, to use columns 1 and
		% 3. Do not forget to re-define the output in terms of *all* the available
		% input variables!

inIdx=[inIdx 4];		% Add the column for the bias term to the inputs
inputD=size(inIdx,2);		

% Compute the optimal Least-Squares parameters as we have seen before, for comparison with
% the results we will obtain with gradient descent. Also, evaluate the squared error for the
% input dataset given the optimal parameters. This is the smallest squared error possible
% on this dataset.
w=Ex(:,inIdx)\Ex(:,5);
opterr=sum(((Ex(:,5)-(Ex(:,inIdx)*w))).^2);


% The code below will create a plot to visualize the values of E(w) for the case of one
% input vadiable. The points showing the estimates computed iteratively by gradient
% descent will be shown over this surface as green dots. The point corresponding to the
% optimal least-squared parameters computer just above will be shown in yellow.
% You will need to rotate this plot around to see the shape of the quadratic bowl and
% get a good sense of what's going on during the gradient descent iteration.
if (length(inIdx)==2)
 figure(2);clf;hold on;
 [ww1,ww2]=meshgrid([0:.01:1],[0:.01:1]);
 errS=zeros(size(ww1));
 for i=1:size(ww1,1)
  for j=1:size(ww1,2)
    wt=[ww1(i,j);ww2(i,j)];
    predict=Ex(:,inIdx)*wt;
    rrr=sum((predict-Ex(:,5)).^2);
    errS(i,j)=rrr;    
  end;
 end;
 surf(ww1,ww2,errS); 
 shading interp;
 contour3(ww1,ww2,errS,'linewidth',1.5,'LineColor',[0 0 0]);
 colormap(jet);
 title('Total squared error as a function of w_1 and w_2');
 xlabel('w_1');
 ylabel('w_2');
 zlabel('E(w)');
end;

% Gradient descent procedure. First, generate a random initial guess for the model
% parameters and set up the step size for the gradient descent iteration.
w_gd=rand(inputD,1);		% Random starting point
alpha=.001;			% Step size
it=0;				% Iteration counter

% Gradient descent loop - for each parameter, compute an update as given in the
% notes.
while (1) 

 it=it+1;
 predict=Ex(:,inIdx)*w_gd;		% Output prediction from current model parameters
 w_new=w_gd;				% Copy current parameters for update

 % Loop over input parameters
 for i=1:inputD
  w_new(i)=w_new(i) + (alpha*  sum((Ex(:,5)-predict).*Ex(:,inIdx(i))));	% GD update
 end;

 % Check for convergence
 if (sqrt(sum((w_new-w_gd).^2))<1e-9|it>100000) break; end;

 % Update GD parameters with the new estimate
 w_gd=w_new;
 
 % Compute squared error for this iteration so we can plot it and also print its value
 rrr=sum((predict-Ex(:,5)).^2);

 plt=0;
 if (it>=10&mod(it,10^floor(log10(it)))==0) fprintf(2,'Iteration %d, squared error=%f\n',it,rrr); plt=1; end;

 % Plot current error on the error surface
 if (length(inIdx)==2&plt)
  plot3(w_gd(1),w_gd(2),rrr,'g.','markersize',14);
 end;
 
end;

if (inputD==2)
 plot3(w(1),w(2),opterr,'y.','markersize',16);
end;

% Output the final parameters obtained by the GD iteration
fprintf(2,'Final weights=%f\n',w_gd);
fprintf(2,'Squared error=%f\n\n',rrr);

% And compare with the optimal weights from the closed-form solution
fprintf(2,'Optimal LS weights=%f\n',w);
fprintf(2,'Squared error=%f\n',opterr);

% Plot the input data, the optimal model computed by the closed form LS equation, and the model
% obtained from the GD procedure.
if (inputD==2)
 figure(1);clf;
 plot(Ex(:,inIdx(1)),Ex(:,5),'b.'); hold on;
 plot(Ex(:,inIdx(1)),predict,'r-','linewidth',1.5);
 plot(Ex(:,inIdx(1)),Ex(:,inIdx)*w,'g-','linewidth',1.5);
 title('Input data and model fits. Optimal (green), GD (red)');
end;
