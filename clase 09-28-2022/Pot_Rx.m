function  [Prx] = Pot_Rx(Ptx, Gtx, Grx, Acctx, Accrx, f, L)
    %PathLoss - Description
    %
    % Syntax:  [] = PathLoss(input)
    %
    % Long description
    for i=1: length(f)
        Prx(i,:) = Ptx + Gtx + Grx - Acctx - Accrx - L(i,:);
    end

end