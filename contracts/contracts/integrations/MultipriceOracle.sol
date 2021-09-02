// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;

/// @title Multiprice oracle sourcing asset prices from multiple on-chain sources
contract MultipriceOracle {
    function assetToAsset(
        address _tokenIn,
        uint256 _amountIn,
        address _tokenOut,
        uint256 _clPriceBuffer,
        uint32 _uniswapV3TwapPeriod,
        uint8 _inclusionBitmap
    )
        external
        view
        returns (
            uint256 value,
            uint256 cl,
            uint256 clBuf,
            uint256 uniV3Twap,
            uint256 uniV3Spot,
            uint256 uniV2Spot,
            uint256 sushiSpot
        )
    {
        value = 1e18;
        cl = 1e18;
        clBuf = 0;
        uniV3Twap = 1e18;
        uniV3Spot = 1e18;
        uniV2Spot = 1e18;
        sushiSpot = 1e18;
    }

    /********************
     * Chainlink quotes *
     ********************/
    function chainLinkAssetToAsset(
        address _tokenIn,
        uint256 _amountIn,
        address _tokenOut
    ) public view returns (uint256 amountOut) {
        amountOut = 1e18;
    }

    /***********************************
     * UniswapV2/Sushiswap spot quotes *
     ***********************************/
    function uniV2SpotAssetToAsset(
        IUniswapV2Factory _factory,
        address _tokenIn,
        uint256 _amountIn,
        address _tokenOut
    ) public view returns (uint256 amountOut) {
        amountOut = 1e18;
    }
}
