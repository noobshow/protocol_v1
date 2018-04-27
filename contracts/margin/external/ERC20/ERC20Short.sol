pragma solidity 0.4.23;
pragma experimental "v0.5.0";

import { DetailedERC20 } from "zeppelin-solidity/contracts/token/ERC20/DetailedERC20.sol";
import { ERC20Position } from "./ERC20Position.sol";
import { Margin } from "../../Margin.sol";


/**
 * @title ERC20Short
 * @author dYdX
 *
 * Contract used to tokenize short positions and allow them to be used as ERC20-compliant
 * tokens. Holding the tokens allows the holder to close a piece of the short position, or be
 * entitled to some amount of heldTokens after settlement.
 */
contract ERC20Short is ERC20Position {
    constructor(
        bytes32 positionId,
        address margin,
        address initialTokenHolder,
        address[] trustedRecipients
    )
        public
        ERC20Position(
            positionId,
            margin,
            initialTokenHolder,
            trustedRecipients,
            "d/S"
        )
    {}

    // ============ Public Constant Functions ============

    function decimals()
        external
        view
        returns (uint8)
    {
        return
            DetailedERC20(
                Margin(DYDX_MARGIN).getPositionOwedToken(POSITION_ID)
            ).decimals();
    }

    // ============ Internal Functions ============

    function getAddedTokenAmount(
        bytes32 /* positionId */,
        uint256 principalAdded
    )
        internal
        view
        returns (uint256)
    {
        return principalAdded;
    }

    function getNameIntro()
        internal
        pure
        returns (bytes)
    {
        return "dYdX Short Token";
    }
}