module VegaLite exposing
    ( toVegaLite
    , VLProperty
    , Spec
    , LabelledSpec
    , combineSpecs
    , dataFromUrl
    , dataFromColumns
    , dataColumn
    , dataFromRows
    , dataRow
    , dataFromJson
    , jsonToSpec
    , dataFromSource
    , dataName
    , datasets
    , noData
    , Data
    , DataColumn
    , DataRow
    , geometry
    , geoFeatureCollection
    , geometryCollection
    , geoPoint
    , geoPoints
    , geoLine
    , geoLines
    , geoPolygon
    , geoPolygons
    , dataSequence
    , dataSequenceAs
    , sphere
    , graticule
    , grStep
    , grStepMajor
    , grStepMinor
    , grExtent
    , grExtentMajor
    , grExtentMinor
    , grPrecision
    , csv
    , tsv
    , dsv
    , arrow
    , jsonProperty
    , topojsonFeature
    , topojsonMesh
    , parse
    , foNum
    , foBoo
    , foDate
    , foUtc
    , transform
    , projection
    , prNumExpr
    , prType
    , prExpr
    , prClipAngle
    , prClipExtent
    , prCenter
    , prCenterExpr
    , prScale
    , prTranslate
    , prTranslateExpr
    , prRotate
    , prRotateExpr
    , prPrecision
    , prCoefficient
    , prDistance
    , prFraction
    , prLobes
    , prParallel
    , prParallels
    , prParallelsExpr
    , prPointRadius
    , prRadius
    , prRatio
    , prReflectX
    , prReflectY
    , prSpacing
    , prTilt
    , albers
    , albersUsa
    , azimuthalEqualArea
    , azimuthalEquidistant
    , conicConformal
    , conicEqualArea
    , conicEquidistant
    , equalEarth
    , equirectangular
    , gnomonic
    , identityProjection
    , mercator
    , naturalEarth1
    , orthographic
    , stereographic
    , transverseMercator
    , customProjection
    , noClip
    , clipRect
    , clipRectExpr
    , aggregate
    , joinAggregate
    , opAs
    , timeUnitAs
    , opArgMax
    , opArgMin
    , opCI0
    , opCI1
    , opCount
    , opDistinct
    , opMax
    , opMean
    , opMedian
    , opMin
    , opMissing
    , opProduct
    , opQ1
    , opQ3
    , opStderr
    , opStdev
    , opStdevP
    , opSum
    , opValid
    , opVariance
    , opVarianceP
    , binAs
    , biAnchor
    , biBase
    , biDivide
    , biExtent
    , biSelectionExtent
    , biMaxBins
    , biMinStep
    , biNice
    , biStep
    , biSteps
    , stack
    , stOffset
    , stNormalize
    , stCenter
    , stZero
    , stNone
    , stSort
    , stAscending
    , stDescending
    , calculateAs
    , filter
    , fiEqual
    , fiLessThan
    , fiLessThanEq
    , fiGreaterThan
    , fiGreaterThanEq
    , fiExpr
    , fiSelection
    , fiSelectionEmpty
    , fiOp
    , fiOpTrans
    , fiCompose
    , fiOneOf
    , fiRange
    , fiValid
    , numRange
    , dtRange
    , flatten
    , flattenAs
    , fold
    , foldAs
    , pivot
    , piGroupBy
    , piLimit
    , piOp
    , lookup
    , lookupSelection
    , luFields
    , luFieldsWithDefault
    , luFieldsAs
    , luFieldsAsWithDefault
    , luAs
    , luAsWithDefault
    , impute
    , imFrame
    , imKeyVals
    , imKeyValSequence
    , imMethod
    , imGroupBy
    , imNewValue
    , imValue
    , imMean
    , imMedian
    , imMax
    , imMin
    , sample
    , density
    , dnGroupBy
    , dnCumulative
    , dnCounts
    , dnBandwidth
    , dnExtent
    , dnMinSteps
    , dnMaxSteps
    , dnSteps
    , dnAs
    , loess
    , lsGroupBy
    , lsBandwidth
    , lsAs
    , regression
    , rgGroupBy
    , rgMethod
    , rgOrder
    , rgExtent
    , rgParams
    , rgAs
    , rgLinear
    , rgLog
    , rgExp
    , rgPow
    , rgQuad
    , rgPoly
    , quantile
    , qtGroupBy
    , qtProbs
    , qtStep
    , qtAs
    , window
    , wiAggregateOp
    , wiOp
    , wiParam
    , wiField
    , woRowNumber
    , woRank
    , woDenseRank
    , woPercentRank
    , woCumeDist
    , woPercentile
    , woLag
    , woLead
    , woFirstValue
    , woLastValue
    , woNthValue
    , wiFrame
    , wiIgnorePeers
    , wiGroupBy
    , wiSort
    , wiAscending
    , wiDescending
    , arc
    , area
    , bar
    , boxplot
    , errorband
    , errorbar
    , circle
    , geoshape
    , image
    , line
    , point
    , rect
    , rule
    , square
    , textMark
    , tick
    , trail
    , maBooExpr
    , maNumExpr
    , maStrExpr
    , maAlign
    , maAngle
    , maAria
    , maBandSize
    , maBaseline
    , maBinSpacing
    , maBlend
    , maBorders
    , maBox
    , maClip
    , maRemoveInvalid
    , maColor
    , maColorGradient
    , maCornerRadius
    , maCornerRadiusEnd
    , maCornerRadiusTopLeft
    , maCornerRadiusTopRight
    , maCornerRadiusBottomLeft
    , maCornerRadiusBottomRight
    , maCursor
    , maExtent
    , maHRef
    , maContinuousBandSize
    , maDiscreteBandSize
    , maLimit
    , maDir
    , maEllipsis
    , maDx
    , maDy
    , maInnerRadius
    , maOuterRadius
    , maPadAngle
    , maFill
    , maFillGradient
    , maFilled
    , maFillOpacity
    , maFont
    , maFontSize
    , maFontStyle
    , maFontWeight
    , maInterpolate
    , maOpacity
    , maOrder
    , maOrient
    , maPoint
    , maLine
    , maMedian
    , maOutliers
    , maRadius
    , maRule
    , maShape
    , maShortTimeLabels
    , maSize
    , maStroke
    , maStrokeGradient
    , maStrokeCap
    , caRound
    , caSquare
    , caButt
    , caExpr
    , maStrokeDash
    , maStrokeDashExpr
    , maStrokeDashOffset
    , maStrokeJoin
    , joRound
    , joBevel
    , joMiter
    , joExpr
    , maStrokeMiterLimit
    , maStrokeOpacity
    , maStrokeWidth
    , maStyle
    , maTension
    , maText
    , maLineHeight
    , maTheta
    , maTheta2
    , maThickness
    , maTicks
    , maTooltip
    , maWidth
    , maHeight
    , maX
    , maY
    , maXOffset
    , maYOffset
    , maThetaOffset
    , maTheta2Offset
    , maX2
    , maY2
    , maX2Offset
    , maY2Offset
    , maRadiusOffset
    , maRadius2Offset
    , maAspect
    , grLinear
    , grRadial
    , grX1
    , grX2
    , grY1
    , grY2
    , grR1
    , grR2
    , grStops
    , arEnable
    , arDisable
    , arDescription
    , arExpr
    , moHorizontal
    , moVertical
    , miBasis
    , miBasisOpen
    , miBasisClosed
    , miBundle
    , miCardinal
    , miCardinalOpen
    , miCardinalClosed
    , miLinear
    , miLinearClosed
    , miMonotone
    , miStepwise
    , miStepAfter
    , miStepBefore
    , miExpr
    , tdLeftToRight
    , tdRightToLeft
    , tdExpr
    , symCircle
    , symCross
    , symDiamond
    , symSquare
    , symTriangleUp
    , symTriangleDown
    , symTriangleLeft
    , symTriangleRight
    , symPath
    , symStroke
    , symArrow
    , symWedge
    , symTriangle
    , symExpr
    , pmNone
    , pmTransparent
    , pmMarker
    , lmMarker
    , lmNone
    , exRange
    , exCi
    , exIqr
    , exIqrScale
    , exStderr
    , exStdev
    , ttData
    , ttEncoding
    , ttNone
    , bmNormal
    , bmMultiply
    , bmScreen
    , bmOverlay
    , bmDarken
    , bmLighten
    , bmColorDodge
    , bmColorBurn
    , bmHardLight
    , bmSoftLight
    , bmDifference
    , bmExclusion
    , bmHue
    , bmSaturation
    , bmColor
    , bmLuminosity
    , bmExpr
    , cuAuto
    , cuDefault
    , cuNone
    , cuContextMenu
    , cuHelp
    , cuPointer
    , cuProgress
    , cuWait
    , cuCell
    , cuCrosshair
    , cuText
    , cuVerticalText
    , cuAlias
    , cuCopy
    , cuMove
    , cuNoDrop
    , cuNotAllowed
    , cuAllScroll
    , cuColResize
    , cuRowResize
    , cuNResize
    , cuEResize
    , cuSResize
    , cuWResize
    , cuNEResize
    , cuNWResize
    , cuSEResize
    , cuSWResize
    , cuEWResize
    , cuNSResize
    , cuNESWResize
    , cuNWSEResize
    , cuZoomIn
    , cuZoomOut
    , cuGrab
    , cuGrabbing
    , cuExpr
    , encoding
    , Measurement(..)
    , position
    , Position(..)
    , pName
    , pDatum
    , pRepeat
    , pNominal
    , pOrdinal
    , pQuant
    , pTemporal
    , pGeo
    , pMType
    , pBin
    , pBinned
    , pTimeUnit
    , pTitle
    , pAggregate
    , pScale
    , pAxis
    , pSort
    , pBandPosition
    , pStack
    , pWidth
    , pHeight
    , pNum
    , pImpute
    , soAscending
    , soDescending
    , soByField
    , soByChannel
    , soByRepeat
    , soCustom
    , axBooExpr
    , axNumExpr
    , axNumsExpr
    , axStrExpr
    , axAria
    , axBandPosition
    , axMaxExtent
    , axMinExtent
    , axOrient
    , axOffset
    , axPosition
    , axZIndex
    , axDataCondition
    , axStyle
    , axTranslate
    , axDomain
    , axDomainDash
    , axDomainDashOffset
    , axDomainCap
    , axDomainColor
    , axDomainOpacity
    , axDomainWidth
    , axFormat
    , axFormatAsNum
    , axFormatAsTemporal
    , axFormatAsCustom
    , axLabels
    , axLabelAlign
    , cAxLabelAlign
    , axLabelAngle
    , axLabelBaseline
    , cAxLabelBaseline
    , axLabelBound
    , axLabelBoundExpr
    , axLabelColor
    , cAxLabelColor
    , axLabelExpr
    , axLabelFlush
    , axLabelFlushOffset
    , axLabelFont
    , cAxLabelFont
    , axLabelFontSize
    , cAxLabelFontSize
    , axLabelFontStyle
    , cAxLabelFontStyle
    , axLabelFontWeight
    , cAxLabelFontWeight
    , axLabelLimit
    , axLabelLineHeight
    , axLabelOffset
    , cAxLabelOffset
    , axLabelOpacity
    , cAxLabelOpacity
    , axLabelOverlap
    , axLabelPadding
    , cAxLabelPadding
    , axLabelSeparation
    , axTicks
    , axTickBand
    , tbCenter
    , tbExtent
    , tbExpr
    , axTickCap
    , axTickColor
    , cAxTickColor
    , axTickCount
    , axTickDash
    , cAxTickDash
    , axTickDashOffset
    , cAxTickDashOffset
    , axTickExtra
    , axTickMinStep
    , axTickOffset
    , axTickOpacity
    , cAxTickOpacity
    , axTickRound
    , axTickSize
    , cAxTickSize
    , axTickWidth
    , cAxTickWidth
    , axValues
    , axTitle
    , axTitleAlign
    , axTitleAnchor
    , axTitleAngle
    , axTitleBaseline
    , axTitleColor
    , axTitleFont
    , axTitleFontSize
    , axTitleFontStyle
    , axTitleFontWeight
    , axTitleLimit
    , axTitleLineHeight
    , axTitleOpacity
    , axTitlePadding
    , axTitleX
    , axTitleY
    , axGrid
    , axGridCap
    , axGridColor
    , cAxGridColor
    , axGridDash
    , cAxGridDash
    , axGridDashOffset
    , cAxGridDashOffset
    , axGridOpacity
    , cAxGridOpacity
    , axGridWidth
    , cAxGridWidth
    , haLeft
    , haCenter
    , haRight
    , haExpr
    , vaTop
    , vaLineTop
    , vaMiddle
    , vaBottom
    , vaLineBottom
    , vaAlphabetic
    , vaExpr
    , osNone
    , osGreedy
    , osParity
    , osExpr
    , siTop
    , siBottom
    , siLeft
    , siRight
    , siExpr
    , size
    , angle
    , color
    , fill
    , stroke
    , strokeDash
    , strokeWidth
    , opacity
    , fillOpacity
    , strokeOpacity
    , shape
    , mName
    , mDatum
    , mRepeat
    , mRepeatDatum
    , mNominal
    , mOrdinal
    , mQuant
    , mTemporal
    , mGeo
    , mMType
    , mScale
    , mBin
    , mBinned
    , mBand
    , mSort
    , mTimeUnit
    , mTitle
    , mAggregate
    , mLegend
    , mPath
    , mNum
    , mStr
    , mBoo
    , mSymbol
    , leNumExpr
    , leNumsExpr
    , leStrExpr
    , leAria
    , leGradient
    , leSymbol
    , leClipHeight
    , leColumnPadding
    , leColumns
    , leCornerRadius
    , leDirection
    , leFillColor
    , leFormat
    , leFormatAsNum
    , leFormatAsTemporal
    , leFormatAsCustom
    , leGradientLength
    , leGradientOpacity
    , leGradientThickness
    , leGradientStrokeColor
    , leGradientStrokeWidth
    , leGridAlign
    , leLabelAlign
    , leLabelBaseline
    , leLabelColor
    , leLabelFont
    , leLabelFontSize
    , leLabelFontStyle
    , leLabelFontWeight
    , leLabelLimit
    , leLabelOffset
    , leLabelOverlap
    , leOffset
    , leOrient
    , lePadding
    , leRowPadding
    , leStrokeColor
    , leStrokeWidth
    , leSymbolDash
    , leSymbolDashOffset
    , leSymbolFillColor
    , leSymbolLimit
    , leSymbolOffset
    , leSymbolOpacity
    , leSymbolSize
    , leSymbolStrokeColor
    , leSymbolStrokeWidth
    , leSymbolType
    , leTickCount
    , leTitle
    , leTitleAlign
    , leTitleAnchor
    , leTitleBaseline
    , leTitleColor
    , leTitleFont
    , leTitleFontSize
    , leTitleFontStyle
    , leTitleFontWeight
    , leTitleLimit
    , leTitleLineHeight
    , leTitleOpacity
    , leTitleOrient
    , leTitlePadding
    , leType
    , leValues
    , leX
    , leY
    , leZIndex
    , loLeft
    , loRight
    , loTop
    , loBottom
    , loTopLeft
    , loTopRight
    , loBottomLeft
    , loBottomRight
    , loNone
    , text
    , tooltip
    , tooltips
    , tName
    , tRepeat
    , tNominal
    , tOrdinal
    , tQuant
    , tTemporal
    , tGeo
    , tMType
    , tBin
    , tBinned
    , tAggregate
    , tTimeUnit
    , tTitle
    , tStr
    , tDatum
    , tFormat
    , tFormatAsNum
    , tFormatAsTemporal
    , tFormatAsCustom
    , FontWeight
    , fwBold
    , fwBolder
    , fwLighter
    , fwNormal
    , fwValue
    , fwExpr
    , hyperlink
    , hName
    , hRepeat
    , hNominal
    , hOrdinal
    , hQuant
    , hTemporal
    , hGeo
    , hMType
    , hBin
    , hBinned
    , hAggregate
    , hTimeUnit
    , hStr
    , url
    , order
    , oName
    , oRepeat
    , oNominal
    , oOrdinal
    , oQuant
    , oTemporal
    , oGeo
    , oMType
    , oBin
    , oAggregate
    , oSort
    , oTimeUnit
    , oNum
    , row
    , column
    , detail
    , dName
    , dNominal
    , dOrdinal
    , dQuant
    , dTemporal
    , dGeo
    , dMType
    , dAggregate
    , dBin
    , dTimeUnit
    , key
    , kName
    , kMType
    , kNominal
    , kOrdinal
    , kQuant
    , kTemporal
    , kGeo
    , scType
    , scBooExpr
    , doNumExpr
    , scDomain
    , scDomainExpr
    , categoricalDomainMap
    , domainRangeMap
    , doNums
    , doMin
    , doMid
    , doMax
    , doStrs
    , doDts
    , doDtsExpr
    , doMinDt
    , doMinDtExpr
    , doMaxDt
    , doMaxDtExpr
    , doUnaggregated
    , doUnionWith
    , doSelection
    , doSelectionChannel
    , doSelectionField
    , raNumExpr
    , scRange
    , raExprs
    , raName
    , raNums
    , raMin
    , raMax
    , raNumLists
    , raStrs
    , raField
    , scScheme
    , scSchemeExpr
    , scAlign
    , scPadding
    , scPaddingInner
    , scPaddingOuter
    , scReverse
    , scRound
    , scClamp
    , scInterpolate
    , scNice
    , scZero
    , scBand
    , scBinOrdinal
    , scLinear
    , scLog
    , scSymLog
    , scConstant
    , scBase
    , scOrdinal
    , scPoint
    , scPow
    , scExponent
    , scQuantile
    , scQuantize
    , scSqrt
    , scThreshold
    , scTime
    , scUtc
    , niTrue
    , niFalse
    , niMillisecond
    , niSecond
    , niMinute
    , niHour
    , niDay
    , niWeek
    , niMonth
    , niYear
    , niTickCount
    , niInterval
    , niExpr
    , cubeHelix
    , cubeHelixLong
    , hcl
    , hclLong
    , hsl
    , hslLong
    , lab
    , rgb
    , layer
    , concat
    , columns
    , hConcat
    , vConcat
    , align
    , alignRC
    , caAll
    , caEach
    , caNone
    , bounds
    , boFull
    , boFlush
    , spacing
    , spacingRC
    , center
    , centerRC
    , resolve
    , resolution
    , reShared
    , reIndependent
    , reAxis
    , reLegend
    , reScale
    , chX
    , chY
    , chX2
    , chY2
    , chColor
    , chOpacity
    , chShape
    , chSize
    , chStrokeDash
    , repeatFlow
    , repeat
    , rowFields
    , columnFields
    , layerFields
    , facetFlow
    , facet
    , columnBy
    , rowBy
    , fName
    , fNominal
    , fOrdinal
    , fQuant
    , fTemporal
    , fGeo
    , fMType
    , fAggregate
    , fBin
    , fSort
    , fHeader
    , fTimeUnit
    , fAlign
    , fCenter
    , fSpacing
    , asSpec
    , specification
    , arLayer
    , arFlow
    , arColumn
    , arRow
    , hdNumExpr
    , hdStrExpr
    , hdLabelAngle
    , hdLabelAlign
    , hdLabelAnchor
    , hdLabelBaseline
    , hdLabelColor
    , hdLabelExpr
    , hdLabelFont
    , hdLabelFontSize
    , hdLabelFontStyle
    , hdLabelFontWeight
    , hdLabelLimit
    , hdLabelLineHeight
    , hdLabelOrient
    , hdLabelPadding
    , hdLabels
    , hdTitle
    , hdTitleAlign
    , hdTitleAnchor
    , hdTitleAngle
    , hdTitleBaseline
    , hdTitleColor
    , hdTitleFont
    , hdTitleFontStyle
    , hdTitleFontSize
    , hdTitleFontWeight
    , hdTitleLimit
    , hdTitleLineHeight
    , hdTitleOrient
    , hdOrient
    , hdTitlePadding
    , hdFormat
    , hdFormatAsNum
    , hdFormatAsTemporal
    , hdFormatAsCustom
    , params
    , param
    , paValue
    , paValues
    , paExpr
    , paSelect
    , sePoint
    , seInterval
    , seClear
    , seEncodings
    , seFields
    , seNearest
    , seOn
    , seToggle
    , tpFalse
    , tpExpr
    , tpShiftKey
    , tpAltKey
    , tpCtrlKey
    , seTranslate
    , seZoom
    , paBind
    , paBindings
    , paBindScales
    , paBindLegend
    , ipRange
    , ipCheckbox
    , ipRadio
    , ipSelect
    , ipText
    , ipNumber
    , ipDate
    , ipTime
    , ipMonth
    , ipWeek
    , ipDateTimeLocal
    , ipTel
    , ipColor
    , inDebounce
    , inElement
    , inOptions
    , inDatumOptions
    , inDataOptions
    , inMin
    , inMax
    , inName
    , inStep
    , inPlaceholder
    , seSelectionMark
    , smFill
    , smFillOpacity
    , smStroke
    , smStrokeDash
    , smStrokeDashOffset
    , smStrokeOpacity
    , smStrokeWidth
    , smCursor
    , seResolve
    , seGlobal
    , seUnion
    , seIntersection
    , mCondition
    , mConditions
    , oCondition
    , oConditions
    , tCondition
    , tConditions
    , hCondition
    , prParam
    , prParamEmpty
    , prTest
    , bParam
    , expr
    , and
    , or
    , not
    , name
    , description
    , height
    , heightOfContainer
    , width
    , widthOfContainer
    , widthStep
    , heightStep
    , padding
    , paSize
    , paSizeExpr
    , paEdges
    , paEdgesExpr
    , autosize
    , asContent
    , asFit
    , asFitX
    , asFitY
    , asNone
    , asPad
    , asPadding
    , asResize
    , background
    , backgroundExpr
    , tiNumExpr
    , tiStrExpr
    , title
    , titleExpr
    , tiAnchor
    , tiAngle
    , tiBaseline
    , tiColor
    , tiDx
    , tiDy
    , tiFont
    , tiFontSize
    , tiFontStyle
    , tiFontWeight
    , tiLineHeight
    , tiSubtitle
    , tiSubtitleColor
    , tiSubtitleFont
    , tiSubtitleFontSize
    , tiSubtitleFontStyle
    , tiSubtitleFontWeight
    , tiSubtitleLineHeight
    , tiSubtitlePadding
    , tiFrame
    , tfBounds
    , tfGroup
    , tfExpr
    , tiLimit
    , tiOffset
    , tiOrient
    , tiStyle
    , tiZIndex
    , viewBackground
    , vbNumExpr
    , vbNumsExpr
    , vbStrExpr
    , viewStyle
    , viewCornerRadius
    , viewFill
    , viewFillOpacity
    , viewOpacity
    , viewStroke
    , viewStrokeCap
    , viewStrokeDash
    , viewStrokeDashOffset
    , viewStrokeJoin
    , viewStrokeMiterLimit
    , viewStrokeOpacity
    , viewStrokeWidth
    , configure
    , configuration
    , coArea
    , coAria
    , coAutosize
    , coAxis
    , coAxisXFilter
    , coAxisYFilter
    , axX
    , axY
    , coAxisLeft
    , coAxisRight
    , coAxisTop
    , coAxisBottom
    , coAxisBand
    , coAxisDiscrete
    , coAxisPoint
    , coAxisQuant
    , coAxisTemporal
    , coAxisStyles
    , coBackground
    , coBar
    , coCircle
    , coConcat
    , coCountTitle
    , coCustomFormatTypes
    , coFieldTitle
    , coFont
    , coGeoshape
    , coFacet
    , coHeader
    , coLegend
    , coLine
    , coMark
    , coMarkStyles
    , coNumberFormat
    , coPadding
    , coPoint
    , coProjection
    , coRange
    , coRect
    , coRule
    , coScale
    , coSelection
    , coSquare
    , coText
    , coTick
    , coTitle
    , coTimeFormat
    , coTrail
    , coView
    , axcoAria
    , axcoBandPosition
    , axcoDisable
    , axcoDomain
    , axcoDomainDash
    , axcoDomainDashOffset
    , axcoDomainCap
    , axcoDomainColor
    , axcoDomainOpacity
    , axcoDomainWidth
    , axcoMaxExtent
    , axcoMinExtent
    , axcoTranslate
    , axcoGrid
    , axcoGridCap
    , axcoGridColor
    , axcoGridDash
    , axcoGridDashOffset
    , axcoGridOpacity
    , axcoGridWidth
    , axcoLabels
    , axcoLabelAlign
    , axcoLabelAngle
    , axcoLabelBaseline
    , axcoLabelBound
    , axcoLabelColor
    , axcoLabelExpr
    , axcoLabelFlush
    , axcoLabelFlushOffset
    , axcoLabelFont
    , axcoLabelFontSize
    , axcoLabelFontStyle
    , axcoLabelFontWeight
    , axcoLabelLimit
    , axcoLabelLineHeight
    , axcoLabelOpacity
    , axcoLabelOverlap
    , axcoLabelPadding
    , axcoLabelSeparation
    , axcoTicks
    , axcoTickBand
    , axcoTickCap
    , axcoTickColor
    , axcoTickCount
    , axcoTickDash
    , axcoTickDashOffset
    , axcoTickExtra
    , axcoTickOffset
    , axcoTickOpacity
    , axcoTickRound
    , axcoTickSize
    , axcoTickMinStep
    , axcoTickWidth
    , axcoTitleAlign
    , axcoTitleAnchor
    , axcoTitleAngle
    , axcoTitleBaseline
    , axcoTitleColor
    , axcoTitleFont
    , axcoTitleFontSize
    , axcoTitleFontStyle
    , axcoTitleFontWeight
    , axcoTitleLimit
    , axcoTitleLineHeight
    , axcoTitleOpacity
    , axcoTitlePadding
    , axcoTitleX
    , axcoTitleY
    , lecoAria
    , lecoClipHeight
    , lecoColumnPadding
    , lecoColumns
    , lecoCornerRadius
    , lecoDisable
    , lecoFillColor
    , lecoOrient
    , lecoOffset
    , lecoStrokeColor
    , lecoStrokeDash
    , lecoStrokeWidth
    , lecoPadding
    , lecoRowPadding
    , lecoGradientDirection
    , lecoGradientLabelBaseline
    , lecoGradientLabelLimit
    , lecoGradientLabelOffset
    , lecoGradientOpacity
    , lecoGradientStrokeColor
    , lecoGradientStrokeWidth
    , lecoGradientHeight
    , lecoGradientWidth
    , lecoGridAlign
    , lecoLabelAlign
    , lecoLabelBaseline
    , lecoLabelColor
    , lecoLabelFont
    , lecoLabelFontSize
    , lecoLabelFontStyle
    , lecoLabelFontWeight
    , lecoLabelLimit
    , lecoLabelOffset
    , lecoLabelOverlap
    , lecoEntryPadding
    , lecoSymbolBaseFillColor
    , lecoSymbolBaseStrokeColor
    , lecoSymbolDash
    , lecoSymbolDashOffset
    , lecoSymbolDirection
    , lecoSymbolFillColor
    , lecoSymbolLimit
    , lecoSymbolOffset
    , lecoSymbolOpacity
    , lecoSymbolSize
    , lecoSymbolStrokeColor
    , lecoSymbolStrokeWidth
    , lecoSymbolType
    , lecoTitleAlign
    , lecoTitleAnchor
    , lecoTitleBaseline
    , lecoTitleColor
    , lecoTitleFont
    , lecoTitleFontSize
    , lecoTitleFontStyle
    , lecoTitleFontWeight
    , lecoTitleLimit
    , lecoTitleLineHeight
    , lecoTitleOpacity
    , lecoTitlePadding
    , lecoUnselectedOpacity
    , sacoBandPaddingInner
    , sacoBandPaddingOuter
    , sacoBarBandPaddingInner
    , sacoBarBandPaddingOuter
    , sacoRectBandPaddingInner
    , sacoRectBandPaddingOuter
    , sacoClamp
    , sacoMaxBandSize
    , sacoMinBandSize
    , sacoMaxFontSize
    , sacoMinFontSize
    , sacoMaxOpacity
    , sacoMinOpacity
    , sacoMaxSize
    , sacoMinSize
    , sacoMaxStrokeWidth
    , sacoMinStrokeWidth
    , sacoPointPadding
    , sacoRound
    , sacoUseUnaggregatedDomain
    , sacoXReverse
    , racoCategory
    , racoDiverging
    , racoHeatmap
    , racoOrdinal
    , racoRamp
    , racoSymbol
    , ticoAnchor
    , ticoAngle
    , ticoBaseline
    , ticoColor
    , ticoDx
    , ticoDy
    , ticoFont
    , ticoFontSize
    , ticoFontStyle
    , ticoFontWeight
    , ticoLineHeight
    , ticoSubtitleColor
    , ticoSubtitleFont
    , ticoSubtitleFontSize
    , ticoSubtitleFontStyle
    , ticoSubtitleFontWeight
    , ticoSubtitleLineHeight
    , ticoSubtitlePadding
    , ticoFrame
    , ticoLimit
    , ticoOffset
    , ticoOrient
    , ticoStyle
    , ticoZIndex
    , vicoBackground
    , vicoContinuousWidth
    , vicoContinuousHeight
    , vicoCursor
    , vicoDiscreteWidth
    , vicoDiscreteHeight
    , vicoClip
    , vicoCornerRadius
    , vicoFill
    , vicoFillOpacity
    , vicoOpacity
    , vicoStep
    , vicoStroke
    , vicoStrokeCap
    , vicoStrokeDash
    , vicoStrokeDashOffset
    , vicoStrokeJoin
    , vicoStrokeMiterLimit
    , vicoStrokeOpacity
    , vicoStrokeWidth
    , anStart
    , anMiddle
    , anEnd
    , anExpr
    , ftVerbal
    , ftFunction
    , ftPlain
    , facoColumns
    , facoSpacing
    , cocoColumns
    , cocoSpacing
    , boo
    , true
    , false
    , dt
    , num
    , str
    , datumExpr
    , dataExpr
    , datumArray
    , dataArrays
    , dataObject
    , dataObjects
    , nullValue
    , daConcat
    , boos
    , dts
    , nums
    , strs
    , dtYear
    , dtQuarter
    , dtMonth
    , dtMonthNum
    , dtDate
    , dtDay
    , dtHour
    , dtMinute
    , dtSecond
    , dtMillisecond
    , MonthName(..)
    , DayName(..)
    , date
    , dayOfYear
    , day
    , dayHours
    , dayHoursMinutes
    , dayHoursMinutesSeconds
    , hours
    , hoursMinutes
    , hoursMinutesSeconds
    , milliseconds
    , minutes
    , minutesSeconds
    , month
    , monthDate
    , monthDateHours
    , monthDateHoursMinutes
    , monthDateHoursMinutesSeconds
    , quarter
    , quarterMonth
    , seconds
    , secondsMilliseconds
    , week
    , weekDay
    , weekDayHours
    , weekDayHoursMinutes
    , weekDayHoursMinutesSeconds
    , year
    , yearQuarter
    , yearQuarterMonth
    , yearMonth
    , yearMonthDate
    , yearMonthDateHours
    , yearMonthDateHoursMinutes
    , yearMonthDateHoursMinutesSeconds
    , yearWeek
    , yearWeekDay
    , yearWeekDayHours
    , yearWeekDayHoursMinutes
    , yearWeekDayHoursMinutesSeconds
    , yearDayOfYear
    , utc
    , tuMaxBins
    , tuStep
    , Anchor
    , Aria
    , Arrangement
    , Autosize
    , AxisProperty
    , AxisChoice
    , AxisConfig
    , BinProperty
    , BlendMode
    , BooleanOp
    , Bounds
    , CInterpolate
    , Channel
    , ClipRect
    , ColorGradient
    , CompositionAlignment
    , ConcatConfig
    , ConditionalAxisProperty
    , ConfigurationProperty
    , Cursor
    , DataType
    , DataValue
    , DataValues
    , DateTime
    , DensityProperty
    , DetailChannel
    , FacetChannel
    , FacetConfig
    , FacetMapping
    , FieldTitleProperty
    , Filter
    , FilterRange
    , Format
    , Geometry
    , GradientProperty
    , GraticuleProperty
    , HAlign
    , HeaderProperty
    , HyperlinkChannel
    , ImMethod
    , ImputeProperty
    , InputProperty
    , KeyChannel
    , Legend
    , LegendConfig
    , LegendOrientation
    , LegendProperty
    , LineMarker
    , LoessProperty
    , LookupFields
    , Mark
    , MarkChannel
    , MarkInterpolation
    , MarkOrientation
    , MarkProperty
    , Operation
    , OrderChannel
    , OverlapStrategy
    , Padding
    , ParamProperty
    , PBinding
    , PivotProperty
    , PointMarker
    , PositionChannel
    , Predicate
    , Projection
    , ProjectionProperty
    , QuantileProperty
    , RangeConfig
    , RegressionMethod
    , RegressionProperty
    , RepeatFields
    , Resolution
    , Resolve
    , Scale
    , ScaleDomain
    , ScaleNice
    , ScaleProperty
    , ScaleConfig
    , ScaleRange
    , Selection
    , SelectionMarkProperty
    , SelectionProperty
    , SelectionResolution
    , Side
    , SortField
    , SortProperty
    , StackOffset
    , StackProperty
    , StrokeCap
    , StrokeJoin
    , SummaryExtent
    , Symbol
    , TextChannel
    , TimeUnit
    , TitleConfig
    , TitleFrame
    , TitleProperty
    , TogglePredicate
    , TooltipContent
    , VAlign
    , ViewBackground
    , ViewConfig
    , Window
    , WOperation
    , WindowProperty
    , Binding
    , BindLegendProperty
    , blField
    , blChannel
    , blEvent
    , hDataCondition
    , hSelectionCondition
    , iCheckbox
    , iColor
    , iDate
    , iDateTimeLocal
    , iMonth
    , iNumber
    , iRadio
    , iRange
    , iSelect
    , iTel
    , iText
    , iTime
    , iWeek
    , lecoShortTimeLabels
    , mDataCondition
    , mSelectionCondition
    , oDataCondition
    , oSelectionCondition
    , pBand
    , scDomainMid
    , seBind
    , seBindLegend
    , seBindScales
    , seEmpty
    , seInit
    , seInitInterval
    , select
    , selected
    , selection
    , selectionName
    , seMulti
    , seSingle
    , tDataCondition
    , tSelectionCondition
    -- , axcoStyle
    --, leUnselectedOpacity
    -- TODO: CHECK IF THESE WILL BE NEEDED
    --, raMaxStr
    --  , raMinStr
    -- , ttExpr
    )

{-| Create Vega-Lite visualization specifications in Elm. This package allows you
to generate the JSON specs that may be passed to the Vega-Lite runtime library via
a port to activate the visualization. Alternatively, to avoid coding the link to
the Vega-Lite runtime, you can embed specifications directly in a
[litvis document](https://github.com/gicentre/litvis).

1.  [Creating a specification](#1-creating-a-vega-lite-specification)
2.  [Specifying the Data to Visualize](#2-specifying-the-data-to-visualize)
3.  [Transforming Data](#3-transforming-data)
4.  [Specifying Marks](#4-specifying-marks)
5.  [Encoding Data as Channels](#5-encoding-data-as-channels)
6.  [View Composition](#6-view-composition)
7.  [Parameters](#7-parameters)
8.  [Top-level Settings](#8-top-level-settings)
9.  [General Data Functions](#9-general-data-functions)
10. [Type Reference](#10-type-reference)
11. [Deprecated Types and Functions](#11-deprecated-types-and-functions)

---


# 1. Creating A Vega-Lite Specification

@docs toVegaLite
@docs VLProperty
@docs Spec
@docs LabelledSpec
@docs combineSpecs

---


# 2. Specifying the Data to Visualize

To create a visualization, you will need to specify what data you wish to visualize.
For context, see the
[Vega-Lite documentation](https://vega.github.io/vega-lite/docs/data.html#format).

  - [2.1 Geographic Data](#2-1-geographic-data)
  - [2.2 Data Generators](#2-2-data-generators)
  - [2.3 Formatting Input Data](#2-3-formatting-input-data)

@docs dataFromUrl
@docs dataFromColumns
@docs dataColumn
@docs dataFromRows
@docs dataRow
@docs dataFromJson
@docs jsonToSpec
@docs dataFromSource
@docs dataName
@docs datasets
@docs noData
@docs Data
@docs DataColumn
@docs DataRow


## 2.1 Geographic Data

@docs geometry
@docs geoFeatureCollection
@docs geometryCollection
@docs geoPoint
@docs geoPoints
@docs geoLine
@docs geoLines
@docs geoPolygon
@docs geoPolygons


## 2.2 Data Generators

Functions that create new data sources.

@docs dataSequence
@docs dataSequenceAs
@docs sphere
@docs graticule

@docs grStep
@docs grStepMajor
@docs grStepMinor
@docs grExtent
@docs grExtentMajor
@docs grExtentMinor
@docs grPrecision


## 2.3 Formatting Input Data

See the Vega-Lite
[format](https://vega.github.io/vega-lite/docs/data.html#format) and
[JSON](https://vega.github.io/vega-lite/docs/data.html#json) documentation.

@docs csv
@docs tsv
@docs dsv
@docs arrow
@docs jsonProperty
@docs topojsonFeature
@docs topojsonMesh
@docs parse

@docs foNum
@docs foBoo
@docs foDate
@docs foUtc

---


# 3. Transforming Data

Transformation rules are applied to data fields or geospatial coordinates before
they are encoded visually.

  - [3.1 Map Projections](#3-1-map-projections)
  - [3.2 Aggregation](#3-2-aggregation)
  - [3.3 Binning](#3-3-binning)
  - [3.4 Stacking](#3-4-stacking)
  - [3.5 Data Calculation](#3-5-data-calculation)
  - [3.6 Filtering](#3-6-filtering)
  - [3.7 Flattening](#3-7-flattening)
  - [3.8 Folding and Pivoting](#3-8-folding-and-pivoting)
  - [3.9 Relational Joining](#3-9-relational-joining)
  - [3.10 Data Imputation](#3-10-data-imputation)
  - [3.11 Data Sampling](#3-11-data-sampling)
  - [3.12 Density Estimation](#3-12-density-estimation)
  - [3.13 Loess Trend Calculation](#3-13-loess-trend-calculation)
  - [3.14 Regression Calculation](#3-14-regression-calculation)
  - [3.15] Quantile Calculation](#3-15-quantile-calculation)
  - [3.16 Window Transformations](#3-16-window-transformations)

@docs transform


## 3.1 Map Projections

See the
[Vega-Lite map projection documentation](https://vega.github.io/vega-lite/docs/projection.html).

@docs projection

@docs prNumExpr

@docs prType
@docs prExpr
@docs prClipAngle
@docs prClipExtent
@docs prCenter
@docs prCenterExpr
@docs prScale
@docs prTranslate
@docs prTranslateExpr
@docs prRotate
@docs prRotateExpr
@docs prPrecision
@docs prCoefficient
@docs prDistance
@docs prFraction
@docs prLobes
@docs prParallel
@docs prParallels
@docs prParallelsExpr
@docs prPointRadius
@docs prRadius
@docs prRatio
@docs prReflectX
@docs prReflectY
@docs prSpacing
@docs prTilt

@docs albers
@docs albersUsa
@docs azimuthalEqualArea
@docs azimuthalEquidistant
@docs conicConformal
@docs conicEqualArea
@docs conicEquidistant
@docs equalEarth
@docs equirectangular
@docs gnomonic
@docs identityProjection
@docs mercator
@docs naturalEarth1
@docs orthographic
@docs stereographic
@docs transverseMercator
@docs customProjection
@docs noClip
@docs clipRect
@docs clipRectExpr


## 3.2 Aggregation

See the
[Vega-Lite aggregate documentation](https://vega.github.io/vega-lite/docs/aggregate.html).

@docs aggregate
@docs joinAggregate
@docs opAs
@docs timeUnitAs
@docs opArgMax
@docs opArgMin
@docs opCI0
@docs opCI1
@docs opCount
@docs opDistinct
@docs opMax
@docs opMean
@docs opMedian
@docs opMin
@docs opMissing
@docs opProduct
@docs opQ1
@docs opQ3
@docs opStderr
@docs opStdev
@docs opStdevP
@docs opSum
@docs opValid
@docs opVariance
@docs opVarianceP


## 3.3 Binning

See the [Vega-Lite binning documentation](https://vega.github.io/vega-lite/docs/bin.html).

@docs binAs
@docs biAnchor
@docs biBase
@docs biDivide
@docs biExtent
@docs biSelectionExtent
@docs biMaxBins
@docs biMinStep
@docs biNice
@docs biStep
@docs biSteps


## 3.4 Stacking

See the [Vega-Lite stack documentation](https://vega.github.io/vega-lite/docs/stack.html)

@docs stack
@docs stOffset
@docs stNormalize
@docs stCenter
@docs stZero
@docs stNone
@docs stSort
@docs stAscending
@docs stDescending


## 3.5 Data Calculation

See
[Vega-Lite calculate documentation](https://vega.github.io/vega-lite/docs/calculate.html).

@docs calculateAs


## 3.6 Filtering

See the
[Vega-Lite filter documentation](https://vega.github.io/vega-lite/docs/filter.html).

@docs filter

@docs fiEqual
@docs fiLessThan
@docs fiLessThanEq
@docs fiGreaterThan
@docs fiGreaterThanEq
@docs fiExpr
@docs fiSelection
@docs fiSelectionEmpty
@docs fiOp
@docs fiOpTrans
@docs fiCompose
@docs fiOneOf
@docs fiRange
@docs fiValid
@docs numRange
@docs dtRange


## 3.7 Flattening

See the Vega-Lite [flatten](https://vega.github.io/vega-lite/docs/flatten.html)
and [fold](https://vega.github.io/vega-lite/docs/fold.html) documentation.

@docs flatten
@docs flattenAs


## 3.8 Folding and Pivoting

Data tidying operations that reshape the rows and columns of a dataset.
See the Vega-Lite [fold](https://vega.github.io/vega-lite/docs/fold.html) and
[pivot](https://vega.github.io/vega-lite/docs/pivot.html) documentation.

@docs fold
@docs foldAs

@docs pivot
@docs piGroupBy
@docs piLimit
@docs piOp


## 3.9 Relational Joining

Create lookups between data tables in order to join values from multiple sources.
See the [Vega-Lite lookup documentation](https://vega.github.io/vega-lite/docs/lookup.html).

@docs lookup
@docs lookupSelection
@docs luFields
@docs luFieldsWithDefault
@docs luFieldsAs
@docs luFieldsAsWithDefault
@docs luAs
@docs luAsWithDefault


## 3.10 Data Imputation

Impute missing data. See the
[Vega-Lite impute documentation](https://vega.github.io/vega-lite/docs/impute.html#transform).

@docs impute
@docs imFrame
@docs imKeyVals
@docs imKeyValSequence
@docs imMethod
@docs imGroupBy
@docs imNewValue
@docs imValue
@docs imMean
@docs imMedian
@docs imMax
@docs imMin


## 3.11 Data Sampling

See the [Vega-Lite sample documentation](https://vega.github.io/vega-lite/docs/sample.html)

@docs sample


## 3.12 Density Estimation

See the [Vega-Lite density documentation](https://vega.github.io/vega-lite/docs/density.html)

@docs density
@docs dnGroupBy
@docs dnCumulative
@docs dnCounts
@docs dnBandwidth
@docs dnExtent
@docs dnMinSteps
@docs dnMaxSteps
@docs dnSteps
@docs dnAs


## 3.13 Loess Trend Calculation

See the [Vega-Lite loess documentation](https://vega.github.io/vega-lite/docs/loess.html)

@docs loess
@docs lsGroupBy
@docs lsBandwidth
@docs lsAs


## 3.14 Regression Calculation

See the [Vega-Lite regression documentation](https://vega.github.io/vega-lite/docs/regression.html)

@docs regression
@docs rgGroupBy
@docs rgMethod
@docs rgOrder
@docs rgExtent
@docs rgParams
@docs rgAs

@docs rgLinear
@docs rgLog
@docs rgExp
@docs rgPow
@docs rgQuad
@docs rgPoly


## 3.15 Quantile Calculation

@docs quantile
@docs qtGroupBy
@docs qtProbs
@docs qtStep
@docs qtAs


## 3.16 Window Transformations

See the Vega-Lite
[window transform field](https://vega.github.io/vega-lite/docs/window.html#field-def)
and [window transform](https://vega.github.io/vega-lite/docs/window.html#window-transform-definition)
documentation.

@docs window
@docs wiAggregateOp
@docs wiOp
@docs wiParam
@docs wiField
@docs woRowNumber
@docs woRank
@docs woDenseRank
@docs woPercentRank
@docs woCumeDist
@docs woPercentile
@docs woLag
@docs woLead
@docs woFirstValue
@docs woLastValue
@docs woNthValue
@docs wiFrame
@docs wiIgnorePeers
@docs wiGroupBy
@docs wiSort
@docs wiAscending
@docs wiDescending

---


# 4. Specifying Marks

Functions for declaring the type of visual marks used to represent encoded data.

  - 4.1 [Types of Mark](#4-1-types-of-mark)
  - 4.2 [Mark Properties](#4-2-mark-properties)


## 4.1 Types of Mark

@docs arc
@docs area
@docs bar
@docs boxplot
@docs errorband
@docs errorbar
@docs circle
@docs geoshape
@docs image
@docs line
@docs point
@docs rect
@docs rule
@docs square
@docs textMark
@docs tick
@docs trail


## 4.2 Mark Properties

See the Vega-Lite
[general mark](https://vega.github.io/vega-lite/docs/mark.html#general-mark-properties),
[area mark](https://vega.github.io/vega-lite/docs/area.html#properties),
[bar mark](https://vega.github.io/vega-lite/docs/bar.html#properties),
[boxplot](https://vega.github.io/vega-lite/docs/boxplot.html#properties),
[circle mark](https://vega.github.io/vega-lite/docs/circle.html#properties),
[error band](https://vega.github.io/vega-lite/docs/errorband.html#properties),
[error bar](https://vega.github.io/vega-lite/docs/errorbar.html#properties),
[hyperlink mark](https://vega.github.io/vega-lite/docs/mark.html#hyperlink),
[line mark](https://vega.github.io/vega-lite/docs/line.html#properties),
[point mark](https://vega.github.io/vega-lite/docs/point.html#properties),
[square mark](https://vega.github.io/vega-lite/docs/square.html#properties),
[text mark](https://vega.github.io/vega-lite/docs/text.html#properties) and
[tick mark](https://vega.github.io/vega-lite/docs/tick.html#properties)
property documentation.

@docs maBooExpr
@docs maNumExpr
@docs maStrExpr
@docs maAlign
@docs maAngle
@docs maAria
@docs maBandSize
@docs maBaseline
@docs maBinSpacing
@docs maBlend
@docs maBorders
@docs maBox
@docs maClip
@docs maRemoveInvalid
@docs maColor
@docs maColorGradient
@docs maCornerRadius
@docs maCornerRadiusEnd
@docs maCornerRadiusTopLeft
@docs maCornerRadiusTopRight
@docs maCornerRadiusBottomLeft
@docs maCornerRadiusBottomRight
@docs maCursor
@docs maExtent
@docs maHRef
@docs maContinuousBandSize
@docs maDiscreteBandSize
@docs maLimit
@docs maDir
@docs maEllipsis
@docs maDx
@docs maDy
@docs maInnerRadius
@docs maOuterRadius
@docs maPadAngle
@docs maFill
@docs maFillGradient
@docs maFilled
@docs maFillOpacity
@docs maFont
@docs maFontSize
@docs maFontStyle
@docs maFontWeight
@docs maInterpolate
@docs maOpacity
@docs maOrder
@docs maOrient
@docs maPoint
@docs maLine
@docs maMedian
@docs maOutliers
@docs maRadius
@docs maRule
@docs maShape
@docs maShortTimeLabels
@docs maSize
@docs maStroke
@docs maStrokeGradient
@docs maStrokeCap
@docs caRound
@docs caSquare
@docs caButt
@docs caExpr
@docs maStrokeDash
@docs maStrokeDashExpr
@docs maStrokeDashOffset
@docs maStrokeJoin
@docs joRound
@docs joBevel
@docs joMiter
@docs joExpr
@docs maStrokeMiterLimit
@docs maStrokeOpacity
@docs maStrokeWidth
@docs maStyle
@docs maTension
@docs maText
@docs maLineHeight
@docs maTheta
@docs maTheta2
@docs maThickness
@docs maTicks
@docs maTooltip
@docs maWidth
@docs maHeight
@docs maX
@docs maY
@docs maXOffset
@docs maYOffset
@docs maThetaOffset
@docs maTheta2Offset
@docs maX2
@docs maY2
@docs maX2Offset
@docs maY2Offset
@docs maRadiusOffset
@docs maRadius2Offset
@docs maAspect


### 4.2.1 Color Gradients

@docs grLinear
@docs grRadial
@docs grX1
@docs grX2
@docs grY1
@docs grY2
@docs grR1
@docs grR2
@docs grStops


### 4.2.2 Used by Mark Properties

@docs arEnable
@docs arDisable
@docs arDescription
@docs arExpr

@docs moHorizontal
@docs moVertical
@docs miBasis
@docs miBasisOpen
@docs miBasisClosed
@docs miBundle
@docs miCardinal
@docs miCardinalOpen
@docs miCardinalClosed
@docs miLinear
@docs miLinearClosed
@docs miMonotone
@docs miStepwise
@docs miStepAfter
@docs miStepBefore
@docs miExpr

@docs tdLeftToRight
@docs tdRightToLeft
@docs tdExpr

@docs symCircle
@docs symCross
@docs symDiamond
@docs symSquare
@docs symTriangleUp
@docs symTriangleDown
@docs symTriangleLeft
@docs symTriangleRight
@docs symPath
@docs symStroke
@docs symArrow
@docs symWedge
@docs symTriangle
@docs symExpr
@docs pmNone
@docs pmTransparent
@docs pmMarker
@docs lmMarker
@docs lmNone
@docs exRange
@docs exCi
@docs exIqr
@docs exIqrScale
@docs exStderr
@docs exStdev
@docs ttData
@docs ttEncoding
@docs ttNone


### 4.2.3 Blend Modes

@docs bmNormal
@docs bmMultiply
@docs bmScreen
@docs bmOverlay
@docs bmDarken
@docs bmLighten
@docs bmColorDodge
@docs bmColorBurn
@docs bmHardLight
@docs bmSoftLight
@docs bmDifference
@docs bmExclusion
@docs bmHue
@docs bmSaturation
@docs bmColor
@docs bmLuminosity
@docs bmExpr


### 4.2.4 Cursors

See the
[CSS cursor documentation](https://developer.mozilla.org/en-US/docs/Web/CSS/cursor#Keyword%20values)

@docs cuAuto
@docs cuDefault
@docs cuNone
@docs cuContextMenu
@docs cuHelp
@docs cuPointer
@docs cuProgress
@docs cuWait
@docs cuCell
@docs cuCrosshair
@docs cuText
@docs cuVerticalText
@docs cuAlias
@docs cuCopy
@docs cuMove
@docs cuNoDrop
@docs cuNotAllowed
@docs cuAllScroll
@docs cuColResize
@docs cuRowResize
@docs cuNResize
@docs cuEResize
@docs cuSResize
@docs cuWResize
@docs cuNEResize
@docs cuNWResize
@docs cuSEResize
@docs cuSWResize
@docs cuEWResize
@docs cuNSResize
@docs cuNESWResize
@docs cuNWSEResize
@docs cuZoomIn
@docs cuZoomOut
@docs cuGrab
@docs cuGrabbing
@docs cuExpr

---


# 5. Encoding Data as Channels

Describes the mapping between data fields and the channels (position, color etc.)
used to determine the visual appearance of marks that represent them.

  - 5.1 [Position Channel](#5-1-position-channel)
  - 5.2 [Mark Channels](#5-2-mark-channels)
  - 5.3 [Text Channel](#5-3-text-channel)
  - 5.4 [Hyperlink Channel](#5-4-hyperlink-channel)
  - 5.5 [URL Channel](#5-5-url-channel)
  - 5.6 [Order Channel](#5-6-order-channel)
  - 5.7 [Facet Channels](#5-7-facet-channels)
  - 5.8 [Level of Detail Channel](#5-8-level-of-detail-channel)
  - 5.9 [Key Channel](#5-9-key-channel)
  - 5.10 [Scaling](#5-10-scaling)

@docs encoding
@docs Measurement


## 5.1 Position channel

Relates to where something appears in the visualization.
See the
[Vega-Lite position documentation](https://vega.github.io/vega-lite/docs/encoding.html#position)

@docs position
@docs Position


### 5.1.1 Position Channel Properties

@docs pName
@docs pDatum
@docs pRepeat
@docs pNominal
@docs pOrdinal
@docs pQuant
@docs pTemporal
@docs pGeo
@docs pMType
@docs pBin
@docs pBinned
@docs pTimeUnit
@docs pTitle
@docs pAggregate
@docs pScale
@docs pAxis
@docs pSort
@docs pBandPosition
@docs pStack
@docs pWidth
@docs pHeight
@docs pNum
@docs pImpute


### 5.1.2 Sorting Properties

See the
[Vega-Lite sort documentation](https://vega.github.io/vega-lite/docs/sort.html).

@docs soAscending
@docs soDescending
@docs soByField
@docs soByChannel
@docs soByRepeat
@docs soCustom


### 5.1.3 Axis Properties

See the
[Vega-Lite axis property documentation](https://vega.github.io/vega-lite/docs/axis.html#axis-properties)

@docs axBooExpr
@docs axNumExpr
@docs axNumsExpr
@docs axStrExpr


#### General

@docs axAria
@docs axBandPosition
@docs axMaxExtent
@docs axMinExtent
@docs axOrient
@docs axOffset
@docs axPosition
@docs axZIndex
@docs axDataCondition
@docs axStyle
@docs axTranslate


#### Axis Domain

@docs axDomain
@docs axDomainDash
@docs axDomainDashOffset
@docs axDomainCap
@docs axDomainColor
@docs axDomainOpacity
@docs axDomainWidth


#### Axis Labels

@docs axFormat
@docs axFormatAsNum
@docs axFormatAsTemporal
@docs axFormatAsCustom
@docs axLabels
@docs axLabelAlign
@docs cAxLabelAlign
@docs axLabelAngle
@docs axLabelBaseline
@docs cAxLabelBaseline
@docs axLabelBound
@docs axLabelBoundExpr
@docs axLabelColor
@docs cAxLabelColor
@docs axLabelExpr
@docs axLabelFlush
@docs axLabelFlushOffset
@docs axLabelFont
@docs cAxLabelFont
@docs axLabelFontSize
@docs cAxLabelFontSize
@docs axLabelFontStyle
@docs cAxLabelFontStyle
@docs axLabelFontWeight
@docs cAxLabelFontWeight
@docs axLabelLimit
@docs axLabelLineHeight
@docs axLabelOffset
@docs cAxLabelOffset
@docs axLabelOpacity
@docs cAxLabelOpacity
@docs axLabelOverlap
@docs axLabelPadding
@docs cAxLabelPadding
@docs axLabelSeparation


#### Axis Ticks

@docs axTicks
@docs axTickBand
@docs tbCenter
@docs tbExtent
@docs tbExpr
@docs axTickCap
@docs axTickColor
@docs cAxTickColor
@docs axTickCount
@docs axTickDash
@docs cAxTickDash
@docs axTickDashOffset
@docs cAxTickDashOffset
@docs axTickExtra
@docs axTickMinStep
@docs axTickOffset
@docs axTickOpacity
@docs cAxTickOpacity
@docs axTickRound
@docs axTickSize
@docs cAxTickSize
@docs axTickWidth
@docs cAxTickWidth
@docs axValues


#### Axis Title

@docs axTitle
@docs axTitleAlign
@docs axTitleAnchor
@docs axTitleAngle
@docs axTitleBaseline
@docs axTitleColor
@docs axTitleFont
@docs axTitleFontSize
@docs axTitleFontStyle
@docs axTitleFontWeight
@docs axTitleLimit
@docs axTitleLineHeight
@docs axTitleOpacity
@docs axTitlePadding
@docs axTitleX
@docs axTitleY


#### Axis Grid

@docs axGrid
@docs axGridCap
@docs axGridColor
@docs cAxGridColor
@docs axGridDash
@docs cAxGridDash
@docs axGridDashOffset
@docs cAxGridDashOffset
@docs axGridOpacity
@docs cAxGridOpacity
@docs axGridWidth
@docs cAxGridWidth


### 5.1.4 Positioning Constants


#### Text Alignment

@docs haLeft
@docs haCenter
@docs haRight
@docs haExpr

@docs vaTop
@docs vaLineTop
@docs vaMiddle
@docs vaBottom
@docs vaLineBottom
@docs vaAlphabetic
@docs vaExpr


#### Overlapping text

@docs osNone
@docs osGreedy
@docs osParity
@docs osExpr


### Relative Position

@docs siTop
@docs siBottom
@docs siLeft
@docs siRight
@docs siExpr


## 5.2 Mark Channels

Appearance of the visual marks in the visualization such as their color or size.

@docs size
@docs angle
@docs color
@docs fill
@docs stroke
@docs strokeDash
@docs strokeWidth
@docs opacity
@docs fillOpacity
@docs strokeOpacity
@docs shape


### 5.2.1 Mark Channel Properties

@docs mName
@docs mDatum
@docs mRepeat
@docs mRepeatDatum
@docs mNominal
@docs mOrdinal
@docs mQuant
@docs mTemporal
@docs mGeo
@docs mMType
@docs mScale
@docs mBin
@docs mBinned
@docs mBand
@docs mSort
@docs mTimeUnit
@docs mTitle
@docs mAggregate
@docs mLegend
@docs mPath
@docs mNum
@docs mStr
@docs mBoo
@docs mSymbol


### 5.2.2 Mark Legends

See the
[Vega-Lite legend property documentation](https://vega.github.io/vega-lite/docs/legend.html#legend-properties).

@docs leNumExpr
@docs leNumsExpr
@docs leStrExpr

@docs leAria
@docs leGradient
@docs leSymbol
@docs leClipHeight
@docs leColumnPadding
@docs leColumns
@docs leCornerRadius
@docs leDirection
@docs leFillColor
@docs leFormat
@docs leFormatAsNum
@docs leFormatAsTemporal
@docs leFormatAsCustom
@docs leGradientLength
@docs leGradientOpacity
@docs leGradientThickness
@docs leGradientStrokeColor
@docs leGradientStrokeWidth
@docs leGridAlign
@docs leLabelAlign
@docs leLabelBaseline
@docs leLabelColor
@docs leLabelFont
@docs leLabelFontSize
@docs leLabelFontStyle
@docs leLabelFontWeight
@docs leLabelLimit
@docs leLabelOffset
@docs leLabelOverlap
@docs leOffset
@docs leOrient
@docs lePadding
@docs leRowPadding
@docs leStrokeColor
@docs leStrokeWidth
@docs leSymbolDash
@docs leSymbolDashOffset
@docs leSymbolFillColor
@docs leSymbolLimit
@docs leSymbolOffset
@docs leSymbolOpacity
@docs leSymbolSize
@docs leSymbolStrokeColor
@docs leSymbolStrokeWidth
@docs leSymbolType
@docs leTickCount
@docs leTitle
@docs leTitleAlign
@docs leTitleAnchor
@docs leTitleBaseline
@docs leTitleColor
@docs leTitleFont
@docs leTitleFontSize
@docs leTitleFontStyle
@docs leTitleFontWeight
@docs leTitleLimit
@docs leTitleLineHeight
@docs leTitleOpacity
@docs leTitleOrient
@docs leTitlePadding
@docs leType
@docs leValues
@docs leX
@docs leY
@docs leZIndex


#### Legend Constants

@docs loLeft
@docs loRight
@docs loTop
@docs loBottom
@docs loTopLeft
@docs loTopRight
@docs loBottomLeft
@docs loBottomRight
@docs loNone


## 5.3 Text Channel

Relate to the appearance of the text and tooltip elements of the visualization.
See the
[Vega-Lite text documentation](https://vega.github.io/vega-lite/docs/encoding.html#text)

@docs text
@docs tooltip
@docs tooltips
@docs tName
@docs tRepeat
@docs tNominal
@docs tOrdinal
@docs tQuant
@docs tTemporal
@docs tGeo
@docs tMType
@docs tBin
@docs tBinned
@docs tAggregate
@docs tTimeUnit
@docs tTitle
@docs tStr
@docs tDatum
@docs tFormat
@docs tFormatAsNum
@docs tFormatAsTemporal
@docs tFormatAsCustom
@docs FontWeight
@docs fwBold
@docs fwBolder
@docs fwLighter
@docs fwNormal
@docs fwValue
@docs fwExpr


## 5.4 Hyperlink Channel

Relates to a clickable URL destination of a mark. Unlike most other channels, the
hyperlink channel has no direct visual expression other than the option of changing
the cursor style when hovering, so an encoding will usually pair hyperlinks with
other visual channels such as marks or texts. See the
[Vega-Lite hyperlink documentation](https://vega.github.io/vega-lite/docs/encoding.html#href)

@docs hyperlink
@docs hName
@docs hRepeat
@docs hNominal
@docs hOrdinal
@docs hQuant
@docs hTemporal
@docs hGeo
@docs hMType
@docs hBin
@docs hBinned
@docs hAggregate
@docs hTimeUnit
@docs hStr


## 5.5 URL Channel

Data-driven URL used for [image](#image) specification. A data field can contain
URL strings defining the location of image files that can be shown with the [image](#image)
mark.

@docs url


## 5.6 Order Channel

Channel that relate to the order of data fields such as for sorting stacking order
or order of data points in a connected scatterplot. See the
[Vega-Lite order documentation](https://vega.github.io/vega-lite/docs/encoding.html#order).

@docs order
@docs oName
@docs oRepeat
@docs oNominal
@docs oOrdinal
@docs oQuant
@docs oTemporal
@docs oGeo
@docs oMType
@docs oBin
@docs oAggregate
@docs oSort
@docs oTimeUnit
@docs oNum


## 5.7 Facet Channels

Channel for faceting single plots into small multiples. Can be used to create
trellis plots or other arrangements in rows and columns. See the
[Vega-Lite facet documentation](https://vega.github.io/vega-lite/docs/facet.html).
See also, 'faceted view composition' for a more flexible (but more verbose) way
of defining faceted views.

@docs row
@docs column


## 5.8 Level of Detail Channel

Used for grouping data but without changing the visual appearance of a mark. When,
for example, a field is encoded by color, all data items with the same value for
that field are given the same color. When a detail channel encodes a field, all
data items with the same value are placed in the same group. See the
[Vega-Lite documentation](https://vega.github.io/vega-lite/docs/encoding.html#detail).

@docs detail
@docs dName
@docs dNominal
@docs dOrdinal
@docs dQuant
@docs dTemporal
@docs dGeo
@docs dMType
@docs dAggregate
@docs dBin
@docs dTimeUnit


## 5.9 Key Channel

Enables object constancy for transitions over dynamic data. When a visualization’s
data is updated (via the [Vega View API](https://vega.github.io/vega/docs/api/view/#data),
the key value will be used to match data elements to existing mark instances. See the
[Vega-Lite key channel documentation](https://vega.github.io/vega-lite/docs/encoding.html#key).

@docs key

@docs kName
@docs kMType
@docs kNominal
@docs kOrdinal
@docs kQuant
@docs kTemporal
@docs kGeo


## 5.10 Scaling

Used to specify how the encoding of a data field should be applied. See the
[Vega-Lite scale documentation](https://vega.github.io/vega-lite/docs/scale.html).

@docs scType
@docs scBooExpr


### 5.10.1 Scale Domain

Describes the data values that will be encoded.

@docs doNumExpr

@docs scDomain
@docs scDomainExpr
@docs categoricalDomainMap
@docs domainRangeMap
@docs doNums
@docs doMin
@docs doMid
@docs doMax
@docs doStrs
@docs doDts
@docs doDtsExpr
@docs doMinDt
@docs doMinDtExpr
@docs doMaxDt
@docs doMaxDtExpr
@docs doUnaggregated
@docs doUnionWith
@docs doSelection
@docs doSelectionChannel
@docs doSelectionField


### 5.10.2 Scale Range

Describes the values after data have been encoded (e.g. pixel positions or color values).

@docs raNumExpr

@docs scRange
@docs raExprs
@docs raName
@docs raNums
@docs raMin
@docs raMax
@docs raNumLists
@docs raStrs
@docs raField


### 5.10.3 Scaling Properties

@docs scScheme
@docs scSchemeExpr
@docs scAlign
@docs scPadding
@docs scPaddingInner
@docs scPaddingOuter
@docs scReverse
@docs scRound
@docs scClamp
@docs scInterpolate
@docs scNice
@docs scZero
@docs scBand
@docs scBinOrdinal
@docs scLinear
@docs scLog
@docs scSymLog
@docs scConstant
@docs scBase
@docs scOrdinal
@docs scPoint
@docs scPow
@docs scExponent
@docs scQuantile
@docs scQuantize
@docs scSqrt
@docs scThreshold
@docs scTime
@docs scUtc


#### Scaling Constants

@docs niTrue
@docs niFalse
@docs niMillisecond
@docs niSecond
@docs niMinute
@docs niHour
@docs niDay
@docs niWeek
@docs niMonth
@docs niYear
@docs niTickCount
@docs niInterval
@docs niExpr


### 5.10.4 Color Scaling

For color interpolation types, see the
[Vega-Lite continuous scale documentation](https://vega.github.io/vega-lite/docs/scale.html#continuous).

@docs cubeHelix
@docs cubeHelixLong
@docs hcl
@docs hclLong
@docs hsl
@docs hslLong
@docs lab
@docs rgb

---


# 6. View Composition

Views can be combined to create more complex multi-view displays. This may involve
layering views on top of each other (superposition) or laying them out in adjacent
spaces (juxtaposition using [repeatFlow](#repeatFlow), [repeat](#repeat),
[facetFlow](#facetFlow), [facet](#facet), [concat](#concat), [hConcat](#hConcat)
or [vConcat](#vConcat)). Where different views have potentially conflicting channels
(e.g. two position scales in a layered visualization) the rules for resolving them
can be defined with `resolve`. For details, see the
[Vega-Lite composition documentation](https://vega.github.io/vega-lite/docs/composition.html)

  - 6.1 [Resolution](#6-1-resolution)
  - 6.2 [Faceted Views](#6-2-faceted-views)

@docs layer
@docs concat
@docs columns
@docs hConcat
@docs vConcat
@docs align
@docs alignRC
@docs caAll
@docs caEach
@docs caNone
@docs bounds
@docs boFull
@docs boFlush
@docs spacing
@docs spacingRC
@docs center
@docs centerRC


## 6.1 Resolution

Controlling the (in)dependence between composed views. See the
[Vega-Lite resolve documentation](https://vega.github.io/vega-lite/docs/resolve.html).

@docs resolve
@docs resolution
@docs reShared
@docs reIndependent
@docs reAxis
@docs reLegend
@docs reScale
@docs chX
@docs chY
@docs chX2
@docs chY2
@docs chColor
@docs chOpacity
@docs chShape
@docs chSize
@docs chStrokeDash


## 6.2 Faceted Views

Small multiples each of which show subsets of the same dataset. The specification
determines which field should be used to determine subsets along with their spatial
arrangement. See the
[Vega-Lite facet documentation](https://vega.github.io/vega-lite/docs/facet.html)

@docs repeatFlow
@docs repeat
@docs rowFields
@docs columnFields
@docs layerFields
@docs facetFlow
@docs facet
@docs columnBy
@docs rowBy

@docs fName
@docs fNominal
@docs fOrdinal
@docs fQuant
@docs fTemporal
@docs fGeo
@docs fMType
@docs fAggregate
@docs fBin
@docs fSort
@docs fHeader
@docs fTimeUnit
@docs fAlign
@docs fCenter
@docs fSpacing

@docs asSpec
@docs specification
@docs arLayer
@docs arFlow
@docs arColumn
@docs arRow


### 6.2.1 Facet Headers

See
[Vega-Lite header documentation](https://vega.github.io/vega-lite/docs/header.html)

@docs hdNumExpr
@docs hdStrExpr


#### Header Labels

@docs hdLabelAngle
@docs hdLabelAlign
@docs hdLabelAnchor
@docs hdLabelBaseline
@docs hdLabelColor
@docs hdLabelExpr
@docs hdLabelFont
@docs hdLabelFontSize
@docs hdLabelFontStyle
@docs hdLabelFontWeight
@docs hdLabelLimit
@docs hdLabelLineHeight
@docs hdLabelOrient
@docs hdLabelPadding
@docs hdLabels


#### Header Title

@docs hdTitle
@docs hdTitleAlign
@docs hdTitleAnchor
@docs hdTitleAngle
@docs hdTitleBaseline
@docs hdTitleColor
@docs hdTitleFont
@docs hdTitleFontStyle
@docs hdTitleFontSize
@docs hdTitleFontWeight
@docs hdTitleLimit
@docs hdTitleLineHeight
@docs hdTitleOrient
@docs hdOrient
@docs hdTitlePadding


#### Header Formatting

@docs hdFormat
@docs hdFormatAsNum
@docs hdFormatAsTemporal
@docs hdFormatAsCustom

---


# 7. Parameters

Vega-Lite _parameters_ allow named objects whose values can change to persist within
a specification. In the case of simple variables, it is often easier to use Elm
directly to store persistent values. The main benefits of parameters are for storing
_interaction selections_ such as mouse selections or slider values. See the Vega-Lite
[parameter documentation](https://vega.github.io/vega-lite/docs/parameter.html) for
details.

  - 7.1 [Selection Parameters](#7-1-selection-parameters)
  - 7.2 [Selection Resolution](#7-2-selection-resolution)
  - 7.3 [Conditional Channel Encodings](#7-3-conditional-channel-encodings)

@docs params
@docs param
@docs paValue
@docs paValues
@docs paExpr


## 7.1 Selection Parameters

@docs paSelect
@docs sePoint
@docs seInterval
@docs seClear
@docs seEncodings
@docs seFields
@docs seNearest
@docs seOn
@docs seToggle
@docs tpFalse
@docs tpExpr
@docs tpShiftKey
@docs tpAltKey
@docs tpCtrlKey
@docs seTranslate
@docs seZoom


### Selection Bindings

@docs paBind
@docs paBindings
@docs paBindScales
@docs paBindLegend


### Input Elements

@docs ipRange
@docs ipCheckbox
@docs ipRadio
@docs ipSelect
@docs ipText
@docs ipNumber
@docs ipDate
@docs ipTime
@docs ipMonth
@docs ipWeek
@docs ipDateTimeLocal
@docs ipTel
@docs ipColor

@docs inDebounce
@docs inElement
@docs inOptions
@docs inDatumOptions
@docs inDataOptions
@docs inMin
@docs inMax
@docs inName
@docs inStep
@docs inPlaceholder

### Selection Marks

Customising the appearance of interval selection rectangles.

@docs seSelectionMark
@docs smFill
@docs smFillOpacity
@docs smStroke
@docs smStrokeDash
@docs smStrokeDashOffset
@docs smStrokeOpacity
@docs smStrokeWidth
@docs smCursor


## 7.2 Selection Resolution

Determines how selections are made across multiple views.
See the [Vega-lite resolve selection documentation](https://vega.github.io/vega-lite/docs/selection.html#resolve).

@docs seResolve
@docs seGlobal
@docs seUnion
@docs seIntersection


## 7.3 Conditional Channel Encodings

Channel encoding can be made conditional on a parameter value, therefore allowing
it to be the result of some interaction or data expression. It does this via
[mCondition](#mCondition) (and its 'o', 't' and 'h' variants). Mark appearance can
therefore depend on some properties such as whether a datum is null or whether it
has been interactively selected. The condition to test (predicate) is usually
specified either as a parameter with [prParam](#prParam) or an expression with
[prTest](#prTest).

@docs mCondition
@docs mConditions
@docs oCondition
@docs oConditions
@docs tCondition
@docs tConditions
@docs hCondition

@docs prParam
@docs prParamEmpty
@docs prTest
@docs bParam
@docs expr
@docs and
@docs or
@docs not

---


# 8. Top-Level Settings

These are in addition to the data and transform options described above. See the
[Vega-Lite top-level spec documentation](https://vega.github.io/vega-lite/docs/spec.html#top-level-specifications)

  - 8.1 [Title](#8-1-title)
  - 8.2 [View Background](#8-2-view-background)
  - 8.3 [Style Configuration](#8-3-style-configuration)

@docs name
@docs description
@docs height
@docs heightOfContainer
@docs width
@docs widthOfContainer
@docs widthStep
@docs heightStep
@docs padding
@docs paSize
@docs paSizeExpr
@docs paEdges
@docs paEdgesExpr
@docs autosize
@docs asContent
@docs asFit
@docs asFitX
@docs asFitY
@docs asNone
@docs asPad
@docs asPadding
@docs asResize
@docs background
@docs backgroundExpr


## 8.1 Title

Per-title settings. To standardize the appearance of all titles in a multi-view
specification, use [coTitle](#coTitle) instead.

@docs tiNumExpr
@docs tiStrExpr

@docs title
@docs titleExpr
@docs tiAnchor
@docs tiAngle
@docs tiBaseline
@docs tiColor
@docs tiDx
@docs tiDy
@docs tiFont
@docs tiFontSize
@docs tiFontStyle
@docs tiFontWeight
@docs tiLineHeight
@docs tiSubtitle
@docs tiSubtitleColor
@docs tiSubtitleFont
@docs tiSubtitleFontSize
@docs tiSubtitleFontStyle
@docs tiSubtitleFontWeight
@docs tiSubtitleLineHeight
@docs tiSubtitlePadding
@docs tiFrame
@docs tfBounds
@docs tfGroup
@docs tfExpr
@docs tiLimit
@docs tiOffset
@docs tiOrient
@docs tiStyle
@docs tiZIndex


## 8.2 View Background

The background of a single view in a view composition can be styled independently
of other views. For more details see the
[Vega-Lite view background documentation](https://vega.github.io/vega-lite/docs/spec.html#view-background)

@docs viewBackground
@docs vbNumExpr
@docs vbNumsExpr
@docs vbStrExpr

@docs viewStyle
@docs viewCornerRadius
@docs viewFill
@docs viewFillOpacity
@docs viewOpacity
@docs viewStroke
@docs viewStrokeCap
@docs viewStrokeDash
@docs viewStrokeDashOffset
@docs viewStrokeJoin
@docs viewStrokeMiterLimit
@docs viewStrokeOpacity
@docs viewStrokeWidth


## 8.3 Style Configuration

Allows default properties for most marks and guides to be set. See the
[Vega-Lite configuration documentation](https://vega.github.io/vega-lite/docs/config.html).

@docs configure
@docs configuration

@docs coArea
@docs coAria
@docs coAutosize
@docs coAxis
@docs coAxisXFilter
@docs coAxisYFilter
@docs axX
@docs axY
@docs coAxisLeft
@docs coAxisRight
@docs coAxisTop
@docs coAxisBottom
@docs coAxisBand
@docs coAxisDiscrete
@docs coAxisPoint
@docs coAxisQuant
@docs coAxisTemporal
@docs coAxisStyles
@docs coBackground
@docs coBar
@docs coCircle
@docs coConcat
@docs coCountTitle
@docs coCustomFormatTypes
@docs coFieldTitle
@docs coFont
@docs coGeoshape
@docs coFacet
@docs coHeader
@docs coLegend
@docs coLine
@docs coMark
@docs coMarkStyles
@docs coNumberFormat
@docs coPadding
@docs coPoint
@docs coProjection
@docs coRange
@docs coRect
@docs coRule
@docs coScale
@docs coSelection
@docs coSquare
@docs coText
@docs coTick
@docs coTitle
@docs coTimeFormat
@docs coTrail
@docs coView


### 8.3.1 Axis Configuration

See the
[Vega-Lite axis config documentation](https://vega.github.io/vega-lite/docs/axis.html#general-config).

@docs axcoAria
@docs axcoBandPosition
@docs axcoDisable
@docs axcoDomain
@docs axcoDomainDash
@docs axcoDomainDashOffset
@docs axcoDomainCap
@docs axcoDomainColor
@docs axcoDomainOpacity
@docs axcoDomainWidth
@docs axcoMaxExtent
@docs axcoMinExtent
@docs axcoTranslate
@docs axcoGrid
@docs axcoGridCap
@docs axcoGridColor
@docs axcoGridDash
@docs axcoGridDashOffset
@docs axcoGridOpacity
@docs axcoGridWidth
@docs axcoLabels
@docs axcoLabelAlign
@docs axcoLabelAngle
@docs axcoLabelBaseline
@docs axcoLabelBound
@docs axcoLabelColor
@docs axcoLabelExpr
@docs axcoLabelFlush
@docs axcoLabelFlushOffset
@docs axcoLabelFont
@docs axcoLabelFontSize
@docs axcoLabelFontStyle
@docs axcoLabelFontWeight
@docs axcoLabelLimit
@docs axcoLabelLineHeight
@docs axcoLabelOpacity
@docs axcoLabelOverlap
@docs axcoLabelPadding
@docs axcoLabelSeparation
@docs axcoTicks
@docs axcoTickBand
@docs axcoTickCap
@docs axcoTickColor
@docs axcoTickCount
@docs axcoTickDash
@docs axcoTickDashOffset
@docs axcoTickExtra
@docs axcoTickOffset
@docs axcoTickOpacity
@docs axcoTickRound
@docs axcoTickSize
@docs axcoTickMinStep
@docs axcoTickWidth
@docs axcoTitleAlign
@docs axcoTitleAnchor
@docs axcoTitleAngle
@docs axcoTitleBaseline
@docs axcoTitleColor
@docs axcoTitleFont
@docs axcoTitleFontSize
@docs axcoTitleFontStyle
@docs axcoTitleFontWeight
@docs axcoTitleLimit
@docs axcoTitleLineHeight
@docs axcoTitleOpacity
@docs axcoTitlePadding
@docs axcoTitleX
@docs axcoTitleY


## 8.3.2 Legend Configuration

See the
[Vega-Lite legend configuration documentation](https://vega.github.io/vega-lite/docs/legend.html#config).

@docs lecoAria
@docs lecoClipHeight
@docs lecoColumnPadding
@docs lecoColumns
@docs lecoCornerRadius
@docs lecoDisable
@docs lecoFillColor
@docs lecoOrient
@docs lecoOffset
@docs lecoStrokeColor
@docs lecoStrokeDash
@docs lecoStrokeWidth
@docs lecoPadding
@docs lecoRowPadding
@docs lecoGradientDirection
@docs lecoGradientLabelBaseline
@docs lecoGradientLabelLimit
@docs lecoGradientLabelOffset
@docs lecoGradientOpacity
@docs lecoGradientStrokeColor
@docs lecoGradientStrokeWidth
@docs lecoGradientHeight
@docs lecoGradientWidth
@docs lecoGridAlign
@docs lecoLabelAlign
@docs lecoLabelBaseline
@docs lecoLabelColor
@docs lecoLabelFont
@docs lecoLabelFontSize
@docs lecoLabelFontStyle
@docs lecoLabelFontWeight
@docs lecoLabelLimit
@docs lecoLabelOffset
@docs lecoLabelOverlap
@docs lecoEntryPadding
@docs lecoSymbolBaseFillColor
@docs lecoSymbolBaseStrokeColor
@docs lecoSymbolDash
@docs lecoSymbolDashOffset
@docs lecoSymbolDirection
@docs lecoSymbolFillColor
@docs lecoSymbolLimit
@docs lecoSymbolOffset
@docs lecoSymbolOpacity
@docs lecoSymbolSize
@docs lecoSymbolStrokeColor
@docs lecoSymbolStrokeWidth
@docs lecoSymbolType
@docs lecoTitleAlign
@docs lecoTitleAnchor
@docs lecoTitleBaseline
@docs lecoTitleColor
@docs lecoTitleFont
@docs lecoTitleFontSize
@docs lecoTitleFontStyle
@docs lecoTitleFontWeight
@docs lecoTitleLimit
@docs lecoTitleLineHeight
@docs lecoTitleOpacity
@docs lecoTitlePadding
@docs lecoUnselectedOpacity


### 8.3.3 Scale Configuration

See the
[Vega-Lite scale configuration documentation](https://vega.github.io/vega-lite/docs/scale.html#scale-config)

@docs sacoBandPaddingInner
@docs sacoBandPaddingOuter
@docs sacoBarBandPaddingInner
@docs sacoBarBandPaddingOuter
@docs sacoRectBandPaddingInner
@docs sacoRectBandPaddingOuter
@docs sacoClamp
@docs sacoMaxBandSize
@docs sacoMinBandSize
@docs sacoMaxFontSize
@docs sacoMinFontSize
@docs sacoMaxOpacity
@docs sacoMinOpacity
@docs sacoMaxSize
@docs sacoMinSize
@docs sacoMaxStrokeWidth
@docs sacoMinStrokeWidth
@docs sacoPointPadding
@docs sacoRound
@docs sacoUseUnaggregatedDomain
@docs sacoXReverse


### 8.3.4 Scale Range Configuration

See the
[Vega-Lite scheme configuration documentation](https://vega.github.io/vega/docs/schemes/#scheme-properties).

@docs racoCategory
@docs racoDiverging
@docs racoHeatmap
@docs racoOrdinal
@docs racoRamp
@docs racoSymbol


### 8.3.5 Title Configuration

Unlike [title](#title) title configuration applies to all titles if multiple views
are created. See the
[Vega-Lite title configuration documentation](https://vega.github.io/vega-lite/docs/title.html#config)

@docs ticoAnchor
@docs ticoAngle
@docs ticoBaseline
@docs ticoColor
@docs ticoDx
@docs ticoDy
@docs ticoFont
@docs ticoFontSize
@docs ticoFontStyle
@docs ticoFontWeight
@docs ticoLineHeight
@docs ticoSubtitleColor
@docs ticoSubtitleFont
@docs ticoSubtitleFontSize
@docs ticoSubtitleFontStyle
@docs ticoSubtitleFontWeight
@docs ticoSubtitleLineHeight
@docs ticoSubtitlePadding
@docs ticoFrame
@docs ticoLimit
@docs ticoOffset
@docs ticoOrient
@docs ticoStyle
@docs ticoZIndex


### 8.3.6 View Configuration

See the
[Vega-Lite view configuration documentation](https://vega.github.io/vega-lite/docs/spec.html#config)

@docs vicoBackground
@docs vicoContinuousWidth
@docs vicoContinuousHeight
@docs vicoCursor
@docs vicoDiscreteWidth
@docs vicoDiscreteHeight
@docs vicoClip
@docs vicoCornerRadius
@docs vicoFill
@docs vicoFillOpacity
@docs vicoOpacity
@docs vicoStep
@docs vicoStroke
@docs vicoStrokeCap
@docs vicoStrokeDash
@docs vicoStrokeDashOffset
@docs vicoStrokeJoin
@docs vicoStrokeMiterLimit
@docs vicoStrokeOpacity
@docs vicoStrokeWidth

@docs anStart
@docs anMiddle
@docs anEnd
@docs anExpr

@docs ftVerbal
@docs ftFunction
@docs ftPlain


### 8.3.7 Facet Configuration

See the
[Vega-Lite facet configuration documentation](https://vega.github.io/vega-lite/docs/facet.html#facet-configuration).

@docs facoColumns
@docs facoSpacing


### 8.3.8 Concatenated View Configuration

See the
[Vega-Lite concat configuration documentation](https://vega.github.io/vega-lite/docs/concat.html#concat-configuration).

@docs cocoColumns
@docs cocoSpacing

---


# 9. General Data Functions

In addition to more general data types like integers and strings, the following types
can carry data used in specifications and Vega-Lite parameters.

  - 9.1 [Temporal Data](#9-1-temporal-data)

@docs boo
@docs true
@docs false
@docs dt
@docs num
@docs str
@docs datumExpr
@docs dataExpr
@docs datumArray
@docs dataArrays
@docs dataObject
@docs dataObjects
@docs nullValue
@docs daConcat
@docs boos
@docs dts
@docs nums
@docs strs


## 9.1 Temporal Data

See the
[Vega-Lite dateTime documentation](https://vega.github.io/vega-lite/docs/types.html#datetime)
and the [Vega-Lite time unit documentation](https://vega.github.io/vega-lite/docs/timeunit.html).

@docs dtYear
@docs dtQuarter
@docs dtMonth
@docs dtMonthNum
@docs dtDate
@docs dtDay
@docs dtHour
@docs dtMinute
@docs dtSecond
@docs dtMillisecond
@docs MonthName
@docs DayName

@docs date
@docs dayOfYear
@docs day
@docs dayHours
@docs dayHoursMinutes
@docs dayHoursMinutesSeconds
@docs hours
@docs hoursMinutes
@docs hoursMinutesSeconds
@docs milliseconds
@docs minutes
@docs minutesSeconds
@docs month
@docs monthDate
@docs monthDateHours
@docs monthDateHoursMinutes
@docs monthDateHoursMinutesSeconds
@docs quarter
@docs quarterMonth
@docs seconds
@docs secondsMilliseconds
@docs week
@docs weekDay
@docs weekDayHours
@docs weekDayHoursMinutes
@docs weekDayHoursMinutesSeconds
@docs year
@docs yearQuarter
@docs yearQuarterMonth
@docs yearMonth
@docs yearMonthDate
@docs yearMonthDateHours
@docs yearMonthDateHoursMinutes
@docs yearMonthDateHoursMinutesSeconds
@docs yearWeek
@docs yearWeekDay
@docs yearWeekDayHours
@docs yearWeekDayHoursMinutes
@docs yearWeekDayHoursMinutesSeconds
@docs yearDayOfYear
@docs utc
@docs tuMaxBins
@docs tuStep

---


# 10. Type Reference

Types that are not specified directly, provided here for reference with links
to the functions that generate them.

@docs Anchor
@docs Aria
@docs Arrangement
@docs Autosize
@docs AxisProperty
@docs AxisChoice
@docs AxisConfig
@docs BinProperty
@docs BlendMode
@docs BooleanOp
@docs Bounds
@docs CInterpolate
@docs Channel
@docs ClipRect
@docs ColorGradient
@docs CompositionAlignment
@docs ConcatConfig
@docs ConditionalAxisProperty
@docs ConfigurationProperty
@docs Cursor
@docs DataType
@docs DataValue
@docs DataValues
@docs DateTime
@docs DensityProperty
@docs DetailChannel
@docs FacetChannel
@docs FacetConfig
@docs FacetMapping
@docs FieldTitleProperty
@docs Filter
@docs FilterRange
@docs Format
@docs Geometry
@docs GradientProperty
@docs GraticuleProperty
@docs HAlign
@docs HeaderProperty
@docs HyperlinkChannel
@docs ImMethod
@docs ImputeProperty
@docs InputProperty
@docs KeyChannel
@docs Legend
@docs LegendConfig
@docs LegendOrientation
@docs LegendProperty
@docs LineMarker
@docs LoessProperty
@docs LookupFields
@docs Mark
@docs MarkChannel
@docs MarkInterpolation
@docs MarkOrientation
@docs MarkProperty
@docs Operation
@docs OrderChannel
@docs OverlapStrategy
@docs Padding
@docs ParamProperty
@docs PBinding
@docs PivotProperty
@docs PointMarker
@docs PositionChannel
@docs Predicate
@docs Projection
@docs ProjectionProperty
@docs QuantileProperty
@docs RangeConfig
@docs RegressionMethod
@docs RegressionProperty
@docs RepeatFields
@docs Resolution
@docs Resolve
@docs Scale
@docs ScaleDomain
@docs ScaleNice
@docs ScaleProperty
@docs ScaleConfig
@docs ScaleRange
@docs Selection
@docs SelectionMarkProperty
@docs SelectionProperty
@docs SelectionResolution
@docs Side
@docs SortField
@docs SortProperty
@docs StackOffset
@docs StackProperty
@docs StrokeCap
@docs StrokeJoin
@docs SummaryExtent
@docs Symbol
@docs TextChannel
@docs TimeUnit
@docs TitleConfig
@docs TitleFrame
@docs TitleProperty
@docs TogglePredicate
@docs TooltipContent
@docs VAlign
@docs ViewBackground
@docs ViewConfig
@docs Window
@docs WOperation
@docs WindowProperty


# 11. Deprecated Types and Functions

@docs Binding
@docs BindLegendProperty
@docs blField
@docs blChannel
@docs blEvent
@docs hDataCondition
@docs hSelectionCondition
@docs iCheckbox
@docs iColor
@docs iDate
@docs iDateTimeLocal
@docs iMonth
@docs iNumber
@docs iRadio
@docs iRange
@docs iSelect
@docs iTel
@docs iText
@docs iTime
@docs iWeek
@docs lecoShortTimeLabels
@docs mDataCondition
@docs mSelectionCondition
@docs oDataCondition
@docs oSelectionCondition
@docs pBand
@docs scDomainMid
@docs seBind
@docs seBindLegend
@docs seBindScales
@docs seEmpty
@docs seInit
@docs seInitInterval
@docs select
@docs selected
@docs selection
@docs selectionName
@docs seMulti
@docs seSingle
@docs tDataCondition
@docs tSelectionCondition

-}

import Dict
import Json.Decode as JD
import Json.Encode as JE


{-| Generated by [anStart](#anStart), [anMiddle](#anMiddle), [anEnd](#anEnd) and
[anExpr](#anExpr).
-}
type Anchor
    = AnStart
    | AnMiddle
    | AnEnd
    | AnchorExpr String


{-| Generated by [arEnable](#arEnable), [arDisable](#arDisable), [arDescription](#arDescription)
and <arExpr>.
-}
type Aria
    = ArAria Bool
      -- TODO: Expose role/roleDescription if/when it is confirmed in the Vega-Lite spec.
      -- | AriaRole String
      -- | AriaRoleDescription
      -- | AriaExpression String
    | ArDescription String
    | ArExpr String


{-| Generated by [arFlow](#arFlow), [arColumn](#arColumn), [arRow](#arRow) and
[arLayer](#arLayer).
-}
type Arrangement
    = Column
    | Row
    | Flow
    | Layer


{-| Generated by [asContent](#asContent), [asFit](#asFit), [asFitX](#asFitX),
[asFitY](#asFitY), [asNone](#asNone), [asPad](#asPad), [asPadding](#asPadding)
and [asResize](#asResize).
-}
type Autosize
    = AContent
    | AFit
    | AFitX
    | AFitY
    | ANone
    | APad
    | APadding
    | AResize


{-| Generated by [axBoth](#axBoth), [axX](#axX) and [axY](#axY).
-}
type AxisChoice
    = AxBoth
    | AxX
    | AxY


{-| Generated by [axcoAria](#axcoAria), [axcoBandPosition](#axcoBandPosition),
[axcoDisable](#axcoDisable), [axcoDomain](#axcoDomain), [axcoDomainCap](#axcoDomainCap),
[axcoDomainColor](#axcoDomainColor), [axcoDomainDash](#axcoDomainDash),
[axcoDomainDashOffset](#axcoDomainDashOffset), [axcoDomainOpacity](#axcoDomainOpacity),
[axcoDomainWidth](#axcoDomainWidth), [axcoMaxExtent](#axcoMaxExtent), [axcoMinExtent](#axcoMinExtent),
[axcoGrid](#axcoGrid), [axcoGridCap](#axcoGridCap), [axcoGridColor](#axcoGridColor),
[axcoGridDash](#axcoGridDash), [axcoGridDashOffset](#axcoGridDashOffset),
[axcoGridOpacity](#axcoGridOpacity), [axcoGridWidth](#axcoGridWidth),
[axcoLabels](#axcoLabels), [axcoLabelAlign](#axcoLabelAlign), [axcoLabelAngle](#axcoLabelAngle),
[axcoLabelBaseline](#axcoLabelBaseline), [axcoLabelBound](#axcoLabelBound),
[axcoLabelColor](#axcoLabelColor), [axcoLabelExpr](#axcoLabelExpr), [axcoLabelFlush](#axcoLabelFlush),
[axcoLabelFlushOffset](#axcoLabelFlushOffset), [axcoLabelFont](#axcoLabelFont),
[axcoLabelFontSize](#axcoLabelFontSize), [axcoLabelFontStyle](#axcoLabelFontStyle),
[axcoLabelFontWeight](#axcoLabelFontWeight), [axcoLabelLimit](#axcoLabelLimit),
[axcoLabelLineHeight](#axcoLabelLineHeight), [axcoLabelOpacity](#axcoLabelOpacity),
[axcoLabelOverlap](#axcoLabelOverlap), [axcoLabelPadding](#axcoLabelPadding),
[axcoLabelSeparation](#axcoLabelSeparation), [axcoTicks](#axcoTicks), [axcoTickColor](#axcoTickColor),
[axcoTickCount](#axcoTickCount), [axcoGridDash](#axcoGridDash), [axcoGridDashOffset](#axcoGridDashOffset),
[axcoTickCap](#axcoTickCap), [axcoTickExtra](#axcoTickExtra), [axcoTickOffset](#axcoTickOffset),
[axcoTickOpacity](#axcoTickOpacity), [axcoTickRound](#axcoTickRound), [axcoTickSize](#axcoTickSize),
[axcoTickMinStep](#axcoTickMinStep), [axcoTickWidth](#axcoTickWidth), [axcoTitleAlign](#axcoTitleAlign),
[axcoTitleAnchor](#axcoTitleAnchor), [axcoTitleAngle](#axcoTitleAngle),
[axcoTitleBaseline](#axcoTitleBaseline), [axcoTitleColor](#axcoTitleColor),
[axcoTitleFont](#axcoTitleFont), [axcoTitleFontSize](#axcoTitleFontSize),
[axcoTitleFontStyle](#axcoTitleFontStyle), [axcoTitleFontWeight](#axcoTitleFontWeight),
[axcoTitleLimit](#axcoTitleLimit), [axcoTitleLineHeight](#axcoTitleLineHeight),
[axcoTitleOpacity](#axcoTitleOpacity), [axcoTitlePadding](#axcoTitlePadding),
[axcoTitleX](#axcoTitleX), [axcoTitleY](#axcoTitleY) and [axcoTranslate](#axcoTranslate).
-}
type AxisConfig
    = AxisAria (List Aria)
    | BandPosition Float
    | AxDisable Bool
    | Domain Bool
    | DomainCap StrokeCap
    | DomainColor String
    | DomainDash (List Float)
    | DomainDashOffset Float
    | DomainOpacity Float
    | DomainWidth Float
    | Grid Bool
    | GridCap StrokeCap
    | GridColor String
    | GridDash (List Float)
    | GridDashOffset Float
    | GridOpacity Float
    | GridWidth Float
    | Labels Bool
    | LabelAlign HAlign
    | LabelAngle Float
    | LabelBaseline VAlign
    | LabelBound (Maybe Float)
    | LabelFlush (Maybe Float)
    | LabelFlushOffset Float
    | LabelColor String
    | LabelExpr String
    | LabelFont String
    | LabelFontSize Float
    | LabelFontStyle String
    | LabelFontWeight FontWeight
    | LabelLimit Float
    | LabelLineHeight Float
    | LabelOpacity Float
    | LabelOverlap OverlapStrategy
    | LabelPadding Float
    | LabelSeparation Float
    | MaxExtent Float
    | MinExtent Float
    | Ticks Bool
    | TickBand TickBand
    | TickCap StrokeCap
    | TickColor String
    | TickCount ScaleNice
    | TickDash (List Float)
    | TickDashOffset Float
    | TickExtra Bool
    | TickOffset Float
    | TickOpacity Float
    | TickRound Bool
    | TickSize Float
    | TickMinStep Float
    | TickWidth Float
    | TitleAlign HAlign
    | TitleAnchor Anchor
    | TitleAngle Float
    | TitleBaseline VAlign
    | TitleColor String
    | TitleFont String
    | TitleFontSize Float
    | TitleFontStyle String
    | TitleFontWeight FontWeight
    | TitleLimit Float
    | TitleLineHeight Float
    | TitleOpacity Float
    | TitlePadding Float
    | TitleX Float
    | TitleY Float
    | TranslateAxis Float


{-| Generated by [axAria](#axAria), [axBandPosition](#axBandPosition),
[axMaxExtent](#axMaxExtent), [axMinExtent](#axMinExtent), [axOrient](#axOrient),
[axOffset](#axOffset), [axPosition](#axPosition), [axZIndex](#axZIndex),
[axDataCondition](#axDataCondition), [axDomain](#axDomain), [axDomainCap](#axDomainCap),
[axDomainColor](#axDomainColor), [axDomainDash](#axDomainDash),
[axDomainDashOffset](#axDomainDashOffset), [axDomainOpacity](#axDomainOpacity),
[axDomainWidth](#axDomainWidth), [axFormat](#axFormat), [axFormatAsNum](#axFormatAsNum),
[axFormatAsTemporal](#axFormatAsTemporal), [axFormatAsCustom](#axFormatAsCustom),
[axLabels](#axLabels), [axLabelAlign](#axLabelAlign), [axLabelAngle](#axLabelAngle),
[axLabelBaseline](#axLabelBaseline), [axLabelBound](#axLabelBound), [axLabelColor](#axLabelColor),
[axLabelExpr](#axLabelExpr), [axLabelFlush](#axLabelFlush), [axLabelFlushOffset](#axLabelFlushOffset),
[axLabelFont](#axLabelFont), [axLabelFontSize](#axLabelFontSize), [axLabelFontStyle](#axLabelFontStyle),
[axLabelFontWeight](#axLabelFontWeight), [axLabelLimit](#axLabelLimit),
[axLabelLineHeight](#axLabelLineHeight), [axLabelOffset](#axLabelOffset),
[axLabelOpacity](#axLabelOpacity), [axLabelOverlap](#axLabelOverlap), [axLabelPadding](#axLabelPadding),
[axLabelSeparation](#axLabelSeparation), [axStyle](#axStyle), [axTranslate](#axTranslate),
[axTicks](#axTicks), [axTickCap](#axTickCap), [axTickColor](#axTickColor), [axTickCount](#axTickCount),
[axTickDash](#axTickDash), [axTickDashOffset](#axTickDashOffset),
[axTickExtra](#axTickExtra), [axTickOffset](#axTickOffset), [axTickOpacity](#axTickOpacity),
[axTickRound](#axTickRound), [axTickSize](#axTickSize), [axTickMinStep](#axTickMinStep),
[axTickWidth](#axTickWidth), [axValues](#axValues), [axTitle](#axTitle), [axTitleAlign](#axTitleAlign),
[axTitleAnchor](#axTitleAnchor), [axTitleAngle](#axTitleAngle), [axTitleBaseline](#axTitleBaseline),
[axTitleColor](#axTitleColor), [axTitleFont](#axTitleFont), [axTitleFontSize](#axTitleFontSize),
[axTitleFontStyle](#axTitleFontStyle), [axTitleFontWeight](#axTitleFontWeight),
[axTitleLimit](#axTitleLimit), [axTitleLineHeight](#axTitleLineHeight), [axTitleOpacity](#axTitleOpacity),
[axTitlePadding](#axTitlePadding), [axTitleX](#axTitleX), [axTitleY](#axTitleY),
[axGrid](#axGrid), [axGridCap](#axGridCap), [axGridColor](#axGridColor), [axGridDash](#axGridDash),
[axGridDashOffset](#axGridDashOffset), [axGridOpacity](#axGridOpacity)
and [axGridWidth](#axGridWidth).
-}
type AxisProperty
    = AxAria (List Aria)
    | AxBandPosition Num
    | AxMaxExtent Num
    | AxMinExtent Num
    | AxOrient Side
    | AxOffset Num
    | AxPosition Num
    | AxZIndex Num
    | AxDomain Boo
    | AxDomainCap StrokeCap
    | AxDomainColor Str
    | AxDomainDash Nums
    | AxDomainDashOffset Num
    | AxDomainOpacity Num
    | AxDomainWidth Num
    | AxFormat Str
    | AxFormatAsNum
    | AxFormatAsTemporal
    | AxFormatAsCustom Str
    | AxLabels Boo
    | AxLabelAlign HAlign
    | AxLabelAngle Num
    | AxLabelBaseline VAlign
    | AxLabelBound MaybeNum
    | AxLabelColor Str
    | AxLabelExpr Str
    | AxLabelFlush (Maybe Float)
    | AxLabelFlushOffset Num
    | AxLabelFont Str
    | AxLabelFontSize Num
    | AxLabelFontStyle Str
    | AxLabelFontWeight FontWeight
    | AxLabelLineHeight Num
    | AxLabelLimit Num
    | AxLabelOffset Num
    | AxLabelOpacity Num
    | AxLabelOverlap OverlapStrategy
    | AxLabelPadding Num
    | AxLabelSeparation Num
    | AxStyle (List String)
    | AxTranslate Num
    | AxTickBand TickBand
    | AxTickCap StrokeCap
    | AxTickColor Str
    | AxTickCount ScaleNice
    | AxTickDash Nums
    | AxTickDashOffset Num
    | AxTickExtra Boo
    | AxTickOffset Num
    | AxTickOpacity Num
    | AxTickRound Boo
    | AxTicks Boo
    | AxTickSize Num
    | AxTickWidth Num
    | AxValues DataValues
    | AxTitle Str
    | AxTitleAlign HAlign
    | AxTitleAnchor Anchor
    | AxTitleAngle Num
    | AxTitleBaseline VAlign
    | AxTitleColor Str
    | AxTitleFont Str
    | AxTitleFontSize Num
    | AxTitleFontStyle Str
    | AxTitleFontWeight FontWeight
    | AxTitleLimit Num
    | AxTitleLineHeight Num
    | AxTitleOpacity Num
    | AxTitlePadding Num
    | AxTitleX Num
    | AxTitleY Num
    | AxGrid Boo
    | AxGridCap StrokeCap
    | AxGridColor Str
    | AxGridDash Nums
    | AxGridDashOffset Num
    | AxGridOpacity Num
    | AxGridWidth Num
    | AxTickMinStep Num
    | AxDataCondition BooleanOp ConditionalAxisProperty


{-| Deprecated in favour of [PBinding](#PBinding).
-}
type Binding
    = IRange String (List InputProperty)
    | ICheckbox String (List InputProperty)
    | IRadio String (List InputProperty)
    | ISelect String (List InputProperty)
    | IText String (List InputProperty)
    | INumber String (List InputProperty)
    | IDate String (List InputProperty)
    | ITime String (List InputProperty)
    | IMonth String (List InputProperty)
    | IWeek String (List InputProperty)
    | IDateTimeLocal String (List InputProperty)
    | ITel String (List InputProperty)
    | IColor String (List InputProperty)


{-| Deprecated in favour of binding properties set via [param](#param).
-}
type BindLegendProperty
    = BLField String
    | BLChannel Channel
    | BLEvent String


{-| Generated by [biAnchor](#biAnchor), [biBase](#biBase), [biDivide](#biDivide),
[biExtent](#biExtent),[biSelectionExtent](#biSelectionExtent), [biMaxBins](#biMaxBins),
[biMinStep](#biMinStep), [biNice](#biNice), [biStep](#biStep) and [biSteps](#biSteps).
-}
type BinProperty
    = BiAnchor Float
    | Base Float
    | Divides (List Float)
    | Extent Float Float
    | SelectionExtent String
    | MaxBins Int
    | MinStep Float
    | Nice Bool
    | Step Float
    | Steps (List Float)


{-| Generated by [bmNormal](#bmNormal), [bmMultiply](#bmMultiply), [bmScreen](#bmScreen),
[bmOverlay](#bmOverlay), [bmDarken](#bmDarken), [bmLighten](#bmLighten), [bmColorDodge](#bmColorDodge),
[bmColorBurn](#bmColorBurn), [bmHardLight](#bmHardLight), [bmSoftLight](#bmSoftLight),
[bmDifference](#bmDifference), [bmExclusion](#bmExclusion), [bmHue](#bmHue),
[bmSaturation](#bmSaturation), [bmColor](#bmColor), [bmLuminosity](#bmLuminosity)
and [bmExpr](#bmExpr).
-}
type BlendMode
    = BMNormal
    | BMMultiply
    | BMScreen
    | BMOverlay
    | BMDarken
    | BMLighten
    | BMColorDodge
    | BMColorBurn
    | BMHardLight
    | BMSoftLight
    | BMDifference
    | BMExclusion
    | BMHue
    | BMSaturation
    | BMColor
    | BMLuminosity
    | BMExpr String


{-| Generated by [expr](#expr), [fiOp](#fiOp), [fiOpTrans](#fiOpTrans),[bParam](#bParam),
[and](#and),[or](#or) and [not](#not).
-}
type BooleanOp
    = Expr String
    | FilterOp Filter
    | FilterOpTrans MarkChannel Filter
    | BooleanParam String
    | And BooleanOp BooleanOp
    | Or BooleanOp BooleanOp
    | Not BooleanOp
    | Selection String
    | SelectionName String


{-| Generated by [boFull](#boFull) and [boFlush](#boFlush).
-}
type Bounds
    = Full
    | Flush


{-| Generated by [chX](#chX), [chY](#chY), [chX2](#chX2), [chY2](#chY2),
[chColor](#chColor), [chOpacity](#chOpacity), [chShape](#chShape),
[chStrokeDash](#chStrokeDash) and [chSize](#chSize).
-}
type Channel
    = ChX
    | ChY
    | ChX2
    | ChY2
    | ChColor
    | ChOpacity
    | ChShape
    | ChSize
    | ChStrokeDash


{-| Generated by [cubeHelix](#cubeHelix), [cubeHelixLong](#cubeHelixLong), [hcl](#hcl),
[hclLong](#hclLong), [hsl](#hsl), [hslLong](#hslLong), [lab](#lab) and [rgb](#rgb).
-}
type CInterpolate
    = CubeHelix Float
    | CubeHelixLong Float
    | Hcl
    | HclLong
    | Hsl
    | HslLong
    | Lab
    | Rgb Float


{-| Generated by [noClip](#noClip), [clipRect](#clipRect) and [clipRectExpr](#clipRectExpr).
-}
type ClipRect
    = NoClip
    | LTRB Float Float Float Float
    | ClipRectExpr String String String String


{-| Generated by [grLinear](#grLinear) and [grRadial](#grRadial).
-}
type ColorGradient
    = GrLinear
    | GrRadial


{-| Generated by [caNone](#caNone), [caEach](#caEach) and [caAll](#caAll).
-}
type CompositionAlignment
    = CANone
    | CAEach
    | CAAll


{-| Generated by [cocoColumns](#cocoColumns) and [cocoSpacing](#cocoSpacing).
-}
type ConcatConfig
    = CoColumns Int
    | CoSpacing Float


{-| Generated by [cAxLabelAlign](#cAxLabelAlign), [cAxLabelBaseline](#cAxLabelBaseline),
[cAxLabelColor](#cAxLabelColor), [cAxLabelFont](#cAxLabelFont), [cAxLabelFontSize](#cAxLabelFontSize),
[cAxLabelFontStyle](#cAxLabelFontStyle), [cAxLabelFontWeight](#cAxLabelFontWeight),
[cAxLabelOffset](#cAxLabelOffset), [cAxLabelOpacity](#cAxLabelOpacity),
[cAxLabelPadding](#cAxLabelPadding), [cAxTickColor](#cAxTickColor), [cAxTickDash](#cAxTickDash),
[cAxTickDashOffset](#cAxTickDashOffset), [cAxTickOpacity](#cAxOpacity),
[cAxTickSize](#cAxTickSize), [cAxTickWidth](#cAxTickWidth), [cAxGridColor](#cAxGridColor),
[cAxGridDash](#cAxGridDash), [cAxTickDashOffset](#cAxTickDashOffset),
[cAxGridOpacity](#cAxGridOpacity) and [cAxGridWidth](#cAxGridWidth).
-}
type ConditionalAxisProperty
    = CAxLabelAlign HAlign HAlign
    | CAxLabelBaseline VAlign VAlign
    | CAxLabelColor String String
    | CAxLabelFont String String
    | CAxLabelFontSize Float Float
    | CAxLabelFontStyle String String
    | CAxLabelFontWeight FontWeight FontWeight
    | CAxLabelOffset Float Float
    | CAxLabelOpacity Float Float
    | CAxLabelPadding Float Float
    | CAxTickColor String String
    | CAxTickDash (List Float) (List Float)
    | CAxTickDashOffset Float Float
    | CAxTickOpacity Float Float
    | CAxTickWidth Float Float
    | CAxGridColor String String
    | CAxGridDash (List Float) (List Float)
    | CAxGridDashOffset Float Float
    | CAxGridOpacity Float Float
    | CAxTickSize Float Float
    | CAxGridWidth Float Float


{-| Generated by [coArea](#coArea),[coAria](#coAria), [coAutosize](#coAutosize),
[coAxis](#coAxis), [coAxisStyles](#coAxisStyles), [coAxisXFilter](#coAxisXFilter),
[coAxisYFilter](#coAxisYFilter), [coAxisLeft](#coAxisLeft), [coAxisRight](#coAxisRight),
[coAxisTop](#coAxisTop), [coAxisBottom](#coAxisBottom), [coAxisBand](#coAxisBand),
[coAxisDiscrete](#coAxisDiscrete), [coAxisPoint](#coAxisPoint),
[coAxisTemporal](#coAxisTemporal), [coAxisQuant](#coAxisQuant), [coBackground](#coBackground),
[coBar](#coBar), [coCircle](#coCircle), [coConcat](#coConcat), [coCountTitle](#coCountTitle),
[coCustomFormatTypes](#coCustomFormatTypes), [coFieldTitle](#coFieldTitle),
[coGeoshape](#coGeoshape), [coFacet](#coFacet), [coHeader](#coHeader), [coLegend](#coLegend),
[coLine](#coLine), [coMark](#coMark), [coMarkStyles](#coMarkStyles),
[coNumberFormat](#coNumberFormat), [coPadding](#coPadding), [coPoint](#coPoint),
[coProjection](#coProjection), [coRange](#coRange), [coRect](#coRect), [coRule](#coRule),
[coScale](#coScale), [coSelection](#coSelection), [coSquare](#coSquare), [coText](#coText),
[coFont](#coFont), [coTick](#coTick), [coTitle](#coTitle), [coTimeFormat](#coTimeFormat),
[coTrail](#coTrail) and [coView](#coView).
-}
type ConfigurationProperty
    = AreaStyle (List MarkProperty)
    | Aria Bool
    | Autosize (List Autosize)
    | Axis AxisChoice (List AxisConfig)
    | AxisStyles (List ( String, List AxisProperty ))
    | AxisLeft (List AxisConfig)
    | AxisRight (List AxisConfig)
    | AxisTop (List AxisConfig)
    | AxisBottom (List AxisConfig)
    | AxisBand AxisChoice (List AxisConfig)
    | AxisDiscrete AxisChoice (List AxisConfig)
    | AxisPoint AxisChoice (List AxisConfig)
    | AxisQuant AxisChoice (List AxisConfig)
    | AxisTemporal AxisChoice (List AxisConfig)
    | Background String
    | BarStyle (List MarkProperty)
    | CircleStyle (List MarkProperty)
    | ConcatStyle (List ConcatConfig)
    | CountTitle String
    | CustomFormatTypes Bool
    | FieldTitle FieldTitleProperty
    | Font String
    | GeoshapeStyle (List MarkProperty)
    | Legend (List LegendConfig)
    | LineStyle (List MarkProperty)
    | FacetStyle (List FacetConfig)
    | HeaderStyle (List HeaderProperty)
    | MarkStyle (List MarkProperty)
    | MarkStyles (List ( String, List MarkProperty ))
    | NumberFormat String
    | Padding Padding
    | PointStyle (List MarkProperty)
    | Projection (List ProjectionProperty)
    | Range (List RangeConfig)
    | RectStyle (List MarkProperty)
    | RuleStyle (List MarkProperty)
    | Scale (List ScaleConfig)
    | SelectionStyle (List ( Selection, List SelectionProperty ))
    | SquareStyle (List MarkProperty)
    | TextStyle (List MarkProperty)
    | TickStyle (List MarkProperty)
    | TitleStyle (List TitleConfig)
    | TimeFormat String
      -- Note: Trails appear unusual in having their own top-level config
      -- (see https://vega.github.io/vega-lite/docs/trail.html#config)
    | TrailStyle (List MarkProperty)
    | View (List ViewConfig)


{-| Generated by [cuAuto](#cuAuto), [cuDefault](#cuDefault), [cuNone](#cuNone),
[cuContextMenu](#cuContextMenu), [cuHelp](#cuHelp), [cuPointer](#cuPointer),
[cuProgress](#cuProgress), [cuWait](#cuWait), [cuCell](#cuCell), [cuCrosshair](#cuCrosshair),
[cuText](#cuText), [cuVerticalText](#cuVerticalText), [cuAlias](#cuAlias),
[cuCopy](#cuCopy), [cuMove](#cuMove), [cuNoDrop](#cuNoDrop), [cuNotAllowed](#cuNotAllowed),
[cuAllScroll](#cuAllScroll), [cuColResize](#cuColResize), [cuRowResize](#cuRowResize),
[cuNResize](#cuNResize), [cuEResize](#cuEResize), [cuSResize](#cuSResize),
[cuWResize](#cuWResize), [cuNEResize](#cuNEResize), [cuNWResize](#cuNWResize),
[cuSEResize](#cuSEResize), [cuSWResize](#cuSWResize), [cuEWResize](#cuEWResize),
[cuNSResize](#cuNSResize), [cuNESWResize](#cuNESWResize), [cuNWSEResize](#cuNWSEResize),
[cuZoomIn](#cuZoomIn), [cuZoomOut](#cuZoomOut), [cuGrab](#cuGrab), [cuGrabbing](#cuGrabbing)
and [cuExpr](#cuExpr).
-}
type Cursor
    = CAuto
    | CDefault
    | CNone
    | CContextMenu
    | CHelp
    | CPointer
    | CProgress
    | CWait
    | CCell
    | CCrosshair
    | CText
    | CVerticalText
    | CAlias
    | CCopy
    | CMove
    | CNoDrop
    | CNotAllowed
    | CAllScroll
    | CColResize
    | CRowResize
    | CNResize
    | CEResize
    | CSResize
    | CWResize
    | CNEResize
    | CNWResize
    | CSEResize
    | CSWResize
    | CEWResize
    | CNSResize
    | CNESWResize
    | CNWSEResize
    | CZoomIn
    | CZoomOut
    | CGrab
    | CGrabbing
    | CursorExpr String


{-| Convenience type annotation label for use with data generation functions.

    myRegion : List DataColumn -> Data
    myRegion =
        dataFromColumns []
            << dataColumn "easting" (nums [ -3, 4, 4, -3, -3 ])
            << dataColumn "northing" (nums [ 52, 52, 45, 45, 52 ])

-}
type alias Data =
    ( VLProperty, Spec )


{-| A single column of data. Used when generating inline data with [dataColumn](#dataColumn).
-}
type alias DataColumn =
    List LabelledSpec


{-| A single row of data. Used when generating inline data with [dataRow](#dataRow).
-}
type alias DataRow =
    Spec


{-| Generated by [foBoo](#foBoo), [foNum](#foNum), [foDate](#foDate) and [foUtc](#foUtc).
-}
type DataType
    = FoNum
    | FoBoo
    | FoDate String
    | FoUtc String


{-| Generated by [boo](#boo), [true](#true), [false](#false), [dt](#dt),
[num](#num), [str](#str), [datumExpr](#datumExpr), [daConcat](#daConcat),
[dataObject](#dataObject), [datumArray](#datumArray) and [nullValue](#nullValue).
-}
type DataValue
    = Boolean Bool
    | DateTime (List DateTime)
    | Number Float
    | DStr String
    | DExpr String
    | NullValue
    | DConcat DataValues
    | DObject (List ( String, DataValue ))
    | DArray (List DataValue)


{-| Generated by [boos](#boos), [dts](#dts), [nums](#nums), [strs](#strs),
[dataExpr](#dataExpr), [dataArrays](#dataArrays) and [dataObjects](#dataObjects).
-}
type DataValues
    = Booleans (List Bool)
    | DateTimes (List (List DateTime))
    | Numbers (List Float)
    | DExprs String
    | Strings (List String)
    | DObjects (List (List ( String, DataValue )))
    | DArrays (List DataValues)


{-| Generated by [dtYear](#dtYear), [dtQuarter](#dtQuarter), [dtMonth](#dtMonth),
[dtMonthNum](#dtMonthNum), [dtDate](#DTDate), [dtDay](#dtDay), [dtHour](#dtHour),
[dtMinute](#dtMinute), [dtSecond](#dtSecond) and [dtMillisecond](#dtMillisecond).
-}
type DateTime
    = DTYear Int
    | DTQuarter Int
    | DTMonth MonthName
    | DTMonthNum Int
    | DTDate Int
    | DTDay DayName
    | DTHours Int
    | DTMinutes Int
    | DTSeconds Int
    | DTMilliseconds Int


{-| Day of the week.
-}
type DayName
    = Mon
    | Tue
    | Wed
    | Thu
    | Fri
    | Sat
    | Sun


{-| Generated by [dnGroupBy](#dnGroupBy), [dnCumulative](#dnCumulative),
[dnCounts](#dnCounts), [dnBandwidth](#dnBandwidth), [dnExtent](#dnExtent),
[dnMinSteps](#dnMinSteps), [dnMaxSteps](#dnMaxSteps), [dnSteps](#dnSteps) and
[dnAs](#dnAs).
-}
type DensityProperty
    = DnGroupBy (List String)
    | DnCumulative Bool
    | DnCounts Bool
    | DnBandwidth Float
    | DnExtent Float Float
    | DnMinSteps Int
    | DnMaxSteps Int
    | DnSteps Int
    | DnAs String String


{-| Generated by [dName](#dName), [dQuant](#dQuant), [dNominal](#dNominal),
[dOrdinal](#dOrdinal), [dTemporal](#dTemporal), [dGeo](#dGeo), [dMType](#dMType),
[dAggregate](#dAggregate), [dBin](#dBin) and [dTimeUnit](#dTimeUnit).
-}
type DetailChannel
    = DName String
    | DmType Measurement
    | DBin (List BinProperty)
    | DTimeUnit TimeUnit
    | DAggregate Operation



-- {-| Interaction events to support selection. See the
-- [Vega documentation](https://vega.github.io/vega/docs/event-streams).
-- -}
-- type Event
--     = Click
--     | DblClick
--     | DragEnter
--     | DragLeave
--     | DragOver
--     | KeyDown
--     | KeyPress
--     | KeyUp
--     | MouseDown
--     | MouseMove
--     | MouseOut
--     | MouseOver
--     | MouseUp
--     | MouseWheel
--     | TouchEnd
--     | TouchMove
--     | TouchStart
--     | Wheel


{-| Generated by [fName](#fName), [fQuant](#fQuant), [fNominal](#fNominal),
[fOrdinal](#fOrdinal), [fTemporal](#fTemporal), [fGeo](#fGeo), [fMType](#fMType),
[fAggregate](#fAggregate), [fBin](#fBin), [fSort](#fSort), [fHeader](#fHeader),
[fTimeUnit](#fTimeUnit), [fAlign](#fAlign), [fCenter](#fCenter) and [fSpacing](#fSpacing).
-}
type FacetChannel
    = FName String
    | FmType Measurement
    | FBin (List BinProperty)
    | FAggregate Operation
    | FTimeUnit TimeUnit
    | FSort (List SortProperty)
    | FHeader (List HeaderProperty)
    | FAlign CompositionAlignment
    | FCenter Bool
    | FSpacing Float


{-| Generated by [facoColumns](#facoColumns) and [facoSpacing](#facoSpacing).
-}
type FacetConfig
    = FCColumns Int
    | FCSpacing Float


{-| Generated by [columnBy](#columnBy) and [rowBy](#rowBy).
-}
type FacetMapping
    = ColumnBy (List FacetChannel)
    | RowBy (List FacetChannel)


{-| Generated by [ftVerbal](#ftVerbal), [ftFunction](#ftFunction) and [ftPlain](#ftPlain).
-}
type FieldTitleProperty
    = FTVerbal
    | FTFunction
    | FTPlain


{-| Generated by [fiEqual](#fiEqual), [fiLessThan](#fiLessThan),
[fiLessThanEq](#fiLessThanEq), [fiGreaterThan](#fiEqGreaterThan),
[fiGreaterThanEq](#fiGreaterThanEq), [fiExpr](#fiExpr), [fiCompose](#fiCompose),
[fiSelection](#fiSelection), [fiSelectionEmpty](#fiSelectionEmpty),
[fiOneOf](#fiOneOf), [fiRange](#fiRange) and [fiValid](#fiValid).
-}
type Filter
    = FEqual String DataValue
    | FLessThan String DataValue
    | FLessThanEq String DataValue
    | FGreaterThan String DataValue
    | FGreaterThanEq String DataValue
    | FExpr String
    | FCompose BooleanOp
    | FSelection String
    | FSelectionEmpty String
    | FOneOf String DataValues
    | FRange String FilterRange
    | FValid String


{-| Generated by [numRange](#numRange) and [dtRange](#dtRange).
-}
type FilterRange
    = NumberRange Float Float
    | DateRange Timestamp Timestamp


{-| Generated by [fwBold](#fwBold), [fwBolder](#fwBolder), [fwLighter](#fwLighter),
[fwNormal](#fwNormal), [fw](#fw) and [fwExpr](#fwExpr).
-}
type FontWeight
    = Bold
    | Bolder
    | Lighter
    | Normal
    | W100
    | W200
    | W300
    | W400
    | W500
    | W600
    | W700
    | W800
    | W900
    | FWExpr String


{-| Generated by [csv](#csv), [dsv](#dsv), [tsv](#tsv), [arrow](#arrow), [parse](#parse),
[jsonProperty](#jsonProperty), [topojsonFeature](#topojsonFeature) and
[topojsonMesh](#topojsonMesh).
-}
type Format
    = JSON String
    | CSV
    | TSV
    | DSV Char
    | Arrow
    | TopojsonFeature String
    | TopojsonMesh String
    | Parse (List ( String, DataType ))


{-| Generated by [geoPoint](#geoPoint), [geoPoints](#geoPoints),
[geoLine](#geoLine), [geoLines](#geoLines), [geoPolygon](#geoPolygon) and
[geoPolygons](#geoPolygons).
-}
type Geometry
    = GeoPoint Float Float
    | GeoPoints (List ( Float, Float ))
    | GeoLine (List ( Float, Float ))
    | GeoLines (List (List ( Float, Float )))
    | GeoPolygon (List (List ( Float, Float )))
    | GeoPolygons (List (List (List ( Float, Float ))))


{-| Generated by [grX1](#grX1), [grY1](#grY1), [grX2](#grX2), [grY2](#grY2),
[grR1](#grR1), [grR2](#grR2) and [grStops](#grStops).
-}
type GradientProperty
    = GrX1 Float
    | GrY1 Float
    | GrX2 Float
    | GrY2 Float
    | GrR1 Float
    | GrR2 Float
    | GrStops (List ( Float, String ))


{-| Generated by [grExtent](#grExtent), [grExtentMajor](#grExtentMajor),
[grExtentMinor](#grExtentMinor), [grStep](#grStep), [grExtentMajor](#grExtentMajor),
[grExtentMinor](#grExtentMinor) and [grPrecision](#grPrecision).
-}
type GraticuleProperty
    = GrExtent ( Float, Float ) ( Float, Float )
    | GrExtentMajor ( Float, Float ) ( Float, Float )
    | GrExtentMinor ( Float, Float ) ( Float, Float )
    | GrStep ( Float, Float )
    | GrStepMajor ( Float, Float )
    | GrStepMinor ( Float, Float )
    | GrPrecision Float


{-| Generated by [haLeft](#haLeft), [haCenter](#haCenter), [haRight](#haRight)
and [haExpr](#haExpr).
-}
type HAlign
    = HAlignCenter
    | HAlignLeft
    | HAlignRight
    | HAlignExpr String


{-| Generated by [hdFormat](#hdFormat), [hdFormatAsNum](#hdFormatAsNum),
[hdFormatAsTemporal](#hdFormatAsTemporal), [hdFormatAsCustom](#hdFormatAsCustom),
[hdLabelAlign](#hdLabelAlign), [hdLabelAnchor](#hdLabelAnchor), [hdLabelAngle](#hdLabelAngle),
[hdLabelBaseline](#hdLabelBaseline), [hdLabelColor](#hdLabelColor), [hdLabelExpr](#hdLabelExpr),
[hdLabelFont](#hdLabelFont), [hdLabelFontSize](#hdLabelFontSize), [hdLabelFontStyle](#hdLabelFontStyle),
[hdLabelFontWeight](#hdLabelFontWeight), [hdLabelLimit](#hdLabelLimit), [hdLabelLineHeight](#hdLabelLineHeight),
[hdLabelOrient](#hdLabelOrient), [hdLabelPadding](#hdLabelPadding), [hdLabels](#hdLabels),
[hdOrient](#hdOrient), [hdTitle](#hdTitle), [hdTitleAlign](#hdTitleAlign), [hdTitleAnchor](#hdTitleAnchor),
[hdTitleAngle](#hdTitleAngle), [hdTitleBaseline](#hdTitleBaseline), [hdTitleColor](#hdTitleColor),
[hdTitleFont](#hdTitleFont), [hdTitleFontWeight](#hdTitleFontWeight), [hdTitleFontSize](#hdTitleFontSize),
[hdTitleFontStyle](#hdTitleFontStyle), [hdTitleLimit](#hdTitleLimit), [hdTitleOrient](#hdTitleOrient)
and [hdTitlePadding](#hdTitlePadding).
-}
type HeaderProperty
    = HFormat String
    | HFormatAsNum
    | HFormatAsTemporal
    | HFormatAsCustom String
    | HTitle String
    | HLabelAlign HAlign
    | HLabelAnchor Anchor
    | HLabelAngle Num
    | HLabelBaseline VAlign
    | HLabelColor Str
    | HLabelExpr String
    | HLabelFont Str
    | HLabelFontSize Num
    | HLabelFontStyle Str
    | HLabelFontWeight FontWeight
    | HLabelLimit Num
    | HLabelLineHeight Num
    | HLabelOrient Side
    | HLabelPadding Num
    | HLabels Bool
    | HOrient Side
    | HTitleAlign HAlign
    | HTitleAnchor Anchor
    | HTitleAngle Num
    | HTitleBaseline VAlign
    | HTitleColor Str
    | HTitleFont Str
    | HTitleFontSize Num
    | HTitleFontStyle Str
    | HTitleFontWeight FontWeight
    | HTitleLimit Num
    | HTitleLineHeight Num
    | HTitleOrient Side
    | HTitlePadding Num


{-| Generated by [hName](#hName), [hRepeat](#hRepeat), [hQuant](#hQuant),
[hNominal](#hNominal), [hOrdinal](#hOrdinal), [hTemporal](#hTemporal), [hGeo](#hGeo),
[hMType](#hMType), [hBin](#hBin), [hBinned](#hBinned), [hAggregate](#hAggregate),
[hTimeUnit](#hTimeUnit), [hCondition](#hCondition) and [hStr](#hStr).
-}
type HyperlinkChannel
    = HName String
    | HRepeat Arrangement
    | HmType Measurement
    | HBin (List BinProperty)
    | HBinned
    | HAggregate Operation
    | HTimeUnit TimeUnit
    | HCondition Predicate (List HyperlinkChannel) (List HyperlinkChannel)
    | HString String
    | HDataCondition Bool BooleanOp (List HyperlinkChannel) (List HyperlinkChannel)


{-| Generated by [imValue](#imValue), [imMean](#imMean), [imMedian](#imMedian),
[imMax](#imMax) and [imMin](#imMin).
-}
type ImMethod
    = ImValue
    | ImMean
    | ImMedian
    | ImMax
    | ImMin


{-| Generated by [imKeyVals](#imKeyVals), [imKeyValSequence](#imKeyValSequence)
[imFrame](#imFrame), [imGroupBy](#imGroupBy), [imMethod](#imMethod) and [imNewValue](#imNewValue).
-}
type ImputeProperty
    = ImFrame (Maybe Int) (Maybe Int)
    | ImKeyVals DataValues
    | ImKeyValSequence Float Float Float
    | ImMethod ImMethod
    | ImGroupBy (List String)
    | ImNewValue DataValue


{-| Generated by [inDebounce](#inDebounce), [inElement](#inElement),
[inOptions](#inOptions), [inDatumOptions](#inDatumOptions), [inDataOptions](#inDataOptions),
[inMin](#inMin), [inMax](#inMax), [inName](#inName), [inStep](#inStep) and
[inPlaceholder](#inPlaceholder).
-}
type InputProperty
    = Debounce Float
    | Element String
    | InOptions (List String)
    | InDatumOptions (List DataValue)
    | InDataOptions (List DataValues)
    | InMin Float
    | InMax Float
    | InName String
    | InStep Float
    | InPlaceholder String


{-| Generated by [kName](#kName) and [kMType](#kMType).
-}
type KeyChannel
    = KName String
    | KmType Measurement


{-| A named Vega-Lite specification, usually generated by an elm-vega
function. You shouldn't need to create `LabelledSpec` tuples directly, but are
useful for type annotations.
-}
type alias LabelledSpec =
    ( String, Spec )


{-| Generated by [leGradient](#leGradient) and [leSymbol](#leSymbol).
-}
type Legend
    = Gradient
    | Symbol


{-| Generated by [lecoAria](#lecoAria), [lecoClipHeight](#lecoClipHeight),
[lecoColumnPadding](#lecoColumnPadding), [lecoColumns](#lecoColumns),
[lecoCornerRadius](#lecoCornerRadius), [lecoDisable](#lecoDisable), [lecoFillColor](#lecoFillColor),
[lecoOrient](#lecoOrient), [lecoOffset](#lecoOffset), [lecoStrokeColor](#lecoStrokeColor),
[lecoStrokeDash](#lecoStrokeDash), [lecoStrokeWidth](#lecoStrokeWidth), [lecoPadding](#lecoPadding),
[lecoRowPadding](#lecoRowPadding), [lecoGradientDirection](#lecoGradientDirection),
[lecoGradientLabelBaseline](#lecoGradientLabelBaseline), [lecoGradientLabelLimit](#lecoGradientLabelLimit),
[lecoGradientLabelOffset](#lecoGradientLabelOffset), [lecoGradientOpacity](#lecoGradienOpacity),
[lecoGradientStrokeColor](#lecoGradientStrokeColor), [lecoGradientStrokeWidth](#lecoGradientStrokeWidth),
[lecoGradientHeight](#lecoGradientHeight), [lecoGradientWidth](#lecoGradientWidth),
[lecoGridAlign](#lecoGridAlign), [lecoLabelAlign](#lecoLabelAlign), [lecoLabelBaseline](#lecoLabelBaseline),
[lecoLabelColor](#lecoLabelColor), [lecoLabelFont](#lecoLabelFont), [lecoLabelFontSize](#lecoLabelFontSize),
[lecoLabelFontStyle](#lecoLabelFontStyle), [lecoLabelFontWeight](#lecoLabelFontWeight),
[lecoLabelLimit](#lecoLabelLimit), [lecoLabelOffset](#lecoLabelOffset), [lecoLabelOverlap](#lecoLabelOverlap),
[lecoEntryPadding](#lecoEntryPadding), [lecoSymbolBaseFillColor](#lecoSymbolBaseFillColor),
[lecoSymbolBaseStrokeColor](#lecoSymbolBaseStrokeColor), [lecoSymbolDash](#lecoSymbolDash),
[lecoSymbolDashOffset](#lecoSymbolDashOffset), [lecoSymbolDirection](#lecoSymbolDirection),
[lecoSymbolFillColor](#lecoSymbolFillColor), [lecoSymbolLimit](#lecoSymbolLimit),
[lecoSymbolOffset](#lecoSymbolOffset), [lecoSymbolOpacity](#lecoSymbolOpacity),
[lecoSymbolSize](#lecoSymbolSize), [lecoSymbolStrokeColor](#lecoSymbolStrokeColor),
[lecoSymbolStrokeWidth](#lecoSymbolStrokeWidth), [lecoSymbolType](#lecoSymbolType),
[lecoTitleAlign](#lecoTitleAlign), [lecoTitleAnchor](#lecoTitleAnchor), [lecoTitleBaseline](#lecoTitleBaseline),
[lecoTitleColor](#lecoTitleColor), [lecoTitleFont](#lecoTitleFont), [lecoTitleFontSize](#lecoTitleFontSize),
[lecoTitleFontStyle](#lecoTitleFontStyle), [lecoTitleFontWeight](#lecoTitleFontWeight),
[lecoTitleLimit](#lecoTitleLimit), [lecoTitleLineHeight](#lecoTitleLineHeight),
[lecoTitlePadding](#lecoTitlePadding) and [lecoUnselectedOpacity](#lecoUnselectedOpacity).
-}
type LegendConfig
    = LeAria (List Aria)
    | LeDisable Bool
    | LeClipHeight Float
    | LeColumnPadding Float
    | LeColumns Float
    | CornerRadius Float
    | EntryPadding Float
    | FillColor String
    | GradientDirection MarkOrientation
    | GradientHeight Float
    | GradientLabelBaseline VAlign
    | GradientLabelLimit Float
    | GradientLabelOffset Float
    | GradientOpacity Float
    | GradientStrokeColor String
    | GradientStrokeWidth Float
    | GradientWidth Float
    | LeGridAlign CompositionAlignment
    | LeLabelAlign HAlign
    | LeLabelBaseline VAlign
    | LeLabelColor String
    | LeLabelFont String
    | LeLabelFontSize Float
    | LeLabelFontStyle String
    | LeLabelFontWeight FontWeight
    | LeLabelLimit Float
    | LeLabelOffset Float
    | LeLabelOverlap OverlapStrategy
    | Offset Float
    | Orient LegendOrientation
    | LePadding Float
    | LeRowPadding Float
    | LeShortTimeLabels Bool
    | StrokeColor String
    | LeStrokeDash (List Float)
    | LeStrokeWidth Float
    | SymbolBaseFillColor String
    | SymbolBaseStrokeColor String
    | SymbolDash (List Float)
    | SymbolDashOffset Float
    | SymbolDirection MarkOrientation
    | SymbolFillColor String
    | SymbolLimit Int
    | SymbolOffset Float
    | SymbolOpacity Float
    | SymbolType Symbol
    | SymbolSize Float
    | SymbolStrokeWidth Float
    | SymbolStrokeColor String
    | LeTitleAlign HAlign
    | LeTitleAnchor Anchor
    | LeTitleBaseline VAlign
    | LeTitleColor String
    | LeTitleFont String
    | LeTitleFontSize Float
    | LeTitleFontStyle String
    | LeTitleFontWeight FontWeight
    | LeTitleLimit Float
    | LeTitleLineHeight Float
    | LeTitleOpacity Float
    | LeTitlePadding Float
    | LeUnselectedOpacity Float


{-| Generated by [loLeft](#loLeft), [loTopLeft](#loTopLeft), [loTop](#loTop),
[loTopRight](#loTopRight), [loRight](#loRight), [loBottomRight](#loBottomRight),
[loBottom](#loBottom), [loBottomLeft](#loBottomLeft) and [loNone](#loNone).
-}
type LegendOrientation
    = Bottom
    | BottomLeft
    | BottomRight
    | Left
    | None
    | Right
    | Top
    | TopLeft
    | TopRight


{-| Generated by [leAria](#leAria), [leGradient](#leGradient), [leSymbol](#leSymbol),
[leClipHeight](#leClipHeight), [leColumnPadding](#leColumnPadding), [leColumns](#leColumns),
[leCornerRadius](#leCornerRadius), [leDirection](#leDirection), [leFillColor](#leFillColor),
[leFormat](#leFormat), [leFormatAsNum](#leFormatAsNum), [leFormatAsTemporal](#leFormatAsTemporal),
[leFormatAsCustom](#leFormatAsCustom) [leGradientLength](#leGradientLength),
[leGradientOpacity](#leGradientOpacity) [leGradientThickness](#leGradientThickness),
[leGradientStrokeColor](#leGradientStrokeColor), [leGradientStrokeWidth](#leGradientStrokeWidth),
[leGridAlign](#leGridAlign), [leLabelAlign](#leLabelAlign), [leLabelBaseline](#leLabelBaseline),
[leLabelColor](#leLabelColor), [leLabelFont](#leLabelFont), [leLabelFontSize](#leLabelFontSize),
[leFontStyle](#leFontStyle), [leFontWeight](#leFontWeight), [leLabelLimit](#leLabelLimit),
[leLabelOffset](#leLabelOffset), [leLabelOverlap](#leLabelOverlap), [leOffset](#leOffset),
[leOrient](#leOrient), [lePadding](#lePadding), [leRowPadding](#leRowPadding),
[leStrokeColor](#leStrokeColor), [leStrokeWidth](#leStrokeWidth), [leSymbolDash](#leSymbolDash),
[leSymbolDashOffset](#leSymbolDashOffset) [leSymbolFillColor](#leSymbolFillColor),
[leSymbolLimit](#leSymbolLimit), [leSymbolOffset](#leSymbolOffset), [leSymbolOpacity](#leSymbolOpacity),
[leSymbolSize](#leSymbolSize), [leSymbolStrokeColor](#leSymbolStrokeColor),
[leSymbolStrokeWidth](#leSymbolStrokeWidth), [leSymbolType](#leSymbolType), [leTickCount](#leTickCount),
[leTitle](#leTitle), [leTitleAlign](#leTitleAlign), [leTitleAnchor](#leTitleAnchor),
[leTitleBaseline](#leTitleBaseline), [leTitleColor](#leTitleColor), [leTitleFont](#leTitleFont),
[leTitleFontStyle](#leTitleFontStyle), [leTitleFontSize](#leTitleFontSize),
[leTitleFontWeight](#leTitleFontWeight), [leTitleLimit](#leTitleLimit), [leTitleLineHeight](#leTitleLineHeight),
[leTitleOrient](#leTitleOrient), [leTitlePadding](#leTitlePadding), [leType](#leType),
[leValues](#leValues), [leX](#leX), [leY](#leY) and [leZIndex](#leZIndex).
-}
type LegendProperty
    = LAria (List Aria)
    | LClipHeight Num
    | LColumnPadding Num
    | LColumns Num
    | LCornerRadius Num
    | LDirection MarkOrientation
    | LFillColor Str
    | LFormat Str
    | LFormatAsNum
    | LFormatAsTemporal
    | LFormatAsCustom Str
    | LGradientLength Num
    | LGradientOpacity Num
    | LGradientThickness Num
    | LGradientStrokeColor Str
    | LGradientStrokeWidth Num
    | LGridAlign CompositionAlignment
    | LLabelAlign HAlign
    | LLabelBaseline VAlign
    | LLabelColor Str
    | LLabelFont Str
    | LLabelFontSize Num
    | LLabelFontStyle Str
    | LLabelFontWeight FontWeight
    | LLabelLimit Num
    | LLabelOffset Num
    | LLabelOverlap OverlapStrategy
    | LOffset Num
    | LOrient LegendOrientation
    | LTitleOrient LegendOrientation
    | LPadding Num
    | LRowPadding Num
    | LStrokeColor Str
    | LStrokeWidth Num
    | LSymbolDash Nums
    | LSymbolDashOffset Num
    | LSymbolFillColor Str
    | LSymbolLimit Num
    | LSymbolOffset Num
    | LSymbolOpacity Num
    | LSymbolSize Num
    | LSymbolStrokeWidth Num
    | LSymbolStrokeColor Str
    | LSymbolType Symbol
    | LTickCount Num
    | LTitle Str
    | LTitleAlign HAlign
    | LTitleAnchor Anchor
    | LTitleBaseline VAlign
    | LTitleColor Str
    | LTitleFont Str
    | LTitleFontSize Num
    | LTitleFontStyle Str
    | LTitleFontWeight FontWeight
    | LTitleLimit Num
    | LTitleLineHeight Num
    | LTitleOpacity Num
    | LTitlePadding Num
    | LType Legend
      -- TODO: Pending resolution to https://github.com/vega/vega-lite/issues/5921
      --  | LUnselectedOpacity Num
    | LValues DataValues
    | LeX Num
    | LeY Num
    | LZIndex Num


{-| Generated by [lmMarker](#lmMarker) and [lmNone](#lmNone).
-}
type LineMarker
    = LMNone
    | LMMarker (List MarkProperty)


{-| Generated by [lsGroupBy](#lsGroupBy), [lsBandwidth](#lsBandwidth) and [lsAs](#lsAs).
-}
type LoessProperty
    = LsGroupBy (List String)
    | LsBandwidth Float
    | LsAs String String


{-| Generated by [luFields](#luFields), [luFieldsAs](#luFieldsAs), [luAs](#luAs),
[luFieldsWithDefault](#luFieldsWithDefault), [luFieldsAsWithDefault](#luFieldsAsWithDefault)
and [luAsWithDefault](#luAsWithDefault)
-}
type LookupFields
    = LUFields (List String)
    | LUFieldsAs (List ( String, String ))
    | LUAs String
    | LUFieldsWithDefault (List String) String
    | LUFieldsAsWithDefault (List ( String, String )) String
    | LUAsWithDefault String String


{-| Generated by [arc](#arc), [area](#area), [bar](#bar), [boxplot](#boxplot),
[circle](#circle), [errorband](#errorband), [errorbar](#errorbar), [geoshape](#geoshape),
[image](#image), [line](#line), [point](#point), [rect](#rect), [rule](#rule),
[square](#square), [textMark](#textMark), [tick](#tick) and [trail](#trail).
-}
type Mark
    = Arc
    | Area
    | Bar
    | Boxplot
    | Errorband
    | Errorbar
    | Circle
    | Geoshape
    | Image
    | Line
    | Point
    | Rect
    | Rule
    | Square
    | Text
    | Tick
    | Trail


{-| Generated by [mName](#mName), [mDatum](#mDatum), [mQuant](#mQuant), [mNominal](#mNominal),
[mOrdinal](#mOrdinal), [mTemporal](#mTemporal), [mGeo](#mGeo), [mMType](#mMType),
[mRepeat](#mRepeat), [mRepeatDatum](#mRepeatDatum), [mScale](#mScale), [mBand](#mBand),
[mBin](#mBin), [mBinned](#mBinned) [mTimeUnit](#mTimeUnit), [mTitle](#mTitle),
[mAggregate](#mAggregate), [mLegend](#mLegend), [mSort](#mSort), [mCondition](#mCondition),
[mConditions](#mConditions), [mPath](#mPath), [mNum](#mNum), [mStr](#mStr) and [mBoo](#mBoo).
-}
type MarkChannel
    = MName String
    | MCondition Predicate (List MarkChannel) (List MarkChannel)
    | MConditions (List ( Predicate, List MarkChannel )) (List MarkChannel)
    | MDatum DataValue
    | MRepeat Arrangement
    | MRepeatDatum Arrangement
    | MmType Measurement
    | MScale (List ScaleProperty)
    | MBand Float
    | MBin (List BinProperty)
    | MBinned
    | MSort (List SortProperty)
    | MTimeUnit TimeUnit
    | MTitle String
    | MAggregate Operation
    | MLegend (List LegendProperty)
    | MPath String
    | MNumber Float
    | MString String
    | MBoolean Bool
    | MDataCondition Bool (List ( BooleanOp, List MarkChannel )) (List MarkChannel)


{-| Generated by [miBasis](#miBasis), [miBasisClosed](#miBasisClosed),
[miBasisOpen](#miBasisOpen), [miBundle](#miBundle), [miCardinal](#miCardinal),
[miCardinalClosed](#miCardinalClosed), [miCardinalOpen](#miCardinalOpen),
[miLinear](#miLinear), [miLinearClosed](#miLinearClosed), [miMonotone](#miMonotone),
[miStepwise](#miStepwise), [miStepAfter](#miStepAfter), [miStepBefore](#miStepBefore)
and [miExpr](#miExpr).
-}
type MarkInterpolation
    = Basis
    | BasisClosed
    | BasisOpen
    | Bundle
    | Cardinal
    | CardinalClosed
    | CardinalOpen
    | Linear
    | LinearClosed
    | Monotone
    | StepAfter
    | StepBefore
    | Stepwise
    | InterpolateExpr String


{-| Generated by [moHorizontal](#moHorizontal) and [moVertical](#moVertical).
-}
type MarkOrientation
    = MOHorizontal
    | MOVertical


{-| Generated by [maAlign](#maAlign), [maAngle](#maAngle), [maAria](#maAria),
[maBandSize](#maBandSize), [maBaseline](#maBaseline), [maBinSpacing](#maBinSpacing),
[maBlend](#maBlend), [maBorders](#maBorders), [maBox](#maBox), [maClip](#maClip),
[maColor](#maColor), [maColorGradient](#maColorGradient), [maCornerRadius](#maCornerRadius),
[maCornerRadiusEnd](#maCornerRadiusEnd), [maCornerRadiusTopLeft](#maCornerRadiusTopLeft),
[maCornerRadiusTopRight](#maCornerRadiusTopRightR), [maCornerRadiusBottomLeft](#maCornerRadiusBottomLeft),
[maCornerRadiusBottomRight](#maCornerRadiusBottomRight), [maCursor](#maCursor),
[maHRef](#maHRef), [maContinuousBandSize](#maContinuousBandSize), [maDir](#maDir),
[maDiscreteBandSize](#maDiscreteBandSize), [maDx](#maDx), [maDy](#maDy), [maEllipsis](#maEllipsis),
[maExtent](#maExtent), [maFill](#maFill), [maFillGradient](#maFillGradient), [maFilled](#maFilled),
[maFillOpacity](#maFillOpacity), [maFont](#maFont), [maFontSize](#maFontSize),
[maFontStyle](#maFontStyle), [maFontWeight](#maFontWeight), [maInnerRadius](#maInnerRadius),
[maOuterRadius](#maOuterRadius), [maInterpolate](#maInterpolate), [maLimit](#maLimit),
[maLine](#maLine), [maLineHeight](#maLineHeight), [maMedian](#maMedian), [maOpacity](#maOpacity),
[maOutliers](#maOutliers), [maOrient](#maOrient), [maPadAngle](#maPadAngle),
[maPoint](#maPoint), [maRadius](#maRadius), [maRadiusOffset](#maRadiusOffset),
[maRadius2Offset](#maRadius2Offset), [maRemoveInvalid](#maRemoveInvalid),
[maRule](#maRule), [maShape](#maShape), [maShortTimeLabels](#maShortTimeLabels), [maSize](#maSize),
[maStroke](#maStroke), [maStrokeGradient](#maStrokeGradient), [maStrokeCap](#maStrokeCap),
[maStrokeDash](#maStrokeDash), [maStrokeDashExpr](#maStrokeDashExpr),
[maStrokeDashOffset](#maStrokeDashOffset), [maStrokeJoin](#maStrokeJoin),
[maStrokeMiterLimit](#maStrokeMiterLimit), [maStrokeOpacity](#maStrokeOpacity),
[maStrokeWidth](#maStrokeWidth), [maStyle](#maStyle), [maTension](#maTension),
[maText](#maText), [maTheta](#maTheta), [maTheta2](#maTheta2), [maThetaOffset](#maThetaOffset),
[maTheta2Offset](#maTheta2Offset),[maThickness](#maThickness), [maTicks](#maTicks),
[maTooltip](#maTooltip), [maX](#maX), [maWidth](#maWidth), [maHeight](#maHeight),
[maY](#maY), [maXOffset](#maXOffset), [maYOffset](#maYOffset), [maX2](#maX2), [maY2](#maY2),
[maX2Offset](#maX2Offset) and [maY2Offset](#maY2Offset).
-}
type
    MarkProperty
    -- Note some of the following properties are specific options for particular
    -- types of mark (e.g. `bar`, `textMark` and `tick`) but for simplicity of the
    -- API they are combined in a single type.
    = MAlign HAlign
    | MAngle Num
    | MAria (List Aria)
    | MBandSize Num
    | MBaseline VAlign
    | MBinSpacing Num
    | MBlend BlendMode
    | MBorders (List MarkProperty)
    | MBox (List MarkProperty)
    | MClip Boo
    | MColor Str
    | MColorGradient ColorGradient (List GradientProperty)
    | MCornerRadius Num
    | MCornerRadiusEnd Num
    | MCornerRadiusTL Num
    | MCornerRadiusTR Num
    | MCornerRadiusBL Num
    | MCornerRadiusBR Num
    | MCursor Cursor
    | MHRef Str
    | MContinuousBandSize Num
    | MLimit Num
    | MEllipsis Str
    | MDir TextDirection
    | MDiscreteBandSize Num
    | MdX Num
    | MdY Num
    | MExtent SummaryExtent
    | MFill Str
    | MFillGradient ColorGradient (List GradientProperty)
    | MFilled Boo
    | MFillOpacity Num
    | MFont Str
    | MFontSize Num
    | MFontStyle Str
    | MFontWeight FontWeight
    | MInnerRadius Num
    | MInterpolate MarkInterpolation
    | MLine LineMarker
    | MLineHeight Num
    | MMedian (List MarkProperty)
    | MOpacity Num
    | MOuterRadius Num
    | MOutliers (List MarkProperty)
    | MOrder Boo
    | MOrient MarkOrientation
    | MPadAngle Num
    | MPoint PointMarker
    | MRadius Num
    | MRemoveInvalid Boo
    | MRule (List MarkProperty)
    | MShape Symbol
    | MShortTimeLabels Boo
    | MSize Num
    | MStroke Str
    | MStrokeGradient ColorGradient (List GradientProperty)
    | MStrokeCap StrokeCap
    | MStrokeDash Nums
    | MStrokeDashOffset Num
    | MStrokeJoin StrokeJoin
    | MStrokeMiterLimit Num
    | MStrokeOpacity Num
    | MStrokeWidth Num
    | MStyle (List String)
    | MTension Num
    | MText Str
    | MTheta Num
    | MTheta2 Num
    | MThickness Num
    | MTicks (List MarkProperty)
    | MTooltip TooltipContent
    | MWidth Num
    | MHeight Num
    | MX Num
    | MY Num
    | MX2 Num
    | MY2 Num
    | MXOffset Num
    | MYOffset Num
    | MX2Offset Num
    | MY2Offset Num
    | MThetaOffset Num
    | MTheta2Offset Num
    | MRadiusOffset Num
    | MRadius2Offset Num
    | MAspect Boo


{-| Type of measurement to be associated with some channel.

  - `Nominal` indicates categories that have no order. e.g. people's names; country names.
  - `Ordinal` indicates ordered categories. e.g. Small / Medium / Large; 1st, 2nd, 3rd.
  - `Quantitative` indicates numerical measurements and counts. e.g. price; temperature; frequency.
  - `Temporal` indicates time-related data.
  - `GeoFeature` indicates one or more geographic locations. e.g. a longitude/latitude; country outline.

-}
type Measurement
    = Nominal
    | Ordinal
    | Quantitative
    | Temporal
    | GeoFeature


{-| Identify a month of the year.
-}
type MonthName
    = Jan
    | Feb
    | Mar
    | Apr
    | May
    | Jun
    | Jul
    | Aug
    | Sep
    | Oct
    | Nov
    | Dec


{-| Generated by [opArgMax](#opArgMax), [opArgMin](#opArgMin), [opCI0](#opCI0),
[opCI1](#opCI1), [opCount](#opCount), [opDistinct](#opDistinct), [opMax](#opMax),
[opMean](#opMean), [opMedian](#opMedian), [opMin](#opMin), [opMissing](#opMissing),
[opProduct](#opProduct), [opQ1](#opQ1), [opQ3](#opQ3), [opStderr](#opStderr),
[opStdev](#opStdev), [opStdevP](#opStdevP), [opSum](#opSum), [opValid](#opValid),
[opVariance](#opVariance) and [opVarianceP](#opVarianceP).
-}
type Operation
    = ArgMax (Maybe String)
    | ArgMin (Maybe String)
    | CI0
    | CI1
    | Count
    | Distinct
    | Max
    | Mean
    | Median
    | Min
    | Missing
    | Product
    | Q1
    | Q3
    | Stderr
    | Stdev
    | StdevP
    | Sum
    | Valid
    | Variance
    | VarianceP


{-| Generated by [oName](#oName), [oRepeat](#oRepeat), [oQuant](#oQuant), [oNominal](#oNominal),
[oOrdinal](#oOrdinal), [oTemporal](#oTemporal), [oGeo](#oGeo), [oMType](#oMType),
[oBin](#oBin), [oAggregate](#oAggregate), [oTimeUnit](#oTimeUnit), [oSort](#oSort),
[oNum](#oNum), [oCondition](#oCondition) and [oConditions](#oConditions).
-}
type OrderChannel
    = OName String
    | OCondition Predicate (List OrderChannel) (List OrderChannel)
    | OConditions (List ( Predicate, List OrderChannel )) (List OrderChannel)
    | ORepeat Arrangement
    | OmType Measurement
    | OBin (List BinProperty)
    | OAggregate Operation
    | OTimeUnit TimeUnit
    | OSort (List SortProperty)
    | ONumber Float
    | ODataCondition Bool (List ( BooleanOp, List OrderChannel )) (List OrderChannel)


{-| Generated by [osNone](#osNone), [osGreedy](#osGreedy), [osParity](#osParity)
and [osExpr].
-}
type OverlapStrategy
    = ONone
    | OParity
    | OGreedy
    | OverlapExpr String


{-| Generated by [paSize](#paSize), [paEdges](#paEdges), [paSizeExpr](#paSizeExpr)
and [paEdgesExpr](#paEdgesExpr).
-}
type Padding
    = PSize Float
    | PEdges Float Float Float Float
    | PSizeExpr String
    | PEdgesExpr String String String String


{-| Generated by [paBind](#paBind), [paBindings](#paBindings), [paBindLegend](#paBindLegend),
[paBindScales](#paBindScales), [paExpr](#paExpr), [paValue](#paValue), [paValues](#paValues)
and [paSelect](#paSelect).
-}
type ParamProperty
    = PBind PBinding
    | PBindings (List ( String, PBinding ))
    | PBindScales
    | PBindLegend String
    | PExpr String
    | PValue DataValue
    | PValues DataValues
    | PSelect Selection (List SelectionProperty)


{-| Generated by [ipRange](#ipRange), [ipCheckbox](#ipCheckbox),
[ipRadio](#ipRadio), [ipSelect](#ipSelect), [ipText](#ipText), [ipNumber](#ipNumber),
[ipDate](#ipDate), [ipTime](#ipTime), [ipMonth](#ipMonth), [ipWeek](#ipWeek),
[ipDateTimeLocal](#ipDateTimeLocal), [ipTel](#ipTel) and [ipColor](#ipColor).
-}
type PBinding
    = IPRange (List InputProperty)
    | IPCheckbox (List InputProperty)
    | IPRadio (List InputProperty)
    | IPSelect (List InputProperty)
    | IPText (List InputProperty)
    | IPNumber (List InputProperty)
    | IPDate (List InputProperty)
    | IPTime (List InputProperty)
    | IPMonth (List InputProperty)
    | IPWeek (List InputProperty)
    | IPDateTimeLocal (List InputProperty)
    | IPTel (List InputProperty)
    | IPColor (List InputProperty)


{-| Generated by [piGroupBy](#piGroupBy), [piLimit](#piLimit) and [piOp](#piOp).
-}
type PivotProperty
    = PiGroupBy (List String)
    | PiLimit Int
    | PiOp Operation


{-| Generated by [pmNone](#pmNone), [pmTransparent](#pmTransparent) and [pmMarker](#pmMarker).
-}
type PointMarker
    = PMTransparent
    | PMNone
    | PMMarker (List MarkProperty)


{-| Type of position channel. `X` and `Y` position marks along the horizontal and
vertical axes. `X2` and `Y2` are used in combination with `X` and `Y` when two
boundaries of a mark need to be specified (e.g. a [rule](#rule) mark).

`Theta` positions an [arc](#arc) mark's angular offset allowing, for example, pie
chart segments to be specified. `Theta2` allows an end angle to be specified in
radians (where 0 is 'north'), useful for individual 'pie' segments.

`R` and `R2` position the outer and inner radial edges of an arc segment. Useful
for rose diagrams where arc radii are data-driven.

`Longitude`/`Longitude2` and `Latitude`/`Latitude2` are the equivalent for
geographic positioning subject to [projection](#projection).

`XError`/`XError2` and `YError`/`YError2` are used when specifying bounds of an
[errorbar](#errorbar) mark.

-}
type Position
    = X
    | Y
    | X2
    | Y2
    | Theta
    | Theta2
    | R
    | R2
    | Longitude
    | Latitude
    | Longitude2
    | Latitude2
    | XError
    | YError
    | XError2
    | YError2


{-| Generated by [pName](#pName), [pDatum](#pDatum), [pQuant](#pQuant), [pNominal](#pNominal),
[pOrdinal](#pOrdinal), [pTemporal](#pTemporal), [pGeo](#pGeo), [pMType](#pMType),
[pRepeat](#pRepeat), [pBin](#PBin), [pBinned](#pBinned), [pTimeUnit](#pTimeUnit),
[pTitle](#pTitle), [pAggregate](#pAggregate), [pScale](#pScale), [pAxis](#pAxis),
[pSort](#pSort), [pBandPosition](#pBandPosition), [pStack](#pStack), [pWidth](#pWidth),
[pHeight](#pHeight), [pNum](#pNum) and [pImpute](#pImpute).
-}
type PositionChannel
    = PName String
    | PDatum DataValue
    | PWidth
    | PHeight
    | PNumber Float
    | PRepeat Arrangement
    | PmType Measurement
    | PBin (List BinProperty)
    | PBinned
    | PTimeUnit TimeUnit
    | PTitle String
    | PAggregate Operation
    | PScale (List ScaleProperty)
    | PAxis (List AxisProperty)
    | PSort (List SortProperty)
    | PBandPosition Float
    | PStack StackOffset
    | PImpute (List ImputeProperty)


{-| Generated by [albers](#albers), [albersUsa](#albersUsa),
[azimuthalEqualArea](#azimuthalEqualArea), [azimuthalEquidistant](#azimuthalEquidistant),
[conicConformal](#conicConformal), [conicEqualArea](#conicEqualArea),
[conicEquidistant](#conicEquidistant), [equalEarth](#equalEarth),
[equirectangular](#equirectangular), [gnomonic](#gnomonic),
[identityProjection](#identityProjection), [mercator](#mercator), [naturalEarth1](#naturalEarth1)
[orthographic](#orthographic), [stereographic](#stereographic),
[transverseMercator](#transverseMercator), [customProjection](#customProjection)
and [prExpr](#prExpr).
-}
type Projection
    = Albers
    | AlbersUsa
    | AzimuthalEqualArea
    | AzimuthalEquidistant
    | ConicConformal
    | ConicEqualArea
    | ConicEquidistant
    | Custom String
    | Equirectangular
    | EqualEarth
    | Gnomonic
    | Identity
    | Mercator
    | NaturalEarth1
    | Orthographic
    | Stereographic
    | TransverseMercator
    | ProjectionExpr String


{-| Generated by [prType](#prType), [prClipAngle](#prClipAngle), [prClipExtent](#prClipExtent),
[prCenter](#prCenter), [prScale](#prScale), [prTranslate](#prTranslate), [prRotate](#prRotate),
[prRotateExpr](#prRotateExpr), [prPrecision](#prPrecision), [prCoefficient](#prCoefficient),
[prDistance](#prDistance), [prFraction](#prFraction), [prLobes](#prLobes), [prParallels](#prParallels),
[prParallelsExpr](#prParallelsExpr), [prReflectX](#prReflectX), [prReflectY](#prReflectY),
[prParallel](#prParallel), [prPointRadius](#prPointRadius), [prRadius](#prRadius),
[prRatio](#prRatio), [prSpacing](#prSpacing) and [prTilt](#prTilt).
-}
type ProjectionProperty
    = PrType Projection
    | PrClipAngle Num
    | PrClipExtent ClipRect
    | PrCenter Num Num
    | PrScale Num
    | PrTranslate Num Num
    | PrRotate Num Num Num
    | PrPrecision Num
    | PrParallels Num Num
    | PrPointRadius Num
    | PrReflectX Boo
    | PrReflectY Boo
    | PrCoefficient Num
    | PrDistance Num
    | PrFraction Num
    | PrLobes Num
    | PrParallel Num
    | PrRadius Num
    | PrRatio Num
    | PrSpacing Num
    | PrTilt Num


{-| Generated by [prParam](#prParam), [prParamEmpty](#prParamEmpty) and [prTest](#prTest).
-}
type Predicate
    = Param String
    | ParamEmpty String
    | Test BooleanOp


{-| Generated by [qtGroupBy](#qtGroupBy), [qtProbs](#qtProbs), [qtStep](#qtStep)
and [qtAs](#qtAs).
-}
type QuantileProperty
    = QtGroupBy (List String)
    | QtProbs (List Float)
    | QtStep Float
    | QtAs String String


{-| Generated by [racoCategory](#racoCategory), [racoDiverging](#racoDiverging),
[racoHeatmap](#racoHeatmap), [racoOrdinal](#racoOrdinal), [racoRamp](#racoRamp)
and [racoSymbol](#racoSymbol).
-}
type RangeConfig
    = RCategory String
    | RDiverging String
    | RHeatmap String
    | ROrdinal String
    | RRamp String
    | RSymbol String


{-| Generated by [rgLinear](#rgLinear), [rgLog](#rgLog), [rgExp](#rgExp), [rgPow](#rgPow),
[rgQuad](#rgQuad) and [rgPoly](#rgPoly).
-}
type RegressionMethod
    = RgLinear
    | RgLog
    | RgExp
    | RgPow
    | RgQuad
    | RgPoly


{-| Generated by [rgGroupBy](#rgGroupBy), [rgMethod](#rgMethod), [rgOrder](#rgOrder),
[rgExtent](#rgExtent), [rgParams](#rgParams) and [rgAs](#rgAs).
-}
type RegressionProperty
    = RgGroupBy (List String)
    | RgMethod RegressionMethod
    | RgOrder Int
    | RgExtent Float Float
    | RgParams Bool
    | RgAs String String


{-| Generated by [rowFields](#rowFields), [columnFields](#columnFields) and
[layerFields](#layerFields).
-}
type RepeatFields
    = RowFields (List String)
    | ColumnFields (List String)
    | LayerFields (List String)


{-| Generated by [reShared](#reShared) and [reIndependent](#reIndependent).
-}
type Resolution
    = RShared
    | RIndependent


{-| Generated by [reAxis](#reAxis), [reLegend](#reLegend) and [reScale](#reScale).
-}
type Resolve
    = RAxis (List ( Channel, Resolution ))
    | RLegend (List ( Channel, Resolution ))
    | RScale (List ( Channel, Resolution ))


{-| Generated by [scLinear](#scLinear), [scPow](#scPow), [scSqrt](#scSqrt),
[scLog](#scLog), [scSymLog](#scSymLog), [scTime](#scTime), [scUtc](#scUtc),
[scOrdinal](#scOrdinal), [scBand](#scBand), [scPoint](#scPoint),
[scBinOrdinal](#scBinOrdinal), [scQuantile](#scQuantile), [scQuantize](#scQuantize)
and [scThreshold](#scThreshold).
-}
type Scale
    = ScLinear
    | ScPow
    | ScSqrt
    | ScLog
    | ScSymLog
    | ScTime
    | ScUtc
    | ScOrdinal
    | ScBand
    | ScPoint
    | ScBinOrdinal
    | ScQuantile
    | ScQuantize
    | ScThreshold


{-| Generated by [sacoBandPaddingInner](#sacoBandPaddingInner), [sacoBandPaddingOuter](#sacoBandPaddingOuter),
[sacoBarBandPaddingInner](#sacoBarBandPaddingInner), [sacoBarBandPaddingOuter](#sacoBarBandPaddingOuter),
[sacoRectBandPaddingInner](#sacoRectBandPaddingInner), [sacoRectBandPaddingOuter](#sacoRectBandPaddingOuter),
[sacoClamp](#sacoClamp), [sacoMaxBandSize](#sacoMaxBandSize), [sacoMinBandSize](#sacoMinBandSize),
[sacoMaxFontSize](#sacoMaxFontSize), [sacoMinFontSize](#sacoMinFontSize), [sacoMaxOpacity](#sacoMaxOpacity),
[sacoMinOpacity](#sacoMinOpacity), [sacoMaxSize](#sacoMaxSize), [sacoMinSize](#sacoMinSize),
[sacoMaxStrokeWidth](#sacoMaxStrokeWidth), [sacoMinStrokeWidth](#sacoMinStrokeWidth),
[sacoPointPadding](#sacoPointPadding), [sacoRound](#sacoRound),
[sacoUseUnaggregatedDomain](#sacoUseUnaggregatedDomain) and [sacoXReverse](#sacoXReverse).
-}
type ScaleConfig
    = SCBandPaddingInner Float
    | SCBandPaddingOuter Float
    | SCBarBandPaddingInner Float
    | SCBarBandPaddingOuter Float
    | SCRectBandPaddingInner Float
    | SCRectBandPaddingOuter Float
    | SCClamp Bool
    | SCMaxBandSize Float
    | SCMinBandSize Float
    | SCMaxFontSize Float
    | SCMinFontSize Float
    | SCMaxOpacity Float
    | SCMinOpacity Float
    | SCMaxSize Float
    | SCMinSize Float
    | SCMaxStrokeWidth Float
    | SCMinStrokeWidth Float
    | SCPointPadding Float
    | SCRound Bool
    | SCUseUnaggregatedDomain Bool
    | SCXReverse Bool


{-| Generated by [doNums](#doNums), [doMin](#doMin), [doMid](#doMid), [doMax](#doMax),
[doStrs](#doStrs), [doDts](#doDts), [doDtsExpr](#doDtsExpr), [doMinDt](#doMinDt),
[doMinDtExpr](#doMinDtExpr), [doMaxDt](#doMaxDt), [doMaxDtExpr](#doMaxDtExpr),
[doSelection](#doSelection), [doSelectionChannel](#doSelectionChannel), [doSelectionField](#doSelectionField),
[doUnionWith](#doUnionWith) and [doUnaggregated](#doUnaggregated).
-}
type ScaleDomain
    = DNumbers Nums
    | DMinNumber Num
    | DMidNumber Num
    | DMaxNumber Num
    | DMinDateTime Timestamp
    | DMaxDateTime Timestamp
    | DStrings (List String)
    | DDateTimes (List (List DateTime))
    | DDateTimesExpr String
    | DSelection String
    | DSelectionField String String
    | DSelectionChannel String Channel
    | DUnionWith ScaleDomain
    | Unaggregated


{-| Generated by [niTrue](#niTrue), [niFalse](#niFalse), [niMillisecond](#niMillisecond),
[niSecond](#niSecond), [niMinute](#niMinute), [niHour](#niHour), [niDay](#niDay),
[niWeek](#niWeek), [niMonth](#niMonth), [niYear](#niYear), [niTickCount](#niTickCount),
[niInterval](#niInterval) and [niExpr](#niExpr).
-}
type ScaleNice
    = NMillisecond
    | NSecond
    | NMinute
    | NHour
    | NDay
    | NWeek
    | NMonth
    | NYear
    | NTrue
    | NFalse
    | NInterval TimeUnit Int
    | NTickCount Int
    | NExpr String


{-| Generated by [scType](#scType), [scDomain](#scDomain), [scDomainExpr](#scDomainExpr),
[scRange](#scRange), [scScheme](#scScheme), [scSchemeExpr](#scSchemeExpr), [scAlign](#scAlign),
[scPadding](#scPadding), [scPaddingInner](#scPaddingInner), [scPaddingOuter](#scPaddingOuter),
[scReverse](#scReverse), [scRound](#scRound), [scClamp](#scClamp), [scInterpolate](#scInterpolate),
[scNice](#scNice), [scExponent](#scExponent), [scConstant](#scConstant), [scBase](#scBase)
and [scZero](#scZero).
-}
type ScaleProperty
    = SType Scale
    | SDomain ScaleDomain
    | SDomainExpr String
    | SRange ScaleRange
    | SScheme String (List Float)
    | SSchemeExpr String (List Float)
    | SAlign Float
    | SPadding Float
    | SPaddingInner Float
    | SPaddingOuter Float
    | SRound Boo
    | SClamp Boo
      -- TODO:  Need to restrict set of valid scale types that work with color interpolation.
    | SInterpolate CInterpolate
    | SNice ScaleNice
    | SZero Boo
    | SExponent Float
    | SDomainMid Float
    | SConstant Float
    | SBase Float
    | SReverse Boo


{-| Generated by [raNums](#raNums), [raExprs](#raExprs), [raMin](#raMin), [raMax](#raMax),
[raStrs](#raStrs), [raNumLists](#raNumLists), [raName](#raName) and [raField](#raField).
-}
type ScaleRange
    = RNumbers Nums
    | RStrings Strs
    | RExprs (List String)
    | RNumberLists (List (List Float))
    | RName String
    | RMinNumber Num
    | RMaxNumber Num
    | RField String



-- TODO: Pending confirmation of https://github.com/vega/vega-lite/issues/6758
-- | RMinString String
-- | RMaxString String


{-| Generated by [sePoint](#sePoint) and [seInterval](#seInterval).
-}
type Selection
    = SePoint
    | SeInterval
    | SeSingle
    | SeMulti


{-| Generated by [smFill](#smFill), [smFillOpacity](#smFillOpacity), [smStroke](#smStroke),
[smStrokeDash](#smStrokeDash), [smStrokeDashOffset](#smStrokeDashOffset),
[smStrokeOpacity](#smStrokeOpacity), [smStrokeWidth](#smStrokeWidth) and
[smCursor](#smCursor).
-}
type SelectionMarkProperty
    = SMFill String
    | SMFillOpacity Float
    | SMStroke String
    | SMStrokeOpacity Float
    | SMStrokeWidth Float
    | SMStrokeDash (List Float)
    | SMStrokeDashOffset Float
    | SMCursor Cursor


{-| Generated by [seClear](#seClear), [seEncodings](#seEncodings),[seFields](#seFields),
[seNearest](#seNearest), [seOn](#seOn), [seResolve](#seResolve),
[seSelectionMark](#seSelectionMark), [seToggle](#seToggle), [seTranslate](#seTranslate)
and [seZoom](#seZoom).
-}
type SelectionProperty
    = Empty
    | BindScales
    | BindLegend (List BindLegendProperty)
    | On String
    | Clear String
    | Translate String
    | Zoom String
    | Fields (List String)
    | Encodings (List Channel)
    | SInit (List ( String, DataValue ))
    | SInitInterval (Maybe ( DataValue, DataValue )) (Maybe ( DataValue, DataValue ))
    | ResolveSelections SelectionResolution
    | SelectionMark (List SelectionMarkProperty)
    | Bind (List Binding)
    | Nearest Bool
    | Toggle TogglePredicate


{-| Generated by [seGlobal](#seGlobal), [seUnion](#seUnion) and
[seIntersection](#seIntersection).
-}
type SelectionResolution
    = SeGlobal
    | SeUnion
    | SeIntersection


{-| Generated by [siLeft](#siLeft), [siRight](#siRight), [siTop](#siTop),
[siBottom](#siBottom) and [siExpr](#siExpr).
-}
type Side
    = STop
    | SBottom
    | SLeft
    | SRight
    | SExpr String


{-| Generated by [soAscending](#soAscending), [soDescending](#soDescending),
[soByField](#soByField), [soByChannel](#soByChannel), [soByRepeat](#soByRepeat)
and [soCustom](#soCustom).
-}
type SortProperty
    = Ascending
    | Descending
    | CustomSort DataValues
    | ByRepeatOp Arrangement Operation
    | ByFieldOp String Operation
    | ByChannel Channel


{-| Part or all of a Vega-Lite specification. Specs are usually nested and can
range from a single Boolean value up to the full visualization specification.
-}
type alias Spec =
    JE.Value


{-| Generated by [stZero](#stZero), [stCenter](#stCenter), [stNormalize](#stNormalize)
and [stNone](#stNone).
-}
type StackOffset
    = OfZero
    | OfNormalize
    | OfCenter
    | OfNone


{-| Generated by [stOffset](#stOffset) and [stSort](#stSort).
-}
type StackProperty
    = StOffset StackOffset
    | StSort (List SortField)


{-| Generated by [caButt](#caButt), [caRound](#caRound), [caSquare](#caSquare) and
[caExpr](#caExpr).
-}
type StrokeCap
    = CButt
    | CRound
    | CSquare
    | CExpr String


{-| Generated by [joMiter](#joMiter), [joRound](#joRound), [joBevel](#joBevel) and
[joExpr](#joExpr).
-}
type StrokeJoin
    = JMiter
    | JRound
    | JBevel
    | JExpr String


{-| Generated by [symCircle](#symCircle), [symSquare](#symSquare), [symCross](#symCross),
[symDiamond](#symDiamond), [symTriangleUp](#symTriangleUp), [symTriangleDown](#symTriangleDown),
[symTriangleLeft](#symTriangleLeft), [symTriangleRight](#symTriangleRight), [symPath](#symPath),
[symStroke](#symStroke), [symArrow](#symArrow), [symWedge](#symWedge),[symTriangle](#symTriangle)
and [symExpr](#symExpr).
-}
type Symbol
    = SymCircle
    | SymSquare
    | SymCross
    | SymDiamond
    | SymTriangleUp
    | SymTriangleDown
    | SymTriangleLeft
    | SymTriangleRight
    | SymPath String
    | SymStroke
    | SymArrow
    | SymWedge
    | SymTriangle
    | SymExpr String


{-| Generated by [exCi](#exCi), [exIqr](#exIqr), [exIqrScale](#exIqrScale), [exRange](#exRange),
[exStderr](#exStderr) and [exStdev](#exStdev).
-}
type SummaryExtent
    = ExCI
    | ExStderr
    | ExStdev
    | ExIqr
    | ExRange
    | ExIqrScale Float


{-| Generated by [tName](#tName), [tRepeat](#tRepeat), [tQuant](#tQuant),
[tNominal](#tNominal), [tOrdinal](#tOrdinal), [tTemporal](#tTemporal), [tGeo](#tGeo),
[tMType](#tMType), [tBin](#tBin), [tBinned](#tBinned), [tAggregate](#tAggregate),
[tTimeUnit](#tTimeUnit), [tTitle](#tTitle), [tCondition](#tCondition),
[tConditions](#tConditions), [tFormat](#tFormat), [tFormatAsNum](#tFormatAsNum),
[tFormatAsTemporal](#tFormatAsTemporal), [tFormatAsCustom](#tFormatAsCustom),
[tStr](#tStr) and [tDatum](#tDatum).
-}
type TextChannel
    = TName String
    | TRepeat Arrangement
    | TmType Measurement
    | TBin (List BinProperty)
    | TBinned
    | TAggregate Operation
    | TTimeUnit TimeUnit
    | TTitle String
    | TCondition Predicate (List TextChannel) (List TextChannel)
    | TConditions (List ( Predicate, List TextChannel )) (List TextChannel)
    | TFormat String
    | TFormatAsNum
    | TFormatAsTemporal
    | TFormatAsCustom String
    | TString String
    | TDatum DataValue
    | TDataCondition Bool (List ( BooleanOp, List TextChannel )) (List TextChannel)


{-| Generated by [tdLeftToRight](#tdLeftToRight), [tdRightToLeft](#tdRightToLeft)
and [tdExpr](#tdExpr).
-}
type TextDirection
    = LeftToRight
    | RightToLeft
    | TDExpr String


{-| Generated by [tbCenter](#tbCenter), [tbExtent](#tbExtent) and [tbExpr](#tbExpr).
-}
type TickBand
    = TBCenter
    | TBExtent
    | TBExpr String


{-| Generated by [date](#date), [day](#day), [dayOfYear](#dayOfYear), [dayHours](#dayHours),
[dayHoursMinutes](#dayHoursMinutes), [dayHoursMinutesSeconds](#dayHoursMinutesSeconds),
[hours](#hours), [hoursMinutes](#hoursMinutes), [hoursMinutesSeconds](#hoursMinutesSeconds),
[milliseconds](#milliseconds), [minutes](#minutes), [minutesSeconds](#minutesSeconds),
[month](#month), [monthDate](#monthDate), [monthDateHoursMinutes](#monthDateHoursMinutes),
[monthDateHoursMinutesSeconds](#monthDateHoursMinutesSeconds), [quarter](#quarter),
[quarterMonth](#quarterMonth), [seconds](#seconds), [secondsMilliseconds](#secondsMilliseconds),
[week](#week), [weekDay](#weekDay), [weekDayHours](#weekDayHours), [weekDayHoursMinutes](#weekDayHoursMinutes),
[weekDayHoursMinutesSeconds](#weekDayHoursMinutesSeconds), [year](#year), [yearQuarter](#yearQuarter),
[yearQuarterMonth](#yearQuarterMonth), [yearMonth](#yearMonth), [yearMonthDate](#yearMonthDate),
[yearMonthDateHours](#yearMonthDateHours), [yearMonthDateHoursMinutes](#yearMonthDateHoursMinutes),
[yearMonthDateHoursMinutesSeconds](#yearMonthDateHoursMinutesSeconds), [yearWeek](#yearWeek),
[yearWeekDay](#yearWeekDay), [yearWeekDayHours](#yearWeekDayHours),
[yearWeekDayHoursMinutes](#yearWeekDayHoursMinutes),
[yearWeekDayHoursMinutesSeconds](#yearWeekDayHoursMinutesSeconds),
[yearDayOfYear](#yearDayOfYear), [utc](#utc), [tuMaxBins](#tuMaxBins) and
[tuStep](#tuStep).
-}
type TimeUnit
    = Year
    | YearQuarter
    | YearQuarterMonth
    | YearMonth
    | YearMonthDate
    | YearMonthDateHours
    | YearMonthDateHoursMinutes
    | YearMonthDateHoursMinutesSeconds
    | YearWeek
    | YearWeekDay
    | YearWeekDayHours
    | YearWeekDayHoursMinutes
    | YearWeekDayHoursMinutesSeconds
    | YearDayOfYear
    | Quarter
    | QuarterMonth
    | Month
    | MonthDate
    | MonthDateHours
    | MonthDateHoursMinutes
    | MonthDateHoursMinutesSeconds
    | Week
    | WeekDay
    | WeekDayHours
    | WeekDayHoursMinutes
    | WeekDayHoursMinutesSeconds
    | Date
    | Day
    | DayOfYear
    | DayHours
    | DayHoursMinutes
    | DayHoursMinutesSeconds
    | Hours
    | HoursMinutes
    | HoursMinutesSeconds
    | Minutes
    | MinutesSeconds
    | Seconds
    | SecondsMilliseconds
    | Milliseconds
    | Utc TimeUnit
    | TUMaxBins Int
    | TUStep Float TimeUnit


{-| Generated by [ticoAnchor](#ticoAnchor), [ticoAngle](#ticoAngle), [ticoBaseline](#ticoBaseline),
[ticoColor](#ticoColor), [ticoDx](#ticoDx), [ticoDy](#ticoDy), [ticoFont](#ticoFont),
[ticoFontSize](#ticoFontSize), [ticoFontStyle](#ticoFontStyle), [ticoFontWeight](#ticoFontWeight),
[ticoFrame](#ticoFrame), [ticoLimit](#ticoLimit), [ticoLineHeight](#ticoLineHeight),
[ticoOffset](#ticoOffset), [ticoOrient](#ticoOrient), [ticoStyle](#ticoStyle),
[ticoSubtitleColor](#ticoSubtitleColor), [ticoSubtitleFont](#ticoSubtitleFont),
[ticoSubtitleFontSize](#ticoSubtitleFontSize), [ticoSubtitleFontStyle](#ticoSubtitleFontStyle),
[ticoSubtitleFontWeight](#ticoSubtitleFontWeight), [ticoSubtitleLineHeight](#ticoSubtitleLineHeight),
[ticoSubtitlePadding](#ticoSubtitlePadding) and [ticoZIndex](#ticoZIndex).
-}
type TitleConfig
    = TAnchor Anchor
    | TAngle Num
    | TBaseline VAlign
    | TColor Str
    | TDx Num
    | TDy Num
    | TFont Str
    | TFontSize Num
    | TFontStyle Str
    | TFontWeight FontWeight
    | TFrame TitleFrame
    | TLineHeight Num
    | TLimit Num
    | TOffset Num
    | TOrient Side
    | TStyle (List String)
    | TSubtitle Str
    | TSubtitleColor Str
    | TSubtitleFont Str
    | TSubtitleFontSize Num
    | TSubtitleFontStyle Str
    | TSubtitleFontWeight FontWeight
    | TSubtitleLineHeight Num
    | TSubtitlePadding Num
    | TZIndex Num


{-| Generated by [tfBounds](#tfBounds), [tfGroup](#tfGroup) and [tfExpr](#tfExpr).
-}
type TitleFrame
    = FrBounds
    | FrGroup
    | FrExpr String


{-| Generated by [tiAnchor](#tiAnchor), [tiAngle](#tiAngle), [tiBaseline](#tiBaseline),
[tiColor](#tiColor), [tiDx](#tiDx), [tiDy](#tiDy), [tiFont](#tiFont), [tiFontSize](#tiFontSize),
[tiFontStyle](#tiFontStyle), [tiFontWeight](#tiFontWeight), [tiFrame](#tiFrame),
[tiLimit](#tiLimit), [tiLineHeight](#tiLineHeight),[tiOffset](#tiOffset),
[tiOrient](#tiOrient), [tiStyle](#tiStyle) [tiSubtitle](#tiSubtitle),
[tiSubtitleColor](#tiSubtitleColor), [tiSubtitleFont](#tiSubtitleFont),
[tiSubtitleFontSize](#tiSubtitleFontSize), [tiSubtitleFontStyle](#tiSubtitleFontStyle),
[tiSubtitleFontWeight](#tiSubtitleFontWeight), [tiSubtitleLineHeight](#tiSubtitleLineHeight),
[tiSubtitlePadding](#tiSubtitlePadding) and [tiZIndex](#tiZIndex).
-}
type alias TitleProperty =
    TitleConfig


{-| Generate by [tpFalse](#tpFalse), [tpShiftKey](#tpShiftKey), [tpCtrlKey](#tpCtrlKey),
[tpAltKey](#tpAltKey) and [tpExpr](#tpExpr).
-}
type TogglePredicate
    = TpFalse
    | TpExpr String
    | TpShiftKey
    | TpCtrlKey
    | TpAltKey


{-| Generated by [ttEncoding](#ttEncoding), [ttData](#ttData) and [ttNone](#ttNone).
-}
type TooltipContent
    = TTEncoding
    | TTData
    | TTNone



-- | TTExpr String


{-| Generated by [vaTop](#vaTop), [vaLineTop](#vaLineTop), [vaMiddle](#vaMiddle),
[vaAlphabetic](#vaAlphabetic), [vaBottom](#vaBottom), [vaLineBottom](#vaLineBottom)
and [vaExpr](#vaExpr).
-}
type VAlign
    = VAlignTop
    | VAlignLineTop
    | VAlignMiddle
    | VAlignBottom
    | VAlignLineBottom
    | VAlignAlphabetic
    | VAlignExpr String


{-| Generated by [viewStyle](#viewStyle), [viewCornerRadius](#viewCornerRadius),
[viewFill](#viewFill), [viewFillOpacity](#viewFillOpacity), [viewOpacity](#viewOpacity),
[viewStroke](#viewStroke), [viewStrokeOpacity](#viewStrokeOpacity), [viewStrokeWidth](#viewStrokeWidth),
[viewStrokeCap](#viewStrokeCap), [viewStrokeDash](#viewStrokeDash), [viewStrokeDashOffset](#viewStrokeDashOffset),
[viewStrokeJoin](#viewStrokeJoin) and [viewStrokeMiterLimit](#viewStrokeMiterLimit).
-}
type ViewBackground
    = VBStyle (List String)
    | VBCornerRadius Num
    | VBFill Str
    | VBFillOpacity Num
    | VBOpacity Num
    | VBStroke Str
    | VBStrokeOpacity Num
    | VBStrokeWidth Num
    | VBStrokeCap StrokeCap
    | VBStrokeDash Nums
    | VBStrokeDashOffset Num
    | VBStrokeJoin StrokeJoin
    | VBStrokeMiterLimit Num


{-| Generated by [vicoBackground](#vicoBackground), [vicoClip](#vicoClip),
[vicoContinuousHeight](#vicoContinuousHeight), [vicoContinuousWidth](#vicoContinuousWidth),
[vicoCursor](#vicoCursor), [vicoDiscreteHeight](#vicoDiscreteHeight),
[vicoDiscreteWidth](#vicoDiscreteWidth), [vicoCornerRadius](#vicoCornerRadius),
[vicoFill](#vicoFill), [vicoFillOpacity](#vicoFillOpacity), [vicoOpacity](#vicoOpacity),
[vicoStep](#vicoStep), [vicoStroke](#vicoStroke), [vicoStrokeCap](#vicoStrokeCap),
[vicoStrokeDash](#vicoStrokeDash), [vicoStrokeDashOffset](#vicoStrokeDashOffset),
[vicoStrokeJoin](#vicoStrokeJoin), [vicoStrokeMiterLimit](#vicoStrokeMiterLimit),
[vicoStrokeOpacity](#vicoStrokeOpacity) and [vicoStrokeWidth](#vicoStrokeWidth).
-}
type ViewConfig
    = VBackground (List ViewBackground)
    | VClip Bool
    | VContinuousWidth Float
    | VContinuousHeight Float
    | VCornerRadius Float
    | VCursor Cursor
    | VDiscreteWidth Float
    | VDiscreteHeight Float
    | VFill (Maybe String)
    | VFillOpacity Float
    | VOpacity Float
    | VStep Float
    | VStroke (Maybe String)
    | VStrokeOpacity Float
    | VStrokeWidth Float
    | VStrokeCap StrokeCap
    | VStrokeDash (List Float)
    | VStrokeDashOffset Float
    | VStrokeJoin StrokeJoin
    | VStrokeMiterLimit Float


{-| Top-level Vega-Lite properties. These are the ones that define the core of the
visualization grammar. All `VLProperties` are created by functions in seven broad groups.

**Data properties** relate to the input data to be visualized. Generated by
[`dataFromColumns`](#dataFromColumns), [`dataFromRows`](#dataFromRows),
[`dataFromUrl`](#dataFromUrl), [`dataFromSource`](#dataFromSource),
[`dataFromJson`](#dataFromJson), [`dataSequence`](#dataSequence), [`sphere`](#sphere)
and [`graticule`](#graticule).

**Transform properties** indicate that some transformation of input data should
be applied before encoding them visually. Generated by [`transform`](#transform)
and [`projection`](#projection) they can include data transformations such as
[`filter`](#filter), [`binAs`](#binAs) and [`calculateAs`](#calculateAs) and geo
transformations of longitude, latitude coordinates used by marks such as
[`geoshape`](#geoshape), [`point`](#point) and [`line`](#line).

**Mark functions** specify the graphical symbols used to visualize data items.
Generated by functions such as [`circle`](#circle), [`bar`](#bar) and [`line`](#line).

**Encoding properties** specify which data elements are mapped to which mark
characteristics (known as _channels_). Generated by [`encoding`](#encoding) they
include encodings such as [`position`](#position), [`color`](#color), [`size`](#size),
[`shape`](#shape), [`text`](#text), [`hyperlink`](#hyperlink) and [`order`](#order).

**Composition properties** allow visualization views to be combined to form more
complex visualizations. Generated by [`layer`](#layer), [`repeatFlow`](#repeatFlow),
[`repeat`](#repeat), [`facetFlow`](#facetFlow), [`facet`](#facet), [`concat`](#concat),
[`columns`](#columns), [`hConcat`](#hConcat), [`vConcat`](#vConcat),
[`specification`](#specification) and [`resolve`](#resolve).

**Interaction properties** allow clicking, dragging and other interactions generated
via a GUI or data stream to influence the visualization. Generated by
[`selection`](#selection).

**Supplementary and configuration properties** provide a means to add metadata and
styling to one or more visualizations. Generated by [`name`](#name), [`title`](#title),
[`description`](#description), [`background`](#background), [`backgroundExpr`](#backgroundExpr),
[`width`](#width), [`height`](#height), [`widthStep`](#widthStep), [`heightStep`](#heightStep),
[`padding`](#padding), [`autosize`](#autosize), [`viewBackground`](#viewBackground)
and [`configure`](#configure).

-}
type VLProperty
    = VLName
    | VLParams
    | VLDescription
    | VLTitle
    | VLWidth
    | VLHeight
    | VLWidthStep
    | VLHeightStep
    | VLAutosize
    | VLPadding
    | VLBackground
    | VLBackgroundExpr
    | VLData
    | VLDatasets
    | VLMark
    | VLTransform
    | VLProjection
    | VLEncoding
    | VLLayer
    | VLConcat
    | VLHConcat
    | VLVConcat
    | VLColumns
    | VLRepeat
    | VLFacet
    | VLSpec
    | VLResolve
    | VLSpacing
    | VLAlign
    | VLBounds
    | VLCenter
    | VLConfig
    | VLSelection
    | VLViewBackground


{-| Generated by [wiAggregateOp](#wiAggregateOp), [wiOp](#wiOp), [wiParam](#wiParam)
and [wiField](#wiField).
-}
type Window
    = WAggregateOp Operation
    | WOp WOperation
    | WParam Int
    | WField String


{-| Generated by [woRowNumber](#woRowNumber), [woRank](#woRank), [woDenseRank](#woDenseRank),
[woPercentRank](#woPercentRank), [woCumeDist](#woCumeDist), [woPercentile](#woPercentile),
[woLag](#woLag), [woLead](#woLead), [woFirstValue](#woFirstValue), [woLastValue](#woLastValue),
and [woNthValue](#woNthValue).
-}
type WOperation
    = RowNumber
    | Rank
    | DenseRank
    | PercentRank
    | CumeDist
    | Ntile
    | Lag
    | Lead
    | FirstValue
    | LastValue
    | NthValue


{-| Generated by [wiFrame](#wiFrame), [wiIgnorePeers](#wiIgnorePeers), [wiGroupBy](#wiGroupBy)
and [wiSort](#wiSort).
-}
type WindowProperty
    = WFrame (Maybe Int) (Maybe Int)
    | WIgnorePeers Bool
    | WGroupBy (List String)
    | WSort (List SortField)


{-| Generated by [stAscending](#stAscending), [wiAscending](#wiAscending),
[stDescending](#stDescending) and [wiDescending](#wiDescending).
-}
type SortField
    = WAscending String
    | WDescending String


{-| Aggregation transformations to be used when encoding channels. Useful when for
applying the same transformation to a number of channels without defining it each
time. The first parameter is a list of the named aggregation operations to apply.
The second is a list of 'group by' fields.

    trans =
        transform
            << aggregate
                [ opAs opMin "people" "lowerBound", opAs opMax "people" "upperBound" ]
                [ "age" ]

-}
aggregate : List Spec -> List String -> List LabelledSpec -> List LabelledSpec
aggregate ops groups =
    (::)
        ( "multiSpecs"
        , JE.object
            [ ( "aggregate", toList ops )
            , ( "groupby", JE.list JE.string groups )
            ]
        )


{-| An Albers equal-area conic map projection.
-}
albers : Projection
albers =
    Albers


{-| An Albers USA map projection that combines continental USA with Alaska and Hawaii.
Unlike other projection types, this remains unaffected by [prRotate](#prRotate).
-}
albersUsa : Projection
albersUsa =
    AlbersUsa


{-| Alignment to apply to grid rows and columns generated by a composition
operator. This version sets the same alignment for rows and columns.
-}
align : CompositionAlignment -> ( VLProperty, Spec )
align algn =
    ( VLAlign, JE.string (compositionAlignmentLabel algn) )


{-| Similar to [align](#align) but with independent alignments for rows (first
parameter) and columns (second parameter).
-}
alignRC : CompositionAlignment -> CompositionAlignment -> ( VLProperty, Spec )
alignRC alRow alCol =
    ( VLSpacing
    , JE.object
        [ ( "row", JE.string (compositionAlignmentLabel alRow) )
        , ( "col", JE.string (compositionAlignmentLabel alCol) )
        ]
    )


{-| Apply an 'and' Boolean operation as part of a logical composition.

    and (expr "datum.IMDB_Rating === null") (expr "datum.Rotten_Tomatoes_Rating === null")

-}
and : BooleanOp -> BooleanOp -> BooleanOp
and op1 op2 =
    And op1 op2


{-| Anchor some text at its end.
-}
anEnd : Anchor
anEnd =
    AnEnd


{-| Specify an anchor style ("start", "middle", "end") with an expression.
-}
anExpr : String -> Anchor
anExpr =
    AnchorExpr


{-| Encode an angle (orientation) channel. This allows data-driven rotation of
text, point-based marks.
-}
angle : List MarkChannel -> List LabelledSpec -> List LabelledSpec
angle markProps =
    (::) ( "angle", List.concatMap markChannelProperties markProps |> JE.object )


{-| Anchor some text in its start.
-}
anMiddle : Anchor
anMiddle =
    AnMiddle


{-| Anchor some text at its start.
-}
anStart : Anchor
anStart =
    AnStart


{-| [Arc mark](https://vega.github.io/vega-lite/docs/arc.html) for radial plots
such as pie charts or rose diagrams.
-}
arc : List MarkProperty -> ( VLProperty, Spec )
arc =
    mark Arc


{-| Column arrangement in a repeated/faceted view.
-}
arColumn : Arrangement
arColumn =
    Column


{-| Description to be provided in [ARIA tag](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA)
when generating SVG output. If not specified, the an auto-generated description
will be provided.
-}
arDescription : String -> Aria
arDescription =
    ArDescription


{-| Disable [ARIA attributes](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA)
when generating SVG output. Default is that Aria is enabled.
-}
arDisable : Aria
arDisable =
    ArAria False


{-| An [area mark](https://vega.github.io/vega-lite/docs/area.html) for representing
a series of data elements, such as in a stacked area chart or streamgraph.
-}
area : List MarkProperty -> ( VLProperty, Spec )
area =
    mark Area


{-| Enable [ARIA attributes](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA)
when generating SVG output. Default is that Aria is enabled, so this is only useful
when overriding more global disabling of Aria attributes.
-}
arEnable : Aria
arEnable =
    ArAria True


{-| Set [ARIA attributes](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA)
with the the given expression. For example,

    params
        << param "barDesc"
            [ paValue (dataObject [ ( "description", str "Bar chart bar" ) ]) ]

    bar [ maAria [ arExpr "barDesc" ] ]

-}
arExpr : String -> Aria
arExpr =
    ArExpr


{-| Flow arrangement in a repeated/faceted view.
-}
arFlow : Arrangement
arFlow =
    Flow


{-| Layer arrangement in a repeated view.
-}
arLayer : Arrangement
arLayer =
    Layer


{-| [Apache arrow](https://observablehq.com/@theneuralbit/introduction-to-apache-arrow)
data file format.

    data =
        dataFromUrl "https://gicentre.github.io/data/scrabble.arrow" [ arrow ]

-}
arrow : Format
arrow =
    Arrow


{-| Row arrangement in a repeated/faceted view.
-}
arRow : Arrangement
arRow =
    Row


{-| Interpret visualization dimensions to be for the data rectangle (external
padding added to this size).
-}
asContent : Autosize
asContent =
    AContent


{-| Interpret visualization dimensions to be for the entire visualization (data
rectangle is shrunk to accommodate external decorations padding).
-}
asFit : Autosize
asFit =
    AFit


{-| Interpret visualization width to be for the entire visualization width (data
rectangle width is shrunk to accommodate external decorations padding).
-}
asFitX : Autosize
asFitX =
    AFitX


{-| Interpret visualization height to be for the entire visualization height
(data rectangle height is shrunk to accommodate external decorations padding).
-}
asFitY : Autosize
asFitY =
    AFitY


{-| No autosizing to be applied.
-}
asNone : Autosize
asNone =
    ANone


{-| Automatically expand size of visualization from the given dimensions in order
to fit in all supplementary decorations (legends etc.).
-}
asPad : Autosize
asPad =
    APad


{-| Interpret visualization width to be for the entire visualization (data
rectangle is shrunk to accommodate external padding).
-}
asPadding : Autosize
asPadding =
    APadding


{-| Recalculate autosizing on every view update.
-}
asResize : Autosize
asResize =
    AResize


{-| Create a specification sufficient to define an element in a composed visualization
such as a superposed layer or juxtaposed facet. Typically a layer will contain a
full set of specifications that define a visualization with the exception of the
data specification which is usually defined outside of any one
layer. For repeated and faceted specs, the entire specification is provided.
-}
asSpec : List ( VLProperty, Spec ) -> Spec
asSpec specs =
    List.map (\( s, v ) -> ( vlPropertyLabel s, v )) specs
        |> JE.object


{-| Declare the way the view is sized. See the
[Vega-Lite autosize documentation](https://vega.github.io/vega-lite/docs/size.html#autosize).

    enc = ...
    toVegaLite
        [ width 250
        , height 300
        , autosize [ asFit, asPadding, asResize ]
        , dataFromUrl "data/population.json" []
        , bar []
        , enc []
        ]

-}
autosize : List Autosize -> ( VLProperty, Spec )
autosize aus =
    ( VLAutosize, JE.object (List.map autosizeProperty aus) )


{-| [ARIA](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA) properties
for providing accessible SVG output associated with an axis. If an empty list is
provided, ARIA tagging will be switched off.
-}
axAria : List Aria -> AxisProperty
axAria =
    AxAria


{-| Position of axis tick relative to a band (0 to 1).
-}
axBandPosition : Float -> AxisProperty
axBandPosition n =
    AxBandPosition (Num n)


{-| Default [ARIA](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA)
properties for providing accessible SVG output associated with an axis. If an empty
list is provided, ARIA tagging will be switched off.
-}
axcoAria : List Aria -> AxisConfig
axcoAria =
    AxisAria


{-| Default axis band position.
-}
axcoBandPosition : Float -> AxisConfig
axcoBandPosition =
    BandPosition


{-| Default appearance of axis.
-}
axcoDisable : Bool -> AxisConfig
axcoDisable =
    AxDisable


{-| Whether or not an axis domain should be displayed by default.
-}
axcoDomain : Bool -> AxisConfig
axcoDomain =
    Domain


{-| Default appearance of ends of axis domain.
-}
axcoDomainCap : StrokeCap -> AxisConfig
axcoDomainCap =
    DomainCap


{-| Default axis domain color.
-}
axcoDomainColor : String -> AxisConfig
axcoDomainColor =
    DomainColor


{-| Default dash style of axis baseline (domain). The parameter should list
number of pixels in alternating dash and gap lengths.
-}
axcoDomainDash : List Float -> AxisConfig
axcoDomainDash =
    DomainDash


{-| Default number of pixels before the first axis baseline (domain) line dash is drawn.
-}
axcoDomainDashOffset : Float -> AxisConfig
axcoDomainDashOffset =
    DomainDashOffset


{-| Default axis domain opacity.
-}
axcoDomainOpacity : Float -> AxisConfig
axcoDomainOpacity =
    DomainOpacity


{-| Default axis domain width style.
-}
axcoDomainWidth : Float -> AxisConfig
axcoDomainWidth =
    DomainWidth


{-| Whether or not an axis grid is displayed by default.
-}
axcoGrid : Bool -> AxisConfig
axcoGrid =
    Grid


{-| Default appearance of ends of grid lines.
-}
axcoGridCap : StrokeCap -> AxisConfig
axcoGridCap =
    GridCap


{-| Make an axis property (tick, grid or label) conditional on one or more predicate
expressions. The first parameter is the test to apply. The second is a pair of properties
to set if the test evaluates to true or false.

The test parameter has access to the axis properties `value` and `label` corresponding
to the value associated with an individual axis element and its text label. These
should be used rather than the underlying data field when referencing a data value.

     pAxis
        [ axDataCondition (expr "datum.value <= 2")
            (cAxTickColor "red" "blue")
        , axDataCondition (expr "datum.label =='4.0'")
            (cAxTickWidth 5 2)
        ]

You can also apply inline aggregation before applying the test using
[fiOpTrans](#fiOpTrans), which can be particularly useful for filtering temporal
data. For example, the following will apply solid grid lines for January 1st of
each year and dashes for all other dates:

    pAxis
        [ axDataCondition
            (fiEqual "value" (dt [ dtMonth Jan, dtDate 1 ])
                |> fiOpTrans (mTimeUnit monthDate)
            )
            (cAxGridDash [] [ 2, 2 ])
        ]

-}
axDataCondition : BooleanOp -> ConditionalAxisProperty -> AxisProperty
axDataCondition =
    AxDataCondition


{-| Default axis grid color style.
-}
axcoGridColor : String -> AxisConfig
axcoGridColor =
    GridColor


{-| Default axis line dash style.
-}
axcoGridDash : List Float -> AxisConfig
axcoGridDash =
    GridDash


{-| Default number of pixels before the first axis grid line dash is drawn.
-}
axcoGridDashOffset : Float -> AxisConfig
axcoGridDashOffset =
    GridDashOffset


{-| Default axis grid line opacity.
-}
axcoGridOpacity : Float -> AxisConfig
axcoGridOpacity =
    GridOpacity


{-| Default axis grid line width.
-}
axcoGridWidth : Float -> AxisConfig
axcoGridWidth =
    GridWidth


{-| Whether or not an axis has labels by default.
-}
axcoLabels : Bool -> AxisConfig
axcoLabels =
    Labels


{-| Default axis label horizontal alignment.
-}
axcoLabelAlign : HAlign -> AxisConfig
axcoLabelAlign =
    LabelAlign


{-| Default axis label angle (degrees from horizontal).
-}
axcoLabelAngle : Float -> AxisConfig
axcoLabelAngle =
    LabelAngle << positiveAngle


{-| Default axis label vertical alignment.
-}
axcoLabelBaseline : VAlign -> AxisConfig
axcoLabelBaseline =
    LabelBaseline


{-| Default axis label bounding when label exceeds available space. If `Nothing`,
no check for label size is made. A number specifies the permitted overflow in pixels.
-}
axcoLabelBound : Maybe Float -> AxisConfig
axcoLabelBound =
    LabelBound


{-| Default axis label color.
-}
axcoLabelColor : String -> AxisConfig
axcoLabelColor =
    LabelColor


{-| Default expression to generate axis labels. The parameter is a valid
[Vega expression](https://vega.github.io/vega/docs/expressions/). Can reference
`datum.value` and `datum.label` for access to the underlying data values and
default label text respectively.
-}
axcoLabelExpr : String -> AxisConfig
axcoLabelExpr =
    LabelExpr


{-| Default label alignment at beginning or end of the axis. Specifies the distance
threshold from an end-point within which labels are flush-adjusted or if `Nothing`,
no flush-adjustment made.
-}
axcoLabelFlush : Maybe Float -> AxisConfig
axcoLabelFlush =
    LabelFlush


{-| Default number of pixels by which to offset flush-adjusted labels.
-}
axcoLabelFlushOffset : Float -> AxisConfig
axcoLabelFlushOffset =
    LabelFlushOffset


{-| Default axis label font.
-}
axcoLabelFont : String -> AxisConfig
axcoLabelFont =
    LabelFont


{-| Default axis label font size.
-}
axcoLabelFontSize : Float -> AxisConfig
axcoLabelFontSize =
    LabelFontSize


{-| Default axis label font style (e.g. "italic")
-}
axcoLabelFontStyle : String -> AxisConfig
axcoLabelFontStyle =
    LabelFontStyle


{-| Default axis label font weight.
-}
axcoLabelFontWeight : FontWeight -> AxisConfig
axcoLabelFontWeight =
    LabelFontWeight


{-| Default axis label limit (how much a label can extend beyond the
left/bottom or right/top of the axis line).
-}
axcoLabelLimit : Float -> AxisConfig
axcoLabelLimit =
    LabelLimit


{-| Default axis label line height (useful for multi-line labels).
-}
axcoLabelLineHeight : Float -> AxisConfig
axcoLabelLineHeight =
    LabelLineHeight


{-| Default axis label overlap strategy for cases where labels cannot
fit within the allotted space.
-}
axcoLabelOverlap : OverlapStrategy -> AxisConfig
axcoLabelOverlap =
    LabelOverlap


{-| Default axis label opacity.
-}
axcoLabelOpacity : Float -> AxisConfig
axcoLabelOpacity =
    LabelOpacity


{-| Default axis label padding (space between labels in pixels).
-}
axcoLabelPadding : Float -> AxisConfig
axcoLabelPadding =
    LabelPadding


{-| Default axis label separation (minimum spacing between axis labels).
-}
axcoLabelSeparation : Float -> AxisConfig
axcoLabelSeparation =
    LabelSeparation


{-| Default maximum extent style.
-}
axcoMaxExtent : Float -> AxisConfig
axcoMaxExtent =
    MaxExtent


{-| Default minimum extent style.
-}
axcoMinExtent : Float -> AxisConfig
axcoMinExtent =
    MinExtent



{- | A list of named styles to apply as defaults to axes.

   axcoStyle : List String -> AxisConfig
   axcoStyle =
       AStyle
-}


{-| Default alignment of grid lines and ticks in band scales.
-}
axcoTickBand : TickBand -> AxisConfig
axcoTickBand =
    TickBand


{-| Default axis tick end cap style.
-}
axcoTickCap : StrokeCap -> AxisConfig
axcoTickCap =
    TickCap


{-| Default axis tick mark color.
-}
axcoTickColor : String -> AxisConfig
axcoTickColor =
    TickColor


{-| Default number of, or interval between, axis ticks. The resulting number of
ticks may be different so that values are “nice” (multiples of 2, 5, 10).
-}
axcoTickCount : ScaleNice -> AxisConfig
axcoTickCount =
    TickCount


{-| Default axis tick dash style. The parameter is a list of alternating 'on' and
'off' lengths in pixels representing the dashed line.
-}
axcoTickDash : List Float -> AxisConfig
axcoTickDash =
    TickDash


{-| Default number of pixels before the first axis tick dash is drawn.
-}
axcoTickDashOffset : Float -> AxisConfig
axcoTickDashOffset =
    TickDashOffset


{-| Whether or not by default an extra axis tick should be added for the initial
position of axes.
-}
axcoTickExtra : Bool -> AxisConfig
axcoTickExtra =
    TickExtra


{-| The minimum desired step between axis ticks, in terms of scale domain values.
For example, a value of `1` indicates that ticks should not be less than 1 unit
apart. If specified, the tick count\` value will be adjusted, if necessary, to
enforce the minimum step value.
-}
axcoTickMinStep : Float -> AxisConfig
axcoTickMinStep =
    TickMinStep


{-| Default offset in pixels of axis ticks, labels and gridlines.
-}
axcoTickOffset : Float -> AxisConfig
axcoTickOffset =
    TickOffset


{-| Default opacity of axis ticks.
-}
axcoTickOpacity : Float -> AxisConfig
axcoTickOpacity =
    TickOpacity


{-| Whether or not axis tick labels use rounded values by default.
-}
axcoTickRound : Bool -> AxisConfig
axcoTickRound =
    TickRound


{-| Whether or not an axis should show ticks by default.
-}
axcoTicks : Bool -> AxisConfig
axcoTicks =
    Ticks


{-| Default axis tick mark size.
-}
axcoTickSize : Float -> AxisConfig
axcoTickSize =
    TickSize


{-| Default axis tick mark width.
-}
axcoTickWidth : Float -> AxisConfig
axcoTickWidth =
    TickWidth


{-| Default axis tick label horizontal alignment.
-}
axcoTitleAlign : HAlign -> AxisConfig
axcoTitleAlign =
    TitleAlign


{-| Default anchor position of axis titles.
-}
axcoTitleAnchor : Anchor -> AxisConfig
axcoTitleAnchor =
    TitleAnchor


{-| Default axis title angle (degrees from horizontal).
-}
axcoTitleAngle : Float -> AxisConfig
axcoTitleAngle =
    TitleAngle << positiveAngle


{-| Default axis title vertical alignment.
-}
axcoTitleBaseline : VAlign -> AxisConfig
axcoTitleBaseline =
    TitleBaseline


{-| Default axis title color.
-}
axcoTitleColor : String -> AxisConfig
axcoTitleColor =
    TitleColor


{-| Default axis title font.
-}
axcoTitleFont : String -> AxisConfig
axcoTitleFont =
    TitleFont


{-| Default axis title font weight.
-}
axcoTitleFontWeight : FontWeight -> AxisConfig
axcoTitleFontWeight =
    TitleFontWeight


{-| Default axis title font size.
-}
axcoTitleFontSize : Float -> AxisConfig
axcoTitleFontSize =
    TitleFontSize


{-| Default axis title font style (e.g. "italic").
-}
axcoTitleFontStyle : String -> AxisConfig
axcoTitleFontStyle =
    TitleFontStyle


{-| Default axis title maximum size.
-}
axcoTitleLimit : Float -> AxisConfig
axcoTitleLimit =
    TitleLimit


{-| Default line height for multi-line axis titles.
-}
axcoTitleLineHeight : Float -> AxisConfig
axcoTitleLineHeight =
    TitleLineHeight


{-| Default opacity of axis titles.
-}
axcoTitleOpacity : Float -> AxisConfig
axcoTitleOpacity =
    TitleOpacity


{-| Default axis title padding between axis line and text.
-}
axcoTitlePadding : Float -> AxisConfig
axcoTitlePadding =
    TitlePadding


{-| Default axis x-position relative to the axis group.
-}
axcoTitleX : Float -> AxisConfig
axcoTitleX =
    TitleX


{-| Default axis y-position relative to the axis group.
-}
axcoTitleY : Float -> AxisConfig
axcoTitleY =
    TitleY


{-| Default coordinate space translation offset for axis layout.
-}
axcoTranslate : Float -> AxisConfig
axcoTranslate =
    TranslateAxis


{-| Whether or not an axis baseline (domain) should be included as part of an axis.
-}
axDomain : Bool -> AxisProperty
axDomain b =
    AxDomain (Boo b)


{-| How the ends of the axis baseline (domain) are capped.
-}
axDomainCap : StrokeCap -> AxisProperty
axDomainCap =
    AxDomainCap


{-| Color of axis domain line.
-}
axDomainColor : String -> AxisProperty
axDomainColor s =
    AxDomainColor (Str s)


{-| Dash style of axis baseline (domain). The parameter should list number of pixels
in alternating dash and gap lengths.
-}
axDomainDash : List Float -> AxisProperty
axDomainDash ns =
    AxDomainDash (Nums ns)


{-| Number of pixels before the first axis baseline (domain) line dash is drawn.
-}
axDomainDashOffset : Float -> AxisProperty
axDomainDashOffset n =
    AxDomainDashOffset (Num n)


{-| Opacity of axis domain line.
-}
axDomainOpacity : Float -> AxisProperty
axDomainOpacity n =
    AxDomainOpacity (Num n)


{-| Width of axis domain line.
-}
axDomainWidth : Float -> AxisProperty
axDomainWidth n =
    AxDomainWidth (Num n)


{-| [Formatting pattern](https://vega.github.io/vega-lite/docs/format.html) for
axis labels. To distinguish between formatting as numeric values and data/time values,
additionally use [axFormatAsNum](#axFormatAsNum), [axFormatAsTemporal](#axFormatAsTemporal)
or [axFormatAsCustom](#axFormatAsCustom).
-}
axFormat : String -> AxisProperty
axFormat s =
    AxFormat (Str s)


{-| Indicate that axis labels should be formatted as numbers. To control the precise
numeric format, additionally use [axFormat](#axFormat) providing a
[d3 numeric format string](https://github.com/d3/d3-format#locale_format).
-}
axFormatAsNum : AxisProperty
axFormatAsNum =
    AxFormatAsNum


{-| Indicate that axis labels should be formatted as dates/times. To control the
precise temporal format, additionally use [axFormat](#axFormat) providing a
[d3 date/time format string](https://github.com/d3/d3-time-format#locale_format).
-}
axFormatAsTemporal : AxisProperty
axFormatAsTemporal =
    AxFormatAsTemporal


{-| Indicate that axis labels should be formatted with a registered custom formatter
with the given name. See [how to register a Vega-Lite custom formatter](https://vega.github.io/vega-lite/usage/compile.html#format-type).
-}
axFormatAsCustom : String -> AxisProperty
axFormatAsCustom s =
    AxFormatAsCustom (Str s)


{-| Whether or not grid lines should be included as part of an axis.
-}
axGrid : Bool -> AxisProperty
axGrid b =
    AxGrid (Boo b)


{-| How the ends of gridlines are capped.
-}
axGridCap : StrokeCap -> AxisProperty
axGridCap =
    AxGridCap


{-| Color of grid lines associated with an axis.
-}
axGridColor : String -> AxisProperty
axGridColor s =
    AxGridColor (Str s)


{-| Axis grid lines dash style. The parameter is a list of alternating 'on' and
'off' lengths in pixels representing the dashed line.
-}
axGridDash : List Float -> AxisProperty
axGridDash ns =
    AxGridDash (Nums ns)


{-| Default number of pixels before the first axis grid line dash is drawn.
-}
axGridDashOffset : Float -> AxisProperty
axGridDashOffset n =
    AxGridDashOffset (Num n)


{-| Opacity of grid lines associated with an axis.
-}
axGridOpacity : Float -> AxisProperty
axGridOpacity n =
    AxGridOpacity (Num n)


{-| Width of grid lines associated with an axis.
-}
axGridWidth : Float -> AxisProperty
axGridWidth n =
    AxGridWidth (Num n)


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to an
axis property function requiring a Boolean value. This can be used to provide an
interactive parameterisation of an axis property when an expression is bound to
an input element. For example,

    ps =
        params
            << param "lbls"
                [ paValue (boo True)
                , paBind (ipCheckbox [])
                ]

    enc =
        encoding
            << position X
                [ pName "x"
                , pAxis [ axBooExpr "lbls" axLabels ]
                ]

-}
axBooExpr : String -> (Bool -> AxisProperty) -> AxisProperty
axBooExpr ex fn =
    case fn False of
        AxDomain _ ->
            AxDomain (BooExpr ex)

        AxLabels _ ->
            AxLabels (BooExpr ex)

        AxTickExtra _ ->
            AxTickExtra (BooExpr ex)

        AxTickRound _ ->
            AxTickRound (BooExpr ex)

        AxTicks _ ->
            AxTicks (BooExpr ex)

        AxGrid _ ->
            AxGrid (BooExpr ex)

        _ ->
            fn False


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to an
axis property function requiring a numeric value. This can be used for interactive
parameterisation when an expression is bound to an input element. For example,

    ps =
        params
            << param "axo"
                [ paValue (num 0)
                , paBind (ipRange [ inMax 20 ])
                ]

    enc =
        encoding
            << position X
                [ pName "x"
                , pAxis [ axNumExpr "axo" axOffset ]
                ]

-}
axNumExpr : String -> (number -> AxisProperty) -> AxisProperty
axNumExpr ex fn =
    case fn 0 of
        AxBandPosition _ ->
            AxBandPosition (NumExpr ex)

        AxMaxExtent _ ->
            AxMaxExtent (NumExpr ex)

        AxMinExtent _ ->
            AxMinExtent (NumExpr ex)

        AxOffset _ ->
            AxOffset (NumExpr ex)

        AxPosition _ ->
            AxPosition (NumExpr ex)

        AxTranslate _ ->
            AxTranslate (NumExpr ex)

        AxZIndex _ ->
            AxZIndex (NumExpr ex)

        AxDomainDashOffset _ ->
            AxDomainDashOffset (NumExpr ex)

        AxDomainOpacity _ ->
            AxDomainOpacity (NumExpr ex)

        AxDomainWidth _ ->
            AxDomainWidth (NumExpr ex)

        AxLabelAngle _ ->
            AxLabelAngle (NumExpr ex)

        AxLabelFlushOffset _ ->
            AxLabelFlushOffset (NumExpr ex)

        AxLabelFontSize _ ->
            AxLabelFontSize (NumExpr ex)

        AxLabelLineHeight _ ->
            AxLabelLineHeight (NumExpr ex)

        AxLabelLimit _ ->
            AxLabelLimit (NumExpr ex)

        AxLabelOffset _ ->
            AxLabelOffset (NumExpr ex)

        AxLabelOpacity _ ->
            AxLabelOpacity (NumExpr ex)

        AxLabelPadding _ ->
            AxLabelPadding (NumExpr ex)

        AxLabelSeparation _ ->
            AxLabelSeparation (NumExpr ex)

        AxTickDashOffset _ ->
            AxTickDashOffset (NumExpr ex)

        AxTickOffset _ ->
            AxTickOffset (NumExpr ex)

        AxTickOpacity _ ->
            AxTickOpacity (NumExpr ex)

        AxTickSize _ ->
            AxTickSize (NumExpr ex)

        AxTickWidth _ ->
            AxTickWidth (NumExpr ex)

        AxTitleAngle _ ->
            AxTitleAngle (NumExpr ex)

        AxTitleFontSize _ ->
            AxTitleFontSize (NumExpr ex)

        AxTitleLimit _ ->
            AxTitleLimit (NumExpr ex)

        AxTitleLineHeight _ ->
            AxTitleLineHeight (NumExpr ex)

        AxTitleOpacity _ ->
            AxTitleOpacity (NumExpr ex)

        AxTitlePadding _ ->
            AxTitlePadding (NumExpr ex)

        AxTitleX _ ->
            AxTitleX (NumExpr ex)

        AxTitleY _ ->
            AxTitleY (NumExpr ex)

        AxGridDashOffset _ ->
            AxGridDashOffset (NumExpr ex)

        AxGridOpacity _ ->
            AxGridOpacity (NumExpr ex)

        AxGridWidth _ ->
            AxGridWidth (NumExpr ex)

        AxTickMinStep _ ->
            AxTickMinStep (NumExpr ex)

        _ ->
            fn 0


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to
an axis property function requiring a list of numbers (for dash styles). This can
be used to provide an interactive parameterisation of an axis dash property when
an expression is bound to an input element. For example,

    ps =
        params
            << param "gridDash"
                [ paValue (nums [ 2, 2 ])
                , paBind (ipSelect [ inDataOptions [ nums [ 2, 2 ], nums [ 8, 8 ] ] ])
                ]

    enc =
        encoding
            << position X [ pAxis [ axNumsExpr "gridDash" axGridDash ] ]

-}
axNumsExpr : String -> (List number -> AxisProperty) -> AxisProperty
axNumsExpr ex fn =
    case fn [] of
        AxDomainDash _ ->
            AxDomainDash (NumsExpr ex)

        AxGridDash _ ->
            AxGridDash (NumsExpr ex)

        AxTickDash _ ->
            AxTickDash (NumsExpr ex)

        _ ->
            fn []


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to
an axis property function requiring a string value. This can be used to provide an
interactive parameterisation of an axis property when an expression is bound to an
input element. For example,

    ps =
        params
            << param "color"
                [ paValue (str "black")
                , paBind (ipColor [])
                ]

    enc =
        encoding
            << position X
                [ pName "x"
                , pAxis [ axStrExpr "color" axTitleColor ]
                ]

-}
axStrExpr : String -> (String -> AxisProperty) -> AxisProperty
axStrExpr ex fn =
    case fn "" of
        AxDomainColor _ ->
            AxDomainColor (StrExpr ex)

        AxFormat _ ->
            AxFormat (StrExpr ex)

        AxFormatAsCustom _ ->
            AxFormatAsCustom (StrExpr ex)

        AxLabelColor _ ->
            AxLabelColor (StrExpr ex)

        AxLabelExpr _ ->
            AxLabelExpr (StrExpr ex)

        AxLabelFont _ ->
            AxLabelFont (StrExpr ex)

        AxLabelFontStyle _ ->
            AxLabelFontStyle (StrExpr ex)

        AxTickColor _ ->
            AxTickColor (StrExpr ex)

        AxTitle _ ->
            AxTitle (StrExpr ex)

        AxTitleColor _ ->
            AxTitleColor (StrExpr ex)

        AxTitleFont _ ->
            AxTitleFont (StrExpr ex)

        AxTitleFontStyle _ ->
            AxTitleFontStyle (StrExpr ex)

        AxGridColor _ ->
            AxGridColor (StrExpr ex)

        _ ->
            fn ""


{-| Horizontal alignment of axis tick labels.
-}
axLabelAlign : HAlign -> AxisProperty
axLabelAlign =
    AxLabelAlign


{-| Vertical alignment of axis tick labels.
-}
axLabelBaseline : VAlign -> AxisProperty
axLabelBaseline =
    AxLabelBaseline


{-| How or if labels should be hidden if they exceed the axis range. If
`Nothing`, no check for label size is made. A number specifies the permitted
overflow in pixels.
-}
axLabelBound : Maybe Float -> AxisProperty
axLabelBound mn =
    AxLabelBound (MaybeNum mn)


{-| Expression that evaluates to True, False or a number depending whether a check
is to be made for an axis label size. A number specifies the permitted overflow
in pixels.
-}
axLabelBoundExpr : String -> AxisProperty
axLabelBoundExpr ex =
    AxLabelBound (MaybeNumExpr ex)


{-| Color of axis tick label.
-}
axLabelColor : String -> AxisProperty
axLabelColor s =
    AxLabelColor (Str s)


{-| An expression to generate axis labels. The parameter is a valid
[Vega expression](https://vega.github.io/vega/docs/expressions/). Can reference
`datum.value` and `datum.label` for access to the underlying data values and
default label text respectively. For example, to provide 4 digit years every decade
and 2-digit years for all other tick marks:

    pAxis
        [ axLabelExpr "if(year(datum.value) % 10 == 0"
            ++ ", utcFormat(datum.value,'%Y')"
            ++ ", utcFormat(datum.value,'%y'))"
        ]

-}
axLabelExpr : String -> AxisProperty
axLabelExpr s =
    AxLabelExpr (Str s)


{-| How or if labels at beginning or end of the axis should be aligned. Specifies
the distance threshold from an end-point within which labels are flush-adjusted
or if `Nothing`, no flush-adjustment made.
-}
axLabelFlush : Maybe Float -> AxisProperty
axLabelFlush =
    AxLabelFlush


{-| Number of pixels by which to offset flush-adjusted labels.
-}
axLabelFlushOffset : Float -> AxisProperty
axLabelFlushOffset n =
    AxLabelFlushOffset (Num n)


{-| Font name of an axis label.
-}
axLabelFont : String -> AxisProperty
axLabelFont s =
    AxLabelFont (Str s)


{-| Font size of an axis label.
-}
axLabelFontSize : Float -> AxisProperty
axLabelFontSize n =
    AxLabelFontSize (Num n)


{-| Font style of an axis label (e.g. "italic")
-}
axLabelFontStyle : String -> AxisProperty
axLabelFontStyle s =
    AxLabelFontStyle (Str s)


{-| Font weight of an axis label.
-}
axLabelFontWeight : FontWeight -> AxisProperty
axLabelFontWeight =
    AxLabelFontWeight


{-| Maximum length in pixels of axis tick labels.
-}
axLabelLimit : Float -> AxisProperty
axLabelLimit n =
    AxLabelLimit (Num n)


{-| Axis label line height (useful for multi-line labels).
-}
axLabelLineHeight : Float -> AxisProperty
axLabelLineHeight n =
    AxLabelLineHeight (Num n)


{-| Offset in pixels of an axis's labels relative to its ticks.
-}
axLabelOffset : Float -> AxisProperty
axLabelOffset n =
    AxLabelOffset (Num n)


{-| Opacity of an axis label.
-}
axLabelOpacity : Float -> AxisProperty
axLabelOpacity n =
    AxLabelOpacity (Num n)


{-| Rotation angle of axis labels (degrees from horizontal).
-}
axLabelAngle : Float -> AxisProperty
axLabelAngle n =
    AxLabelAngle (Num (positiveAngle n))


{-| Overlap strategy for labels when they are too large to fit within the space
devoted to an axis.
-}
axLabelOverlap : OverlapStrategy -> AxisProperty
axLabelOverlap =
    AxLabelOverlap


{-| Padding in pixels between an axis and its text labels.
-}
axLabelPadding : Float -> AxisProperty
axLabelPadding n =
    AxLabelPadding (Num n)


{-| The minimum separation between labels (in pixel units) before they are considered
non-overlapping. Ignored if [axLabelOverlap](#axLabelOverlap) is [osNone](#osNone).
-}
axLabelSeparation : Float -> AxisProperty
axLabelSeparation n =
    AxLabelSeparation (Num n)


{-| Whether or not axis labels should be displayed.
-}
axLabels : Bool -> AxisProperty
axLabels b =
    AxLabels (Boo b)


{-| Maximum extent in pixels that axis ticks and labels should use.
-}
axMaxExtent : Float -> AxisProperty
axMaxExtent n =
    AxMaxExtent (Num n)


{-| Minimum extent in pixels that axis ticks and labels should use.
-}
axMinExtent : Float -> AxisProperty
axMinExtent n =
    AxMinExtent (Num n)


{-| Offset to displace the axis from the edge of the enclosing group or data rectangle.
-}
axOffset : Float -> AxisProperty
axOffset n =
    AxOffset (Num n)


{-| Orientation of an axis relative to the plot it is describing.
-}
axOrient : Side -> AxisProperty
axOrient =
    AxOrient


{-| Anchor position of the axis in pixels. For x-axis with top or
bottom orientation, this sets the axis group x coordinate. For y-axis with left
or right orientation, this sets the axis group y coordinate.
-}
axPosition : Float -> AxisProperty
axPosition n =
    AxPosition (Num n)


{-| A list of named styles to apply to an axis. Named styles can be specified via
[coAxisStyles](#coAxisStyles). Later styles in the list will override earlier
styles if there is a conflict in any of the properties specified.

While this is provided for compatibility with Vega-Lite style specification, for
greater type safety in elm-vegalite, instead create functions that generate
[AxisProperties](#AxisProperty).

-}
axStyle : List String -> AxisProperty
axStyle =
    AxStyle


{-| Where grid and ticks should be aligned with bands.
-}
axTickBand : TickBand -> AxisProperty
axTickBand =
    AxTickBand


{-| How the ends of axis ticks are capped.
-}
axTickCap : StrokeCap -> AxisProperty
axTickCap =
    AxTickCap


{-| Color of axis ticks.
-}
axTickColor : String -> AxisProperty
axTickColor s =
    AxTickColor (Str s)


{-| Desired number of, or interval between, axis ticks. The resulting number of
ticks may be different so that values are “nice” (multiples of 2, 5, 10).
-}
axTickCount : ScaleNice -> AxisProperty
axTickCount =
    AxTickCount


{-| Axis tick dash style. The parameter is a list of alternating 'on' and 'off'
lengths in pixels representing the dashed line.
-}
axTickDash : List Float -> AxisProperty
axTickDash ns =
    AxTickDash (Nums ns)


{-| Number of pixels before the first axis tick dash is drawn.
-}
axTickDashOffset : Float -> AxisProperty
axTickDashOffset n =
    AxTickDashOffset (Num n)


{-| Whether or not an extra axis tick should be added for the initial position
of an axis.
-}
axTickExtra : Bool -> AxisProperty
axTickExtra b =
    AxTickExtra (Boo b)


{-| The minimum desired step between axis ticks, in terms of scale domain values.
For example, a value of `1` indicates that ticks should not be less than 1 unit
apart. If specified, the tick count value will be adjusted, if necessary, to
enforce the minimum step value.
-}
axTickMinStep : Float -> AxisProperty
axTickMinStep n =
    AxTickMinStep (Num n)


{-| Offset in pixels of an axis's ticks, labels and gridlines.
-}
axTickOffset : Float -> AxisProperty
axTickOffset n =
    AxTickOffset (Num n)


{-| Opacity of axis ticks.
-}
axTickOpacity : Float -> AxisProperty
axTickOpacity n =
    AxTickOpacity (Num n)


{-| Whether or not axis tick positions should be rounded to nearest integer.
-}
axTickRound : Bool -> AxisProperty
axTickRound b =
    AxTickRound (Boo b)


{-| Whether or not an axis should include tick marks.
-}
axTicks : Bool -> AxisProperty
axTicks b =
    AxTicks (Boo b)


{-| Tick mark size in pixels.
-}
axTickSize : Float -> AxisProperty
axTickSize n =
    AxTickSize (Num n)


{-| Width of axis ticks.
-}
axTickWidth : Float -> AxisProperty
axTickWidth n =
    AxTickWidth (Num n)


{-| Title to display as part of an axis. An empty string can be used to prevent
a title being displayed. For multi-line titles, insert `\n` at each line break or
use a `"""` multi-line string.
-}
axTitle : String -> AxisProperty
axTitle s =
    AxTitle (Str s)


{-| Horizontal alignment of an axis title.
-}
axTitleAlign : HAlign -> AxisProperty
axTitleAlign =
    AxTitleAlign


{-| Anchor position of an axis title.
-}
axTitleAnchor : Anchor -> AxisProperty
axTitleAnchor =
    AxTitleAnchor


{-| Angle of an axis title (degrees from horizontal).
-}
axTitleAngle : Float -> AxisProperty
axTitleAngle n =
    AxTitleAngle (Num (positiveAngle n))


{-| Vertical alignment of axis title.
-}
axTitleBaseline : VAlign -> AxisProperty
axTitleBaseline =
    AxTitleBaseline


{-| Color of axis title.
-}
axTitleColor : String -> AxisProperty
axTitleColor s =
    AxTitleColor (Str s)


{-| Font name for an axis title.
-}
axTitleFont : String -> AxisProperty
axTitleFont s =
    AxTitleFont (Str s)


{-| Font size of an axis title.
-}
axTitleFontSize : Float -> AxisProperty
axTitleFontSize n =
    AxTitleFontSize (Num n)


{-| Font style of an axis title (e.g. "italic").
-}
axTitleFontStyle : String -> AxisProperty
axTitleFontStyle s =
    AxTitleFontStyle (Str s)


{-| Font weight of an axis title.
-}
axTitleFontWeight : FontWeight -> AxisProperty
axTitleFontWeight =
    AxTitleFontWeight


{-| Maximum length in pixels of axis title.
-}
axTitleLimit : Float -> AxisProperty
axTitleLimit n =
    AxTitleLimit (Num n)


{-| Line height for multi-line axis titles.
-}
axTitleLineHeight : Float -> AxisProperty
axTitleLineHeight n =
    AxTitleLineHeight (Num n)


{-| Opacity of an axis title.
-}
axTitleOpacity : Float -> AxisProperty
axTitleOpacity n =
    AxTitleOpacity (Num n)


{-| Padding in pixels between a title and axis.
-}
axTitlePadding : Float -> AxisProperty
axTitlePadding n =
    AxTitlePadding (Num n)


{-| X position of an axis title relative to the axis group.
-}
axTitleX : Float -> AxisProperty
axTitleX n =
    AxTitleX (Num n)


{-| Y position of an axis title relative to the axis group.
-}
axTitleY : Float -> AxisProperty
axTitleY n =
    AxTitleY (Num n)


{-| Coordinate space translation offset for axis layout. By default, axes are translated
by 0.5 pixels for both the x and y coordinates in order to align stroked lines with
the pixel grid. This translation can be changed, for example, to zero.
-}
axTranslate : Float -> AxisProperty
axTranslate n =
    AxTranslate (Num n)


{-| Set explicit tick/grid/label values along an axis. For example, for a
quantitative field:

    pAxis [ axValues (nums [ 2, 3, 5, 7, 11, 13, 17 ]) ]

or a categorical field:

    pAxis [ axValues (strs [ "cats", "dogs", "parrots" ]) ]

or for a temporal field:

    pAxis
        [ axValues
            (dts
                [ [ dtYear 2019, dtMonth Mar, dtDate 31 ]
                , [ dtYear 2019, dtMonth Jun, dtDate 30 ]
                , [ dtYear 2019, dtMonth Sep, dtDate 30 ]
                , [ dtYear 2019, dtMonth Dec, dtDate 31 ]
                ]
            )
        ]

-}
axValues : DataValues -> AxisProperty
axValues =
    AxValues


{-| Indicate configuration should be applied to the x-axis only.
-}
axX : AxisChoice
axX =
    AxX


{-| Indicate configuration should be applied to the y-axis only.
-}
axY : AxisChoice
axY =
    AxY


{-| Drawing order of the axis and its associated features (grid lines, ticks etc.)
relative to the other chart elements. A value greater than 0 indicates axis is
drawn in front of chart marks, 0 indicates it is drawn behind them. The z-order
of intersecting grid lines associated with x- and y- axes can be controlled by
assigning a higher z-value to the axis to appear on top.
-}
axZIndex : Int -> AxisProperty
axZIndex n =
    AxZIndex (Num (toFloat n))


{-| An azimuthal equal area map projection.
-}
azimuthalEqualArea : Projection
azimuthalEqualArea =
    AzimuthalEqualArea


{-| An azimuthal equidistant map projection.
-}
azimuthalEquidistant : Projection
azimuthalEquidistant =
    AzimuthalEquidistant


{-| Background color of the entire visualization. For view compositions, single
views or layers can have their own background styles in addition to this global
background color. Should be specified with a CSS
string such as `#ffe` or `rgb(200,20,150)`. If not specified the background will
be white.
-}
background : String -> ( VLProperty, Spec )
background colour =
    ( VLBackground, JE.string colour )


{-| Expression that evaluates to a colour used for the visualization background.
Useful when the colour is to be determined at runtime though an interaction element
such as [ipColor](#ipColor).
-}
backgroundExpr : String -> ( VLProperty, Spec )
backgroundExpr s =
    ( VLBackgroundExpr, JE.object [ ( "expr", JE.string s ) ] )


{-| [Bar mark](https://vega.github.io/vega-lite/docs/bar.html) for histograms,
bar charts etc.
-}
bar : List MarkProperty -> ( VLProperty, Spec )
bar =
    mark Bar


{-| Value in the binned domain at which to anchor the binning. Boundaries are
possibly shifted to ensure they align with the anchor value.
-}
biAnchor : Float -> BinProperty
biAnchor =
    BiAnchor


{-| Number base to use for automatic bin determination (default is base 10).
-}
biBase : Float -> BinProperty
biBase =
    Base


{-| Scale factors indicating allowable subdivisions for binning. The default value
is [5, 2], which indicates that for base 10 numbers (the default base), binning
will consider dividing bin sizes by 5 and/or 2.
-}
biDivide : List Float -> BinProperty
biDivide =
    Divides


{-| Desired extent of bin values when binning a collection of values.
The first and second parameters indicate the minimum and maximum extent.
To base a binning extent on an interactive selection, use
[biSelectionExtent](#biSelectionExtent) instead.
-}
biExtent : Float -> Float -> BinProperty
biExtent =
    Extent


{-| Maximum number of bins when binning a collection of values.
-}
biMaxBins : Int -> BinProperty
biMaxBins =
    MaxBins


{-| Step size between bins when binning a collection of values.
-}
biMinStep : Float -> BinProperty
biMinStep =
    MinStep


{-| Whether or not binning boundaries use human-friendly values such as multiples
of ten.
-}
biNice : Bool -> BinProperty
biNice =
    Nice


{-| Binning transformation that may be referenced in other transformations or
encodings. The first parameter is a list of customisation options ([biBase](#biBase),
[biDivide](#biDivide) etc.) or an empty list to use the default binning. The second
is the field to bin and the third the name to give the output binned data.

    trans =
        transform
            << binAs [ biMaxBins 3 ] "IMDB_Rating" "ratingGroup"

Note that usually, direct binning within an encoding is preferred over this form
of bin transformation.

-}
binAs : List BinProperty -> String -> String -> List LabelledSpec -> List LabelledSpec
binAs bProps field label =
    case bProps of
        [] ->
            (::)
                ( "multiSpecs"
                , JE.object
                    [ ( "bin", JE.bool True )
                    , ( "field", JE.string field )
                    , ( "as", JE.string label )
                    ]
                )

        _ ->
            (::)
                ( "multiSpecs"
                , JE.object
                    [ ( "bin", JE.object (List.map binProperty bProps) )
                    , ( "field", JE.string field )
                    , ( "as", JE.string label )
                    ]
                )


{-| Set the desired range of bin values based on an interactive selection. The
parameter should be the name of an interval selection parameter that defines the
extent.

    ps =
        params
            << param "brush" [ paSelect seInterval [ seEncodings [ chX ] ] ]

    enc =
        encoding
            << position X
                [ pName "temperature"
                , pBin [ biSelectionExtent "brush" ]
                ]

-}
biSelectionExtent : String -> BinProperty
biSelectionExtent =
    SelectionExtent


{-| Step size between bins when binning a collection of values.
-}
biStep : Float -> BinProperty
biStep =
    Step


{-| Allowable step sizes between bins when binning a collection of values.
-}
biSteps : List Float -> BinProperty
biSteps =
    Steps


{-| Deprecated in favour of setting the channel in [param](#param).
-}
blChannel : Channel -> BindLegendProperty
blChannel =
    BLChannel


{-| Deprecated in favour of setting the event stream with [paBindLegend](#paBindLegend).
-}
blEvent : String -> BindLegendProperty
blEvent =
    BLEvent


{-| Deprecated in favour of setting the field in [param](#param).
-}
blField : String -> BindLegendProperty
blField =
    BLField


{-| Color blend mode to be applied when drawing over some background.
-}
bmColor : BlendMode
bmColor =
    BMColor


{-| Color burn blend mode to be applied when drawing over some background.
-}
bmColorBurn : BlendMode
bmColorBurn =
    BMColorBurn


{-| Color dodge blend mode to be applied when drawing over some background.
-}
bmColorDodge : BlendMode
bmColorDodge =
    BMColorDodge


{-| Darken blend mode to be applied when drawing over some background.
-}
bmDarken : BlendMode
bmDarken =
    BMDarken


{-| Expression that evaluates to some blend mode such as "darken", "hue" or
"luminosity".
-}
bmExpr : String -> BlendMode
bmExpr =
    BMExpr


{-| Difference blend mode to be applied when drawing over some background.
-}
bmDifference : BlendMode
bmDifference =
    BMDifference


{-| Exclusion blend mode to be applied when drawing over some background.
-}
bmExclusion : BlendMode
bmExclusion =
    BMExclusion


{-| Hard light blend mode to be applied when drawing over some background.
-}
bmHardLight : BlendMode
bmHardLight =
    BMHardLight


{-| Hue blend mode to be applied when drawing over some background.
-}
bmHue : BlendMode
bmHue =
    BMHue


{-| Lighten blend mode to be applied when drawing over some background.
-}
bmLighten : BlendMode
bmLighten =
    BMLighten


{-| Luminosity blend mode to be applied when drawing over some background.
-}
bmLuminosity : BlendMode
bmLuminosity =
    BMLuminosity


{-| Multiplicative blend mode to be applied when drawing over some background.
-}
bmMultiply : BlendMode
bmMultiply =
    BMMultiply


{-| Indicate the default blend mode should be applied when drawing over some background.
-}
bmNormal : BlendMode
bmNormal =
    BMNormal


{-| Overlay blend mode to be applied when drawing over some background.
-}
bmOverlay : BlendMode
bmOverlay =
    BMOverlay


{-| Saturation blend mode to be applied when drawing over some background.
-}
bmSaturation : BlendMode
bmSaturation =
    BMSaturation


{-| Screen blend mode to be applied when drawing over some background.
-}
bmScreen : BlendMode
bmScreen =
    BMScreen


{-| Soft light blend mode to be applied when drawing over some background.
-}
bmSoftLight : BlendMode
bmSoftLight =
    BMSoftLight


{-| Bounds calculation should take only the specified width and height values for
a sub-view. Useful when attempting to place sub-plots without axes or legends into
a uniform grid structure.
-}
boFlush : Bounds
boFlush =
    Flush


{-| Bounds calculation should use the entire plot area (including axes, title,
and legend).
-}
boFull : Bounds
boFull =
    Full


{-| A Boolean data value.
-}
boo : Bool -> DataValue
boo =
    Boolean


{-| A list of Boolean data values. Used when declaring inline data with
[dataColumn](#dataColumn), filtering ([fiOneOf](#fiOneOf)), imputation
([imKeyVals](#imKeyVals)) and customised sorting ([soCustom](#soCustom)).
-}
boos : List Bool -> DataValues
boos =
    Booleans


{-| Bounds calculation method to use for determining the extent of a sub-plot in
a composed view. If set to `Full` the entire calculated bounds including axes,
title and legend are used; if `Flush` only the width and height values for the
sub-view will be used.
-}
bounds : Bounds -> ( VLProperty, Spec )
bounds bnds =
    ( VLBounds, boundsSpec bnds )


{-| [Boxplot composite mark](https://vega.github.io/vega-lite/docs/boxplot.html)
for showing summaries of statistical distributions. By default, just box and whiskers
are shown, but ticks and outliers can be specified explicitly.

    boxplot
        [ maTicks [ maColor "black", maSize 8 ]
        , maBox [ maFill "grey" ]
        , maOutliers [ maColor "firebrick" ]
        ]

-}
boxplot : List MarkProperty -> ( VLProperty, Spec )
boxplot =
    mark Boxplot


{-| Treat a parameter as a boolean expression that may be composed to form more
complex boolean expressions. Can be used when composing selections from multiple
parameters. For example, if we have two interval selection parameters `alex` and
`morgan` we can conditionally colour if both selections intersect.

    color
        [ mCondition (prTest (and (bParam "alex") (bParam "morgan")))
            [ mStr "red" ]
            [ mStr "gray" ]
        ]

-}
bParam : String -> BooleanOp
bParam =
    BooleanParam


{-| Subviews in a composed view to be aligned into a clean grid structure where
all rows and columns are of the same size (based on maximum subview size).
-}
caAll : CompositionAlignment
caAll =
    CAAll


{-| Butt stroke cap.
-}
caButt : StrokeCap
caButt =
    CButt


{-| Subviews in a composed view to be aligned into a clean grid structure where
each row or column may be of variable size.
-}
caEach : CompositionAlignment
caEach =
    CAEach


{-| Expression that evaluates to some stroke cap style such as "square", "butt" or "round".
-}
caExpr : String -> StrokeCap
caExpr =
    CExpr


{-| Generate a new data field based on some calculations from existing values and fields.
The first parameter is an [expression](https://vega.github.io/vega/docs/expressions/)
representing the calculation and the second is the name to give the newly calculated
field.

    trans =
        transform << calculateAs "datum.sex == 2 ? 'F' : 'M'" "gender"

-}
calculateAs : String -> String -> List LabelledSpec -> List LabelledSpec
calculateAs ex label =
    (::)
        ( "multiSpecs"
        , JE.object
            [ ( "calculate", JE.string ex )
            , ( "as", JE.string label )
            ]
        )


{-| Flow layout is to be applied to composed views, in which adjacent subviews
are placed one after the other.
-}
caNone : CompositionAlignment
caNone =
    CANone


{-| Rounded stroke cap.
-}
caRound : StrokeCap
caRound =
    CRound


{-| Square stroke cap.
-}
caSquare : StrokeCap
caSquare =
    CSquare


{-| Create a set of discrete domain to color mappings suitable for customising categorical
scales. The first item in each tuple should be a domain value and the second the
color value with which it should be associated. It is a convenience function equivalent
to specifying separate `scDomain` and `scRange` lists and is safer as it guarantees
a one-to-one correspondence between domain and range values.

    color
        [ mName "weather"
        , mNominal
        , categoricalDomainMap
            [ ( "sun", "yellow" )
            , ( "rain", "blue" )
            , ( "fog", "grey" )
            ]
            |> mScale
        ]

-}
categoricalDomainMap : List ( String, String ) -> List ScaleProperty
categoricalDomainMap scaleDomainPairs =
    let
        ( domain, range ) =
            List.unzip scaleDomainPairs
    in
    [ SDomain (DStrings domain), SRange (RStrings (Strs range)) ]


{-| Conditional axis label alignment. The first parameter provides the alignment
when a predicate is true, the second when it is false.
-}
cAxLabelAlign : HAlign -> HAlign -> ConditionalAxisProperty
cAxLabelAlign =
    CAxLabelAlign


{-| Conditional axis vertical label alignment. The first parameter provides the
alignment when a predicate is true, the second when it is false.
-}
cAxLabelBaseline : VAlign -> VAlign -> ConditionalAxisProperty
cAxLabelBaseline =
    CAxLabelBaseline


{-| Conditional axis label color. The first parameter provides the color
when a predicate is true, the second when it is false.
-}
cAxLabelColor : String -> String -> ConditionalAxisProperty
cAxLabelColor =
    CAxLabelColor


{-| Conditional axis label font. The first parameter provides the font
when a predicate is true, the second when it is false.
-}
cAxLabelFont : String -> String -> ConditionalAxisProperty
cAxLabelFont =
    CAxLabelFont


{-| Conditional axis label font size. The first parameter provides the size
when a predicate is true, the second when it is false.
-}
cAxLabelFontSize : Float -> Float -> ConditionalAxisProperty
cAxLabelFontSize =
    CAxLabelFontSize


{-| Conditional axis label font style. The first parameter provides the style
when a predicate is true, the second when it is false.
-}
cAxLabelFontStyle : String -> String -> ConditionalAxisProperty
cAxLabelFontStyle =
    CAxLabelFontStyle


{-| Conditional axis label font weight. The first parameter provides the weight
when a predicate is true, the second when it is false.
-}
cAxLabelFontWeight : FontWeight -> FontWeight -> ConditionalAxisProperty
cAxLabelFontWeight =
    CAxLabelFontWeight


{-| Conditional axis label offset. The first parameter provides the offset
when a predicate is true, the second when it is false.
-}
cAxLabelOffset : Float -> Float -> ConditionalAxisProperty
cAxLabelOffset =
    CAxLabelOffset


{-| Conditional axis label opacity. The first parameter provides the opacity
when a predicate is true, the second when it is false.
-}
cAxLabelOpacity : Float -> Float -> ConditionalAxisProperty
cAxLabelOpacity =
    CAxLabelOpacity


{-| Conditional axis label padding. The first parameter provides the padding
when a predicate is true, the second when it is false.
-}
cAxLabelPadding : Float -> Float -> ConditionalAxisProperty
cAxLabelPadding =
    CAxLabelPadding


{-| Conditional axis tick color. The first parameter provides the color when a
predicate is true, the second when it is false.
-}
cAxTickColor : String -> String -> ConditionalAxisProperty
cAxTickColor =
    CAxTickColor


{-| Conditional axis tick dash style. The first parameter is a list of alternating
'on' and 'off' lengths in pixels representing the dashed line when a predicate
is true, the second when it is false.
-}
cAxTickDash : List Float -> List Float -> ConditionalAxisProperty
cAxTickDash =
    CAxTickDash


{-| Conditional axis tick dash offset. The first parameter provides the dash offset
when a predicate is true, the second when it is false.
-}
cAxTickDashOffset : Float -> Float -> ConditionalAxisProperty
cAxTickDashOffset =
    CAxTickDashOffset


{-| Conditional axis tick opacity. The first parameter provides the opacity when
a predicate is true, the second when it is false.
-}
cAxTickOpacity : Float -> Float -> ConditionalAxisProperty
cAxTickOpacity =
    CAxTickOpacity


{-| Conditional axis tick size. The first parameter provides the size when a
predicate is true, the second when it is false.
-}
cAxTickSize : Float -> Float -> ConditionalAxisProperty
cAxTickSize =
    CAxTickSize


{-| Conditional axis tick width. The first parameter provides the width when a
predicate is true, the second when it is false.
-}
cAxTickWidth : Float -> Float -> ConditionalAxisProperty
cAxTickWidth =
    CAxTickWidth


{-| Conditional axis grid color. The first parameter provides the color when a
predicate is true, the second when it is false.
-}
cAxGridColor : String -> String -> ConditionalAxisProperty
cAxGridColor =
    CAxGridColor


{-| Conditional axis grid dash. The first parameter provides the dash when a
predicate is true, the second when it is false.
-}
cAxGridDash : List Float -> List Float -> ConditionalAxisProperty
cAxGridDash =
    CAxGridDash


{-| Conditional axis grid dash offset. The first parameter provides the dash offset
when a predicate is true, the second when it is false.
-}
cAxGridDashOffset : Float -> Float -> ConditionalAxisProperty
cAxGridDashOffset =
    CAxGridDashOffset


{-| Conditional axis grid opacity. The first parameter provides the opacity when
a predicate is true, the second when it is false.
-}
cAxGridOpacity : Float -> Float -> ConditionalAxisProperty
cAxGridOpacity =
    CAxGridOpacity


{-| Conditional axis grid width. The first parameter provides the width when a
predicate is true, the second when it is false.
-}
cAxGridWidth : Float -> Float -> ConditionalAxisProperty
cAxGridWidth =
    CAxGridWidth


{-| Whether or not sub-views specified in a composition operator should be centred
relative to their respective rows and columns.
-}
center : Bool -> ( VLProperty, Spec )
center c =
    ( VLCenter, JE.bool c )


{-| Similar to [center](#center) but with independent centring for rows and columns.
-}
centerRC : Bool -> Bool -> ( VLProperty, Spec )
centerRC cRow cCol =
    ( VLCenter, JE.object [ ( "row", JE.bool cRow ), ( "col", JE.bool cCol ) ] )


{-| Color channel to be used in a resolution specification
-}
chColor : Channel
chColor =
    ChColor


{-| Opacity channel to be used in a resolution specification
-}
chOpacity : Channel
chOpacity =
    ChOpacity


{-| Shape channel to be used in a resolution specification
-}
chShape : Channel
chShape =
    ChShape


{-| Size channel to be used in a resolution specification
-}
chSize : Channel
chSize =
    ChSize


{-| Stroke dash channel to be used in a resolution specification
-}
chStrokeDash : Channel
chStrokeDash =
    ChStrokeDash


{-| X-channel to be used in a resolution specification
-}
chX : Channel
chX =
    ChX


{-| X2-channel to be used in a resolution specification
-}
chX2 : Channel
chX2 =
    ChX2


{-| Y-channel to be used in a resolution specification
-}
chY : Channel
chY =
    ChY


{-| Y2-channel to be used in a resolution specification
-}
chY2 : Channel
chY2 =
    ChY2


{-| [Circle mark](https://vega.github.io/vega-lite/docs/circle.html) for
symbolising points. Unlike the [point](#point) mark, circles are filled by default
and may be sized via a separate [size](#size) encoding.
-}
circle : List MarkProperty -> ( VLProperty, Spec )
circle =
    mark Circle


{-| Clipping rectangle in pixel units. The four parameters are respectively
'left', 'top', 'right' and 'bottom' of the rectangular clipping bounds.
-}
clipRect : Float -> Float -> Float -> Float -> ClipRect
clipRect l t r b =
    LTRB l t r b


{-| Expression that evaluates to the left, top, bottom, and right of a clipping
rectangle in pixel coordinates.
-}
clipRectExpr : String -> String -> String -> String -> ClipRect
clipRectExpr l t r b =
    ClipRectExpr l t r b


{-| Configure the default appearance of area marks.
-}
coArea : List MarkProperty -> ConfigurationProperty
coArea =
    AreaStyle


{-| Whether or not [ARIA attributes](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA)
should be included for marks and guides when generating SVG output. If not specified,
the default is `True`.
-}
coAria : Bool -> ConfigurationProperty
coAria =
    Aria


{-| Configure the default sizing of visualizations.
-}
coAutosize : List Autosize -> ConfigurationProperty
coAutosize =
    Autosize


{-| Configure the default appearance of axes.
-}
coAxis : List AxisConfig -> ConfigurationProperty
coAxis =
    Axis AxBoth


{-| Configure the default appearance of any axes using a band (binned) scale.
-}
coAxisBand : List AxisConfig -> ConfigurationProperty
coAxisBand =
    AxisBand AxBoth


{-| Configure the default appearance of bottom-side axes.
-}
coAxisBottom : List AxisConfig -> ConfigurationProperty
coAxisBottom =
    AxisBottom


{-| Configure the default appearance of any axes using a discrete scale.
-}
coAxisDiscrete : List AxisConfig -> ConfigurationProperty
coAxisDiscrete =
    AxisDiscrete AxBoth


{-| Configure the default appearance of left-side axes.
-}
coAxisLeft : List AxisConfig -> ConfigurationProperty
coAxisLeft =
    AxisLeft


{-| Configure the default appearance of any axes using a point scale.
-}
coAxisPoint : List AxisConfig -> ConfigurationProperty
coAxisPoint =
    AxisPoint AxBoth


{-| Specify a list of named styles that each define a list of axis properties.
Provided for compatibility with Vega-Lite, but generally greater type safety is
achieved in elm-vegalite by creating elm functions that generate lists of
[AxisProperties](#AxisProperty).
-}
coAxisStyles : List ( String, List AxisProperty ) -> ConfigurationProperty
coAxisStyles =
    AxisStyles


{-| Configure the default appearance of any quantitative axes.
-}
coAxisQuant : List AxisConfig -> ConfigurationProperty
coAxisQuant =
    AxisQuant AxBoth


{-| Configure the default appearance of right-side axes.
-}
coAxisRight : List AxisConfig -> ConfigurationProperty
coAxisRight =
    AxisRight


{-| Configure the default appearance of any temporal axes.
-}
coAxisTemporal : List AxisConfig -> ConfigurationProperty
coAxisTemporal =
    AxisTemporal AxBoth


{-| Configure the default appearance of top-side axes.
-}
coAxisTop : List AxisConfig -> ConfigurationProperty
coAxisTop =
    AxisTop


{-| Filter an axis configuration so that it only applies to x-axes. For example,
to configure all band X-axes to be red:

    configuration (coAxisBand [ axcoTitleColor "red" ] |> coAxisXFilter)

-}
coAxisXFilter : ConfigurationProperty -> ConfigurationProperty
coAxisXFilter cp =
    case cp of
        Axis _ acs ->
            Axis axX acs

        AxisBand _ acs ->
            AxisBand axX acs

        AxisDiscrete _ acs ->
            AxisDiscrete axX acs

        AxisPoint _ acs ->
            AxisPoint axX acs

        AxisQuant _ acs ->
            AxisQuant axX acs

        AxisTemporal _ acs ->
            AxisTemporal axX acs

        _ ->
            cp


{-| Filter an axis configuration so that it only applies to y-axes. For example,
to configure all temporal Y-axes to be red:

    configuration (coAxisTemporal [ axcoTitleColor "red" ] |> coAxisYFilter)

-}
coAxisYFilter : ConfigurationProperty -> ConfigurationProperty
coAxisYFilter cp =
    case cp of
        Axis _ acs ->
            Axis axY acs

        AxisBand _ acs ->
            AxisBand axY acs

        AxisDiscrete _ acs ->
            AxisDiscrete axY acs

        AxisPoint _ acs ->
            AxisPoint axY acs

        AxisQuant _ acs ->
            AxisQuant axY acs

        AxisTemporal _ acs ->
            AxisTemporal axY acs

        _ ->
            cp


{-| Configure the default background color of visualizations.
-}
coBackground : String -> ConfigurationProperty
coBackground =
    Background


{-| Configure the default appearance of bar marks.
-}
coBar : List MarkProperty -> ConfigurationProperty
coBar =
    BarStyle


{-| Configure the default appearance of circle marks.
-}
coCircle : List MarkProperty -> ConfigurationProperty
coCircle =
    CircleStyle


{-| Configure the default appearance of concatenated layouts.
-}
coConcat : List ConcatConfig -> ConfigurationProperty
coConcat =
    ConcatStyle


{-| Configuration option for the maximum number of columns to use in a concatenated
flow layout.
-}
cocoColumns : Int -> ConcatConfig
cocoColumns =
    CoColumns


{-| Configuration option for the spacing in pixels between sub-views in a
concatenated view.
-}
cocoSpacing : Float -> ConcatConfig
cocoSpacing =
    CoSpacing


{-| Configure the default title style for count fields.
-}
coCountTitle : String -> ConfigurationProperty
coCountTitle =
    CountTitle


{-| Allow formatting of text marks and guides (e.g. [axFormatAsCustom](#axFormatAsCustom))
to accept a custom formatter function registered as a Vega expression. See
[how to register a Vega-Lite custom formatter](https://vega.github.io/vega-lite/usage/compile.html#format-type).
-}
coCustomFormatTypes : Bool -> ConfigurationProperty
coCustomFormatTypes =
    CustomFormatTypes


{-| Configure the default appearance of facet layouts.
-}
coFacet : List FacetConfig -> ConfigurationProperty
coFacet =
    FacetStyle


{-| Configure the default title generation style for fields.
-}
coFieldTitle : FieldTitleProperty -> ConfigurationProperty
coFieldTitle =
    FieldTitle


{-| Configure the default font for all titles, labels and text marks.
-}
coFont : String -> ConfigurationProperty
coFont =
    Font


{-| Configure the default appearance of geoshape marks.
-}
coGeoshape : List MarkProperty -> ConfigurationProperty
coGeoshape =
    GeoshapeStyle


{-| Configure the default appearance of facet headers.
-}
coHeader : List HeaderProperty -> ConfigurationProperty
coHeader =
    HeaderStyle


{-| Configure the default appearance of legends.
-}
coLegend : List LegendConfig -> ConfigurationProperty
coLegend =
    Legend


{-| Configure the default appearance of line marks.
-}
coLine : List MarkProperty -> ConfigurationProperty
coLine =
    LineStyle


{-| Encode a color channel. The first parameter is a list of color encoding options
such as the data to encode, colour scaling etc.

    enc =
        encoding
            << color [ mName "avHireTime", mQuant ]

-}
color : List MarkChannel -> List LabelledSpec -> List LabelledSpec
color markProps =
    (::) ( "color", List.concatMap markChannelProperties markProps |> JE.object )


{-| Encodes a new facet to be arranged in columns. The first parameter is a list
of properties that define the faceting channel. This should include at least the
name of the data field and its measurement type. See the
[Vega-Lite column documentation](https://vega.github.io/vega-lite/docs/facet.html#row--column-encoding-channels)

Note that when faceting, dimensions specified with [width](#width) and [height](#height)
refer to the individual faceted plots, not the assemblage as a whole.

    let
        data =
            dataFromUrl "crimeData.csv"

        enc =
            encoding
                << position X [ pName "month", pTemporal ]
                << position Y [ pName "reportedCrimes", pQuant, pAggregate opSum ]
                << column [ fName "crimeType", fNominal ]
    in
    toVegaLite [ width 100, data [], bar [], enc [] ]

-}
column : List FacetChannel -> List LabelledSpec -> List LabelledSpec
column fFields =
    (::) ( "column", JE.object (List.map facetChannelProperty fFields) )


{-| Maximum number of columns to include in a view composition flow layout. If the
number of faceted small multiples exceeds this number, flow moves to the next row.
Only applies to flow layouts generated by [concat](#concat), [facetFlow](#facetFlow)
and [repeatFlow](#repeatFlow). If 0, negative or not defined, faceted small multiples
will be arranged in a single row.
-}
columns : Int -> ( VLProperty, Spec )
columns cols =
    ( VLColumns, JE.int (max 0 cols) )


{-| The mapping between a column and its field definitions in a set of faceted
small multiples. This is used when specifying a more flexible [facet](#facet)
rather than the compact, but simplified, [column](#column).
-}
columnBy : List FacetChannel -> FacetMapping
columnBy =
    ColumnBy


{-| Create a list of fields to use in set of repeated small multiples arranged in
columns. The list of fields named here can be referenced in an encoding with
`pRepeat column`, `mRepeat column` etc.
-}
columnFields : List String -> RepeatFields
columnFields =
    ColumnFields


{-| Configure the default mark appearance.
-}
coMark : List MarkProperty -> ConfigurationProperty
coMark =
    MarkStyle


{-| Specify a list of named styles that each define a list of mark properties.
Can be used when configuring views, titles etc. Provided for compatibility with
Vega-Lite, but generally greater type safety is achieved in elm-vegalite by creating
elm functions that generate lists of [MarkProperties](#MarkProperty).
-}
coMarkStyles : List ( String, List MarkProperty ) -> ConfigurationProperty
coMarkStyles =
    MarkStyles


{-| Combine a list of labelled specifications to be passed to JavaScript for rendering.
Useful when you wish to create a single page with multiple visualizations.

    combineSpecs
        [ ( "vis1", myFirstVis )
        , ( "vis2", mySecondVis )
        , ( "vis3", myOtherVis )
        ]

-}
combineSpecs : List LabelledSpec -> Spec
combineSpecs specs =
    JE.object specs


{-| Specifications to be juxtaposed in a flow layout of views. The number of columns
in the flow layout can be set with [columns](#columns) and if not specified will
default to a single row of unlimited columns.

    let
        data =
            dataSequenceAs 0 6.28 0.1 "x"

        trans =
            transform
                << calculateAs "sin(datum.x)" "sinX"
                << calculateAs "cos(datum.x)" "cosX"

        enc =
            encoding
                << position X [ pName "x", pQuant ]

        encCos =
            enc << position Y [ pName "cosX", pQuant ]

        encSin =
            enc << position Y [ pName "sinX", pQuant ]
    in
    toVegaLite
        [ data
        , trans []
        , concat
            [ asSpec [ encCos [], line [] ]
            , asSpec [ encSin [], line [] ]
            ]
        ]

-}
concat : List Spec -> ( VLProperty, Spec )
concat specs =
    ( VLConcat, toList specs )


{-| A configuration option to be applied globally across the visualization.
-}
configuration : ConfigurationProperty -> List LabelledSpec -> List LabelledSpec
configuration cfg =
    (::) (configProperty cfg)


{-| Create a single global configuration from a list of configuration specifications.
Each [configuration](#configuration) that makes up the global list of customisations
refers to a specific part of all visualizations to which it is applied, such as
axes, legends, selections etc.
See the [Vega-Lite documentation](https://vega.github.io/vega-lite/docs/config.html).

The following would make axis lines (domain) 2 pixels wide, remove the border
rectangle and require interactive selection of items to use a double-click.

    let
        cfg =
            configure
                << configuration (coAxis [ axcoDomainWidth 2 ])
                << configuration (coView [ vicoStroke Nothing ])
                << configuration (coSelection [ ( sePoint, [ seOn "dblclick" ] ) ])
    in
    toVegaLite [ cfg [], data [], enc [], bar [] ]

-}
configure : List LabelledSpec -> ( VLProperty, Spec )
configure configs =
    ( VLConfig, JE.object configs )


{-| A conformal conic map projection.
-}
conicConformal : Projection
conicConformal =
    ConicConformal


{-| An equal area conic map projection.
-}
conicEqualArea : Projection
conicEqualArea =
    ConicEqualArea


{-| An equidistant conic map projection.
-}
conicEquidistant : Projection
conicEquidistant =
    ConicEquidistant


{-| Configure the default number formatting for axis and text labels.
-}
coNumberFormat : String -> ConfigurationProperty
coNumberFormat =
    NumberFormat


{-| Configure the default padding in pixels from the edge of the of visualization
to the data rectangle.
-}
coPadding : Padding -> ConfigurationProperty
coPadding =
    Padding


{-| Configure the default appearance of point marks.
-}
coPoint : List MarkProperty -> ConfigurationProperty
coPoint =
    PointStyle


{-| Configure the default style of map projections.
-}
coProjection : List ProjectionProperty -> ConfigurationProperty
coProjection =
    Projection


{-| Configure the default range properties used when scaling.
-}
coRange : List RangeConfig -> ConfigurationProperty
coRange =
    Range


{-| Configure the default appearance of rectangle marks.
-}
coRect : List MarkProperty -> ConfigurationProperty
coRect =
    RectStyle


{-| Configure the default appearance of rule marks.
-}
coRule : List MarkProperty -> ConfigurationProperty
coRule =
    RuleStyle


{-| Configure the default scale properties used when scaling.
-}
coScale : List ScaleConfig -> ConfigurationProperty
coScale =
    Scale


{-| Configure the default appearance of selection marks.
-}
coSelection : List ( Selection, List SelectionProperty ) -> ConfigurationProperty
coSelection =
    SelectionStyle


{-| Configure the default appearance of square marks.)
-}
coSquare : List MarkProperty -> ConfigurationProperty
coSquare =
    SquareStyle


{-| Configure the default appearance of text marks.
-}
coText : List MarkProperty -> ConfigurationProperty
coText =
    TextStyle


{-| Configure the default appearance of tick marks.
-}
coTick : List MarkProperty -> ConfigurationProperty
coTick =
    TickStyle


{-| Configure the default style of visualization titles.
-}
coTitle : List TitleConfig -> ConfigurationProperty
coTitle =
    TitleStyle


{-| Configure the default time format for axis and legend labels.
-}
coTimeFormat : String -> ConfigurationProperty
coTimeFormat =
    TimeFormat


{-| Configure the default style of trail marks.
-}
coTrail : List MarkProperty -> List LabelledSpec -> List LabelledSpec
coTrail mps =
    (::) (configProperty (TrailStyle mps))


{-| Configure the default single view style.
-}
coView : List ViewConfig -> ConfigurationProperty
coView =
    View


{-| CSV data file format (only necessary if the file extension does not indicate the
type).
-}
csv : Format
csv =
    CSV


{-| Scrolling cursor.
-}
cuAllScroll : Cursor
cuAllScroll =
    CAllScroll


{-| Automatically determine a cursor type depending on interaction context.
-}
cuAuto : Cursor
cuAuto =
    CAuto


{-| Alias cursor.
-}
cuAlias : Cursor
cuAlias =
    CAlias


{-| Cube helix color interpolation for continuous color scales using the given
gamma value (anchored at 1).
-}
cubeHelix : Float -> CInterpolate
cubeHelix =
    CubeHelix


{-| Long-path cube helix color interpolation for continuous color scales using
the given gamma value (anchored at 1).
-}
cubeHelixLong : Float -> CInterpolate
cubeHelixLong =
    CubeHelixLong


{-| Cell cursor.
-}
cuCell : Cursor
cuCell =
    CCell


{-| Resizing cursor.
-}
cuColResize : Cursor
cuColResize =
    CColResize


{-| Context menu cursor.
-}
cuContextMenu : Cursor
cuContextMenu =
    CContextMenu


{-| Copy cursor.
-}
cuCopy : Cursor
cuCopy =
    CCopy


{-| Crosshair cursor.
-}
cuCrosshair : Cursor
cuCrosshair =
    CCrosshair


{-| Default cursor.
-}
cuDefault : Cursor
cuDefault =
    CDefault


{-| Resizing cursor.
-}
cuEResize : Cursor
cuEResize =
    CEResize


{-| Resizing cursor.
-}
cuEWResize : Cursor
cuEWResize =
    CEWResize


{-| Expression that evaluates to some cursor style such as "crosshair", "grab"
or "help".
-}
cuExpr : String -> Cursor
cuExpr =
    CursorExpr


{-| Grab cursor.
-}
cuGrab : Cursor
cuGrab =
    CGrab


{-| Grabbing cursor.
-}
cuGrabbing : Cursor
cuGrabbing =
    CGrabbing


{-| Help cursor.
-}
cuHelp : Cursor
cuHelp =
    CHelp


{-| Move cursor.
-}
cuMove : Cursor
cuMove =
    CMove


{-| Resizing cursor.
-}
cuNEResize : Cursor
cuNEResize =
    CNEResize


{-| Resizing cursor.
-}
cuNESWResize : Cursor
cuNESWResize =
    CNESWResize


{-| 'No drop' cursor.
-}
cuNoDrop : Cursor
cuNoDrop =
    CNoDrop


{-| No cursor.
-}
cuNone : Cursor
cuNone =
    CNone


{-| 'Not allowed' cursor.
-}
cuNotAllowed : Cursor
cuNotAllowed =
    CNotAllowed


{-| Resizing cursor.
-}
cuNResize : Cursor
cuNResize =
    CNResize


{-| Resizing cursor.
-}
cuNSResize : Cursor
cuNSResize =
    CNSResize


{-| Resizing cursor.
-}
cuNWResize : Cursor
cuNWResize =
    CNWResize


{-| Resizing cursor.
-}
cuNWSEResize : Cursor
cuNWSEResize =
    CNWSEResize


{-| Pointer cursor.
-}
cuPointer : Cursor
cuPointer =
    CPointer


{-| Progress cursor.
-}
cuProgress : Cursor
cuProgress =
    CProgress


{-| Resizing cursor.
-}
cuRowResize : Cursor
cuRowResize =
    CRowResize


{-| Resizing cursor.
-}
cuSEResize : Cursor
cuSEResize =
    CSEResize


{-| Resizing cursor.
-}
cuSResize : Cursor
cuSResize =
    CSResize


{-| Custom projection type. Additional custom projections from d3 can be defined
via the [Vega API](https://vega.github.io/vega/docs/projections/#register) and
called from with this function where the parameter is the name of the D3
projection to use (e.g. `customProjection "winkel3"`).
-}
customProjection : String -> Projection
customProjection =
    Custom


{-| Resizing cursor.
-}
cuSWResize : Cursor
cuSWResize =
    CSWResize


{-| Text cursor.
-}
cuText : Cursor
cuText =
    CText


{-| Vertical text cursor.
-}
cuVerticalText : Cursor
cuVerticalText =
    CVerticalText


{-| Waiting cursor.
-}
cuWait : Cursor
cuWait =
    CWait


{-| Resizing cursor.
-}
cuWResize : Cursor
cuWResize =
    CWResize


{-| Zooming cursor.
-}
cuZoomIn : Cursor
cuZoomIn =
    CZoomIn


{-| Zooming cursor.
-}
cuZoomOut : Cursor
cuZoomOut =
    CZoomOut


{-| Concatenate a list of data values as a single data value. For example,

    param "location" [ paValue (daConcat (nums [ 4000, 8000 ])) ]

-}
daConcat : DataValues -> DataValue
daConcat =
    DConcat


{-| Compute some aggregate summary statistics for a field to be encoded with a
level of detail (grouping) channel. The type of aggregation is determined by the
given operation parameter.
-}
dAggregate : Operation -> DetailChannel
dAggregate =
    DAggregate


{-| Like [datumArray](#datumArray) except stores a collection of [DataValues](#DataValues)
(like [strs](#strs), [nums](#nums)) instead of singular datum items. This is just
a convenience function for replicating a `datumArray` that contains lists of items
of the same type. For example,

    dataArrays [ nums [ 10, 20, 30 ], strs [ "a", "b", "c" ] ]

is equivalent to

    datumArray
        [ datumArray [ num 10, num 20, num 30 ]
        , datumArray [ str "a", str "b", str "c" ]
        ]

-}
dataArrays : List DataValues -> DataValues
dataArrays =
    DArrays


{-| Create a column of data. A column has a name and a list of values.
-}
dataColumn : String -> DataValues -> List DataColumn -> List DataColumn
dataColumn colName data =
    case data of
        Numbers col ->
            (::) (List.map (\x -> ( colName, JE.float x )) col)

        Strings col ->
            (::) (List.map (\s -> ( colName, JE.string s )) col)

        DateTimes col ->
            (::) (List.map (\ds -> ( colName, JE.object (List.map dateTimeProperty ds) )) col)

        Booleans col ->
            (::) (List.map (\b -> ( colName, JE.bool b )) col)

        DExprs col ->
            -- TODO: Check this is meaningful with an expression that generates a list of values.
            (::) [ ( colName, JE.object [ ( "expr", JE.string col ) ] ) ]

        -- TODO: Check this produces the correct result
        DObjects col ->
            (::) (List.map (\kvs -> ( colName, JE.object (List.map (\( k, v ) -> ( k, dataValueSpec v )) kvs) )) col)

        DArrays col ->
            -- TODO: Check this produces the correct result.
            (::) (List.map (\ds -> ( colName, dataValuesSpecs ds )) col)


{-| A list of data values created by the given expression.
-}
dataExpr : String -> DataValues
dataExpr =
    DExprs


{-| Declare a data source from a list of column values. Each column should contain
values of the same type, but columns each with a different type are permitted.
If columns do not contain the same number of items the dataset will be truncated
to the length of the shortest, so beware of inadvertently removing data rows at
the 'bottom' of a table.

A list of field formatting instructions can be provided as the first parameter
or an empty list to use the default formatting. Simple numbers and strings do not
normally need formatting, but it is good practice to explicitly declare date-time
formats as default date-time formats can vary between browsers.

The columns are most easily generated with [dataColumn](#dataColumn):

    data =
        dataFromColumns [ parse [ ( "Year", foDate "%Y" ) ] ]
            << dataColumn "Animal" (strs [ "Fish", "Dog", "Cat" ])
            << dataColumn "Age" (nums [ 28, 12, 6 ])
            << dataColumn "Year" (strs [ "2010", "2014", "2015" ])

For more complex inline data tables, such as mixtures of arrays and objects, consider
using [dataFromJson](#dataFromJson).

-}
dataFromColumns : List Format -> List DataColumn -> Data
dataFromColumns fmts cols =
    if cols == [] then
        ( VLData, JE.object [ ( "values", toList [ JE.object [] ] ) ] )

    else
        let
            dArray =
                cols |> transpose |> JE.list JE.object
        in
        if fmts == [] then
            ( VLData, JE.object [ ( "values", dArray ) ] )

        else
            ( VLData
            , JE.object
                [ ( "values", dArray )
                , ( "format", JE.object (List.concatMap formatProperties fmts) )
                ]
            )


{-| Declare a data source from a json specification. The most likely use-case is
creating [geojson](http://geojson.org) objects with [`geometry`](#geometry),
[`geometryCollection`](#geometryCollection) and [`geoFeatureCollection`](#geoFeatureCollection).

    let
        geojson =
            geometry (geoPolygon [ [ ( -3, 59 ), ( 4, 59 ), ( 4, 52 ), ( -3, 59 ) ] ]) []
    in
    toVegaLite
        [ width 200
        , height 200
        , dataFromJson geojson []
        , projection [ prType orthographic ]
        , geoshape []
        ]

For more general cases of json creation such as data tables that mix arrays and
objects, consider combining with [jsonToSpec](#jsonToSpec), for example,

    data =
        jsonToSpec
            """
            {
                "Revenue" : [ 150, 225, 300 ],
                "Profit" : [ 20, 25, 30 ],
                "Order size" : [ 350, 500, 600 ],
                "New customers" : [ 1400, 2000, 2500 ],
                "Satisfaction" : [ 3.5, 4.25, 5 ]
            }
            """
            |> dataFromJson

-}
dataFromJson : Spec -> List Format -> Data
dataFromJson json fmts =
    if fmts == [] then
        ( VLData, JE.object [ ( "values", json ) ] )

    else
        ( VLData
        , JE.object
            [ ( "values", json )
            , ( "format", JE.object (List.concatMap formatProperties fmts) )
            ]
        )


{-| Declare a data source from a list of row values. Each row should contain a
list of tuples in the form (_column name_, _value_). Each column can have a value
of a different type but you must ensure that values are of the same type as others
in the same column. A list of field formatting instructions can be provided as
the first parameter or an empty list to use the default formatting. Rows are most
easily generated with [dataRow](#dataRow).

    data =
        dataFromRows [ parse [ ( "Year", foDate "%Y" ) ] ]
            << dataRow [ ( "Animal", str "Fish" ), ( "Age", num 28 ), ( "Year", str "2010" ) ]
            << dataRow [ ( "Animal", str "Dog" ), ( "Age", num 12 ), ( "Year", str "2014" ) ]
            << dataRow [ ( "Animal", str "Cat" ), ( "Age", num 6 ), ( "Year", str "2015" ) ]

Generally, adding data by column is more efficient and less error-prone. For more
complex inline data tables, such as mixtures of arrays and objects, consider using
[dataFromJson](#dataFromJson).

-}
dataFromRows : List Format -> List DataRow -> Data
dataFromRows fmts rows =
    if rows == [] then
        ( VLData, JE.object [ ( "values", toList [ JE.object [] ] ) ] )

    else if fmts == [] then
        ( VLData, JE.object [ ( "values", toList rows ) ] )

    else
        ( VLData
        , JE.object
            [ ( "values", toList rows )
            , ( "format", JE.object (List.concatMap formatProperties fmts) )
            ]
        )


{-| Declare data from a named source. The source may be from named [datasets](#datasets)
within a specification or one created via the
[Vega View API](https://vega.github.io/vega/docs/api/view/#data). A list of field
formatting instructions can be provided as the second parameter or an empty list
to use the default formatting.

    data = ...
    json = ...
    enc = ...
    toVegaLite
        [ datasets [ ( "myData", data [] ),  ( "myJson", dataFromJson json [] ) ]
        , dataFromSource "myData" []
        , enc []
        , bar []
        ]

-}
dataFromSource : String -> List Format -> Data
dataFromSource sourceName fmts =
    if fmts == [] then
        ( VLData, JE.object [ ( "name", JE.string sourceName ) ] )

    else
        ( VLData
        , JE.object
            [ ( "name", JE.string sourceName )
            , ( "format", JE.object (List.concatMap formatProperties fmts) )
            ]
        )


{-| Declare a data source from a url. The URL can be a local path on a web server
or an external (CORS) URL. A list of field formatting instructions can be provided
as the second parameter or an empty list to use the default formatting.

    bikeData =
        dataFromUrl "./data/bicycleHires.csv"
            [ parse [ ( "numHires", foNum ), ( "avHireTime", foNum ) ] ]

    popData =
        dataFromUrl "https://vega.github.io/vega-lite/data/population.json" []

-}
dataFromUrl : String -> List Format -> Data
dataFromUrl u fmts =
    if fmts == [] then
        ( VLData, JE.object [ ( "url", JE.string u ) ] )

    else
        ( VLData
        , JE.object
            [ ( "url", JE.string u )
            , ( "format", JE.object (List.concatMap formatProperties fmts) )
            ]
        )


{-| Name to give a data source. Useful when a specification needs to reference a
data source, such as one generated via an API call.

    data =
        dataFromUrl "myData.json" [] |> dataName "myName"

-}
dataName : String -> Data -> Data
dataName s data =
    let
        extract d =
            case JD.decodeString (JD.keyValuePairs JD.value) (JE.encode 0 d) of
                Ok [ ( dType, value ) ] ->
                    ( dType, value )

                _ ->
                    --|> Debug.log "Non-data spec provided to dataName"
                    ( "", d )

        spec =
            (\( _, dataSpec ) -> extract dataSpec) data
    in
    ( VLData, JE.object [ ( "name", JE.string s ), spec ] )


{-| Key-value pairs representing a named data value. For example,

    dataObject [ ( "x", num 3500 ), ( "firstName", str "Ada" ) ]

-}
dataObject : List ( String, DataValue ) -> DataValue
dataObject =
    DObject


{-| Generate a collection of lists of Key-value pairs representing named data
values.
-}
dataObjects : List (List ( String, DataValue )) -> DataValues
dataObjects =
    DObjects


{-| Create a row of data. A row comprises a list of (_columnName_, _value_) pairs.
-}
dataRow : List ( String, DataValue ) -> List DataRow -> List DataRow
dataRow r =
    (::) (JE.object (List.map (\( colName, val ) -> ( colName, dataValueSpec val )) r))


{-| Create a dataset comprising a collection of named `Data` items. Each data item
can be created with normal data generating functions such as [dataFromRows](#dataFromRows)
or [dataFromJson](#dataFromJson). These can be later referred to using
[dataFromSource](#dataFromSource).

    import Json.Encode as JE

    let
        data =
            dataFromRows []
                << dataRow [ ( "cat", str "a" ), ( "val", num 10 ) ]
                << dataRow [ ( "cat", str "b" ), ( "val", num 18 ) ]
        json =
            JE.list JE.object
                [ [ ( "cat", JE.string "a" ), ( "val", JE.float 120 ) ]
                , [ ( "cat", JE.string "b" ), ( "val", JE.float 180 ) ]
                ]

        enc = ...

    in
    toVegaLite
        [ datasets [ ( "myData", data [] ),  ( "myJson", dataFromJson json [] ) ]
        , dataFromSource "myData" []
        , bar []
        , enc []
        ]

-}
datasets : List ( String, Data ) -> Data
datasets namedData =
    let
        extract data =
            case JD.decodeString (JD.keyValuePairs JD.value) (JE.encode 0 data) of
                Ok [ ( _, value ) ] ->
                    value

                _ ->
                    data

        specs =
            List.map (\( s, data ) -> ( s, (\( _, spec ) -> extract spec) data )) namedData
    in
    ( VLDatasets, JE.object specs )


{-| Generate a sequence of numbers as a data source between the value of the first
parameter (inclusive) and the second (exclusive) in steps of the value of the third.
The resulting sequence will have the name `data`.

    myData =
        dataSequence 0 6.28 0.1

To give the sequence an alternative name use [dataSequenceAs](#dataSequenceAs)

-}
dataSequence : Float -> Float -> Float -> Data
dataSequence start stop step =
    ( VLData
    , JE.object
        [ ( "sequence"
          , JE.object
                [ ( "start", JE.float start )
                , ( "stop", JE.float stop )
                , ( "step", JE.float step )
                ]
          )
        ]
    )


{-| Generate a sequence of numbers as a data source between the value of the first
parameter (inclusive) and the second (exclusive) in steps of the value of the third.
The resulting sequence will have the name provided as the fourth parameter.

    myData =
        dataSequenceAs 0 6.28 0.1 "x"

-}
dataSequenceAs : Float -> Float -> Float -> String -> Data
dataSequenceAs start stop step outName =
    ( VLData
    , JE.object
        [ ( "sequence"
          , JE.object
                [ ( "start", JE.float start )
                , ( "stop", JE.float stop )
                , ( "step", JE.float step )
                , ( "as", JE.string outName )
                ]
          )
        ]
    )


{-| Day of the month (1-31) time unit used for discretizing temporal data.
-}
date : TimeUnit
date =
    Date


{-| List of data values. Unlike [nums](#nums), [strs](#strs) etc., this allows a
single array to store mixed types and nested values. For example,

    datumArray [ num 10, str "a", datumArray [ num 99, boo False ] ]

-}
datumArray : List DataValue -> DataValue
datumArray =
    DArray


{-| A data value created by the given expression.
-}
datumExpr : String -> DataValue
datumExpr =
    DExpr


{-| Day of the week used for discretizing temporal data. This will therefore discretize
any temporal sequence into a maximum of 7 bins.
-}
day : TimeUnit
day =
    Day


{-| Hour of the day through the week used for discretizing temporal data. This will
therefore discretize any temporal sequence into a maximum of 7\*24 bins.
-}
dayHours : TimeUnit
dayHours =
    DayHours


{-| Minute through the week used for discretizing temporal data. This will
therefore discretize any temporal sequence into a maximum of 7\*24\*60 bins.
-}
dayHoursMinutes : TimeUnit
dayHoursMinutes =
    DayHoursMinutes


{-| Second through the week used for discretizing temporal data. This will
therefore discretize any temporal sequence into a maximum of 7\*24\*60\*60 bins.
-}
dayHoursMinutesSeconds : TimeUnit
dayHoursMinutesSeconds =
    DayHoursMinutesSeconds


{-| Indicate temporal binning by day of the year, so a 10 year sequence would
have up to 366 bins.
-}
dayOfYear : TimeUnit
dayOfYear =
    DayOfYear


{-| Discretize numeric values into bins when encoding with a level of detail
(grouping) channel.
-}
dBin : List BinProperty -> DetailChannel
dBin =
    DBin


{-| Apply _Kernel Density Estimation_ to a data stream to generate a new stream
of samples of the estimated density. Useful for representing probability
distributions and generating continuous distributions from discrete samples.
-}
density : String -> List DensityProperty -> List LabelledSpec -> List LabelledSpec
density field dnProps =
    (::)
        ( "multiSpecs"
        , JE.object
            (( "density", JE.string field )
                :: List.map densityProperty dnProps
            )
        )


{-| Description to be associated with a visualization.
-}
description : String -> ( VLProperty, Spec )
description s =
    ( VLDescription, JE.string s )


{-| Encode a 'level of detail' channel. This provides a way of grouping by a field
but unlike, say `color`, all groups have the same visual properties. The first
parameter is a list of the field characteristics to be grouped.

    enc =
        encoding
            << detail [ dName "avHireTime", dQuant ]

-}
detail : List DetailChannel -> List LabelledSpec -> List LabelledSpec
detail detailProps =
    (::) ( "detail", List.map detailChannelProperty detailProps |> JE.object )


{-| Indicate a data field encoded with a detail channel is a geo feature. Equivalent
to `dMType GeoFeature`.
-}
dGeo : DetailChannel
dGeo =
    DmType GeoFeature


{-| Name of field used for encoding with a level of detail (grouping) channel.
-}
dName : String -> DetailChannel
dName =
    DName


{-| Level of measurement when encoding with a detail (grouping) channel. See also
[dNominal](#dNominal), dOrdinal](#dOrdinal), [dQuant](#dQuant),
[dTemporal](#dTemporal) and [dGeo](#dGeo) for shorthand equivalents.
-}
dMType : Measurement -> DetailChannel
dMType =
    DmType


{-| Name the outputs of a density transform. The first parameter is the name to
give the field containing samples, the second the name to give the field containing
density estimates. If not specified, the default names `value` and `density` will
be used.
-}
dnAs : String -> String -> DensityProperty
dnAs =
    DnAs


{-| The bandwidth (standard deviation) of the Gaussian kernel used in KDE estimation.
If 0 or unspecified, the bandwidth will be calculated using
[Scott's method](https://stats.stackexchange.com/questions/90656/kernel-bandwidth-scotts-vs-silvermans-rules).
-}
dnBandwidth : Float -> DensityProperty
dnBandwidth =
    DnBandwidth


{-| Whether density estimates should generate counts (true) or probabilities (false).
If unspecified, probabilities will be generated.
-}
dnCounts : Bool -> DensityProperty
dnCounts =
    DnCounts


{-| Whether or not density estimates will be cumulative. If unspecified, non-cumulative
estimates will be generated.
-}
dnCumulative : Bool -> DensityProperty
dnCumulative =
    DnCumulative


{-| The min (first parameter) - max (second parameter) domain from which to sample
a distribution for density estimation. If unspecified, the full extent of input
values will be sampled.
-}
dnExtent : Float -> Float -> DensityProperty
dnExtent =
    DnExtent


{-| The data fields to group by when estimating density. If not specified, a single
group containing all data objects will be used.
-}
dnGroupBy : List String -> DensityProperty
dnGroupBy =
    DnGroupBy


{-| The maximum number of samples to take when estimating density. Default is 200.
-}
dnMaxSteps : Int -> DensityProperty
dnMaxSteps =
    DnMaxSteps


{-| The minimum number of samples to take from the extent domain when estimating
density. Default is 25.
-}
dnMinSteps : Int -> DensityProperty
dnMinSteps =
    DnMinSteps


{-| Indicate a data field encoded with a detail channel is nominal. Equivalent to
`dMType Nominal`. This is the default data type.
-}
dNominal : DetailChannel
dNominal =
    DmType Nominal


{-| The exact number of samples to take from the extent domain when estimating
density. Will override [dnMinSteps](#dnMinSteps) and [dnMaxSteps](#dnMaxSteps)
and is useful in conjunction with a fixed extent to ensure consistent sample points
for stacked densities.
-}
dnSteps : Int -> DensityProperty
dnSteps =
    DnSteps


{-| Date-time values that define a scale domain.
-}
doDts : List (List DateTime) -> ScaleDomain
doDts =
    DDateTimes


{-| Expression that should evaluate to a list of date-times that define a scale domain.
-}
doDtsExpr : String -> ScaleDomain
doDtsExpr =
    DDateTimesExpr


{-| Create a pair of continuous domain to color mappings suitable for customising
ordered scales. The first parameter is a tuple representing the mapping of the lowest
numeric value in the domain to its equivalent color; the second tuple the mapping
of the highest numeric value to color. If the domain contains any values between
these lower and upper bounds they are interpolated according to the scale's interpolation
function. Convenience function equivalent to specifying separate `scDomain` and
`scRange` lists and is safer as it guarantees a one-to-one correspondence between
domain and range values.

    color
        [ mName "year"
        , mOrdinal
        , mScale (domainRangeMap ( 1955, "#e6959c" ) ( 2000, "#911a24" ))
        ]

-}
domainRangeMap : ( Float, String ) -> ( Float, String ) -> List ScaleProperty
domainRangeMap lowerMap upperMap =
    let
        ( domain, range ) =
            List.unzip [ lowerMap, upperMap ]
    in
    [ SDomain (DNumbers (Nums domain)), SRange (RStrings (Strs range)) ]


{-| Set the maximum value of a continuous numeric domain. The minimum will be
determined by the data. To set both the min and max values use [doNums](#doNums).
-}
doMax : Float -> ScaleDomain
doMax n =
    DMaxNumber (Num n)


{-| Set the maximum value of a date-time domain. The minimum will be determined
by the data. To set both the min and max values use [doDts](#doDts).
-}
doMaxDt : List DateTime -> ScaleDomain
doMaxDt ts =
    DMaxDateTime (Timestamp ts)


{-| Set the maximum value of a date-time domain with an expression that evaluates
to a date-time.
-}
doMaxDtExpr : String -> ScaleDomain
doMaxDtExpr s =
    DMaxDateTime (TimestampExpr s)


{-| Set the midpoint of continuous two-point diverging domain. Useful when the
domain is not symmetric about the given midpoint but you wish to use a color
scheme that diverges equally from that point.
-}
doMid : Float -> ScaleDomain
doMid n =
    DMidNumber (Num n)


{-| Set the minimum value of a continuous numeric domain. The maximum will be
determined by the data. To set both the min and max values use [doNums](#doNums).
-}
doMin : Float -> ScaleDomain
doMin n =
    DMinNumber (Num n)


{-| Set the minimum value of a date-time domain. The maximum will be determined
by the data. To set both the min and max values use [doDts](#doDts).
-}
doMinDt : List DateTime -> ScaleDomain
doMinDt ts =
    DMinDateTime (Timestamp ts)


{-| Set the minimum value of a date-time domain with an expression that evaluates
to a date-time.
-}
doMinDtExpr : String -> ScaleDomain
doMinDtExpr s =
    DMinDateTime (TimestampExpr s)


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to
a domain scale property function requiring a numeric value. This can be used for
interactive parameterisation when an expression is bound to an input element.
For example,

    ps =
        params
            << param "upper"
                [ paValue (num 50)
                , paBind (ipRange [ inMax 100 ])
                ]

    enc =
        encoding
            << position X
                [ pName "x"
                , pScale [ scDomain (doNumExpr "upper" doMax) ]
                ]

-}
doNumExpr : String -> (number -> ScaleDomain) -> ScaleDomain
doNumExpr ex fn =
    case fn 0 of
        DMaxNumber _ ->
            DMaxNumber (NumExpr ex)

        DMidNumber _ ->
            DMidNumber (NumExpr ex)

        DMinNumber _ ->
            DMinNumber (NumExpr ex)

        _ ->
            fn 0


{-| Numeric values that define a scale domain.
-}
doNums : List Float -> ScaleDomain
doNums ns =
    DNumbers (Nums ns)


{-| Indicate a data field encoded with a detail channel is ordinal. Equivalent to
`dMType Ordinal`.
-}
dOrdinal : DetailChannel
dOrdinal =
    DmType Ordinal


{-| Scale domain based on a named interactive selection. This can be used when
projecting a selection across a single domain or equally across several domains.
-}
doSelection : String -> ScaleDomain
doSelection =
    DSelection


{-| Scale domain based on a named interactive selection (first parameter) and project
it across the given channel (second parameter). Useful when, for example, you wish
to project a 2d interval selection across the X and Y channels each with independent
domains.
-}
doSelectionChannel : String -> Channel -> ScaleDomain
doSelectionChannel =
    DSelectionChannel


{-| Scale domain based on a named interactive selection (first parameter) and project
it across the given field (second parameter). Useful when, for example, you wish
to project a 2d interval selection across the X and Y channels each with independent
domains.
-}
doSelectionField : String -> String -> ScaleDomain
doSelectionField =
    DSelectionField


{-| String values that define a scale domain.
-}
doStrs : List String -> ScaleDomain
doStrs =
    DStrings


{-| Indicate that a domain of aggregated data should be scaled to the domain of
the data prior to aggregation.
-}
doUnaggregated : ScaleDomain
doUnaggregated =
    Unaggregated


{-| Combine the given domain with that determined by the data. This allows a minimal
domain to be set that may be exceeded if the data determine so. For example, the
following sets a domain of at least 0 to 100, but can be exceeded if the data
extend beyond the domain:

    pScale [ scDomain (doUnionWith (doNums [ 0, 100 ])) ]

-}
doUnionWith : ScaleDomain -> ScaleDomain
doUnionWith =
    DUnionWith


{-| Indicate a data field encoded with a detail channel is quantitative. Equivalent
to `dMType Quantitative`.
-}
dQuant : DetailChannel
dQuant =
    DmType Quantitative


{-| Delimited file format (DSV) with a given separator.
-}
dsv : Char -> Format
dsv =
    DSV


{-| Date-time data value.
-}
dt : List DateTime -> DataValue
dt =
    DateTime


{-| Day of the month (1 to 31).
-}
dtDate : Int -> DateTime
dtDate =
    DTDate


{-| Day of the week.
-}
dtDay : DayName -> DateTime
dtDay =
    DTDay


{-| Indicate a data field encoded with a detail channel is temporal. Equivalent to
`dMType Temporal`.
-}
dTemporal : DetailChannel
dTemporal =
    DmType Temporal


{-| Hour of the day (0=midnight, 1=1am, 23=11pm etc.).
-}
dtHour : Int -> DateTime
dtHour =
    DTHours


{-| Form of time unit aggregation of field values when encoding with a level of
detail (grouping) channel.
-}
dTimeUnit : TimeUnit -> DetailChannel
dTimeUnit =
    DTimeUnit


{-| Millisecond of a second (0-999).
-}
dtMillisecond : Int -> DateTime
dtMillisecond =
    DTMilliseconds


{-| Minute of an hour (0-59).
-}
dtMinute : Int -> DateTime
dtMinute =
    DTMinutes


{-| Month of a year.
-}
dtMonth : MonthName -> DateTime
dtMonth =
    DTMonth


{-| Month of a year as a number (1 - 12).
-}
dtMonthNum : MonthName -> DateTime
dtMonthNum mon =
    case mon of
        Jan ->
            DTMonthNum 1

        Feb ->
            DTMonthNum 2

        Mar ->
            DTMonthNum 3

        Apr ->
            DTMonthNum 4

        May ->
            DTMonthNum 5

        Jun ->
            DTMonthNum 6

        Jul ->
            DTMonthNum 7

        Aug ->
            DTMonthNum 8

        Sep ->
            DTMonthNum 9

        Oct ->
            DTMonthNum 10

        Nov ->
            DTMonthNum 11

        Dec ->
            DTMonthNum 12


{-| Year quarter (1 to 4).
-}
dtQuarter : Int -> DateTime
dtQuarter =
    DTQuarter


{-| Min max date-time range to be used in data filtering. If either
parameter is an empty list, it is assumed to be unbounded.
-}
dtRange : List DateTime -> List DateTime -> FilterRange
dtRange ts1 ts2 =
    DateRange (Timestamp ts1) (Timestamp ts2)


{-| List of date-time data values. Used when declaring inline data with
[dataColumn](#dataColumn), filtering ([fiOneOf](#fiOneOf)), imputation
([imKeyVals](#imKeyVals)) and customised sorting ([soCustom](#soCustom)).
-}
dts : List (List DateTime) -> DataValues
dts =
    DateTimes


{-| Second of a minute (0-59).
-}
dtSecond : Int -> DateTime
dtSecond =
    DTSeconds


{-| A year.
-}
dtYear : Int -> DateTime
dtYear =
    DTYear


{-| Create an encoding specification from a list of channel encodings. These are
commonly built by chaining series of channel encoding functions together such as
[position](#position), [color](#color), [size](#size) etc.

    enc =
        encoding
            << position X [ pName "month", pTemporal ]
            << position Y [ pName "score", pQuant ]
            << color [ mName "team", mMType Nominal ]

-}
encoding : List LabelledSpec -> ( VLProperty, Spec )
encoding channels =
    ( VLEncoding, JE.object channels )


{-| An [Equal Earth map projection](https://en.wikipedia.org/wiki/Equal_Earth_projection)
that provides a reasonable shape approximation while retaining relative areas.
-}
equalEarth : Projection
equalEarth =
    EqualEarth


{-| An equirectangular map projection that maps longitude to x and latitude to y.
While showing less area distortion towards the poles than the default [mercator](#mercator)
projection, it is neither equal-area nor conformal.
-}
equirectangular : Projection
equirectangular =
    Equirectangular


{-| [Errorband composite mark](https://vega.github.io/vega-lite/docs/errorband.html)
for showing summaries of variation along a signal. By default no border is drawn.
To add a border use [maBorders](#maBorders) with an empty list for default border,
or mark properties to customise.

    errorband [ maBorders [ maColor "black", maStrokeWidth 0.5 ] ]

-}
errorband : List MarkProperty -> ( VLProperty, Spec )
errorband =
    mark Errorband


{-| [Errorbar composite mark](https://vega.github.io/vega-lite/docs/errorbar.html)
for showing summaries of variation along a signal. By default no ticks are drawn.
To add ticks with use [maTicks](#maTicks) with an empty list for default appearance,
or with a list of mark properties to customise.

    errorbar [ maTicks [ maColor "black", maSize 8 ] ]

-}
errorbar : List MarkProperty -> ( VLProperty, Spec )
errorbar =
    mark Errorbar


{-| Band extent between the 95% confidence intervals of a distribution.
-}
exCi : SummaryExtent
exCi =
    ExCI


{-| Band extent between the lower and upper quartiles of a distribution.
-}
exIqr : SummaryExtent
exIqr =
    ExIqr


{-| A scaling of the interquartile range to be used as whiskers in a boxplot.
For example, a value of 1.5 would extend whiskers to ±1.5x the IQR from the mean.
-}
exIqrScale : Float -> SummaryExtent
exIqrScale =
    ExIqrScale


{-| Expression that should evaluate to either true or false. Can use any valid
[Vega expression](https://vega.github.io/vega/docs/expressions/).
-}
expr : String -> BooleanOp
expr =
    Expr


{-| Band extent between the minimum and maximum values in a distribution.
-}
exRange : SummaryExtent
exRange =
    ExRange


{-| Band extent as the standard error about the mean of a distribution.
-}
exStderr : SummaryExtent
exStderr =
    ExStderr


{-| Band extent as the standard deviation of a distribution.
-}
exStdev : SummaryExtent
exStdev =
    ExStdev


{-| Facet a view to create a grid of small multiples. Similar to [facetFlow](#facetFlow)
except that the fields for faceting by rows and by columns are set explicitly.

    spec = ...
    toVegaLite
        [ facet [ rowBy [ fName "month", fOrdinal ]
                , columnBy [ fName "week", fOrdinal ]
                ]
        , specification spec
        ]

-}
facet : List FacetMapping -> ( VLProperty, Spec )
facet fMaps =
    ( VLFacet, JE.object (List.map facetMappingProperty fMaps) )


{-| Facet a view to create small multiples in a flow layout. Used when the encoding
of the visualization in small multiples is identical, but data for each is grouped
by the given fields. When creating a faceted view in this way you also need to
define a full specification to apply to each of those facets using `asSpec`.

Small multiples will be laid out from left to right, moving on to new rows only
if the number of plots exceeds an optional column limit (specified via
[columns](#columns)).

    spec = ...
    toVegaLite
        [ facetFlow [ fName "Origin", fNominal ]
        , specification spec
        ]

-}
facetFlow : List FacetChannel -> ( VLProperty, Spec )
facetFlow fFields =
    ( VLFacet, JE.object (List.map facetChannelProperty fFields) )


{-| Configuration option for the maximum number of columns to use in a faceted
flow layout.
-}
facoColumns : Int -> FacetConfig
facoColumns =
    FCColumns


{-| Configuration option for the spacing in pixels between sub-views in a faceted
view.
-}
facoSpacing : Float -> FacetConfig
facoSpacing =
    FCSpacing


{-| Compute some aggregate summary statistics for a field to be encoded with a
facet channel. The type of aggregation is determined by the given operation
parameter.
-}
fAggregate : Operation -> FacetChannel
fAggregate =
    FAggregate


{-| Alignment to apply to a rows or columns in a facet's sub-plot.
-}
fAlign : CompositionAlignment -> FacetChannel
fAlign =
    FAlign


{-| A false value used for functions that can accept a Boolean literal or a
reference to something that generates a Boolean value. Convenience function
equivalent to `boo False`
-}
false : DataValue
false =
    Boolean False


{-| Discretize numeric values into bins when encoding with a facet channel.
-}
fBin : List BinProperty -> FacetChannel
fBin =
    FBin


{-| Whether or not a facet's sub-plots should be centred relative to their respective
rows or columns.
-}
fCenter : Bool -> FacetChannel
fCenter =
    FCenter


{-| Indicate a data field encoded as a facet property is a geo feature. Equivalent
to `fMType GeoFeature`.
-}
fGeo : FacetChannel
fGeo =
    FmType GeoFeature


{-| Guide that spans a collection of faceted plots, each of which may have their own axes.
-}
fHeader : List HeaderProperty -> FacetChannel
fHeader =
    FHeader


{-| Build up a filtering predicate through logical composition (`and`, `or` etc.).
For example, to filter only items selected interactively and that represent ages
over 65:

    trans =
        transform
            << filter
                (fiCompose
                    (and (selected "brush") (expr "datum.age > 65"))
                )

-}
fiCompose : BooleanOp -> Filter
fiCompose =
    FCompose


{-| Filter a data stream so that only data in a given field equal to the given
value are used.
-}
fiEqual : String -> DataValue -> Filter
fiEqual =
    FEqual


{-| Filter a data stream so that only data that satisfy the given predicate
expression are used.
-}
fiExpr : String -> Filter
fiExpr =
    FExpr


{-| Filter a data stream so that only data in a given field greater than the given
value are used.
-}
fiGreaterThan : String -> DataValue -> Filter
fiGreaterThan =
    FGreaterThan


{-| Filter a data stream so that only data in a given field greater than or equal
to the given value are used.
-}
fiGreaterThanEq : String -> DataValue -> Filter
fiGreaterThanEq =
    FGreaterThanEq


{-| Filter a data stream so that only data in a given field less than the given
value are used.
-}
fiLessThan : String -> DataValue -> Filter
fiLessThan =
    FLessThan


{-| Filter a data stream so that only data in a given field less than or equal to
the given value are used.
-}
fiLessThanEq : String -> DataValue -> Filter
fiLessThanEq =
    FLessThanEq


{-| Encode a fill channel. This acts in a similar way to encoding by `color` but
only affects the interior of closed shapes. If both `fill` and `color` encodings
are specified, `fill` takes precedence.
-}
fill : List MarkChannel -> List LabelledSpec -> List LabelledSpec
fill markProps =
    (::) ( "fill", List.concatMap markChannelProperties markProps |> JE.object )


{-| Encode a fill opacity channel. This acts in a similar way to encoding by `opacity`
but only affects the interior of closed shapes. If both `fillOpacity` and `opacity`
encodings are specified, `fillOpacity` takes precedence.
-}
fillOpacity : List MarkChannel -> List LabelledSpec -> List LabelledSpec
fillOpacity markProps =
    (::) ( "fillOpacity", List.concatMap markChannelProperties markProps |> JE.object )


{-| Apply a filter to a channel or field that specifies which values will 'pass
through' for encoding. A filter can an [expression](https://vega.github.io/vega/docs/expressions/)
such as,

    trans =
        transform << filter (fiExpr "datum.y < 50")

noting that to refer to a particular data value, prefix the field name with `datum.`.
Alternatively a boolean filtering function such as [fiOneOf](#fiOneOf) or
[fiLessThan](#fiLessThan) can be supplied,

    trans =
        transform << filter (fiLessThan "y" (num 50))

-}
filter : Filter -> List LabelledSpec -> List LabelledSpec
filter f =
    (::) ( "filter", filterSpec f )


{-| Filter a data stream so that only data in a given field contained in the given
list of values are used.
-}
fiOneOf : String -> DataValues -> Filter
fiOneOf =
    FOneOf


{-| Convert a filter into a BooleanOp so that it may be used as part of a more
complex Boolean composition.

    trans =
        transform
            << filter
                (fiCompose
                    (and
                        (fiValid "IMDB_Rating" |> fiOp)
                        (fiValid "Rotten_Tomatoes_Rating" |> fiOp)
                    )
                )

-}
fiOp : Filter -> BooleanOp
fiOp =
    FilterOp


{-| Combine a data transformation operation with a filter before converting into
a Boolean operation. This can be useful when working with dates. For example, the
following will aggregate a set of dates into years and filter only those years
between 2010 and 2017 inclusive:

    filter
        (fiRange "date" (dtRange [ dtYear 2010 ] [ dtYear 2017 ])
            |> fiOpTrans (mTimeUnit year)
            |> fiCompose
        )

Note the use of [fiCompose](#fiCompose) to convert the Boolean operation back
into a [Filter](#Filter).

-}
fiOpTrans : MarkChannel -> Filter -> BooleanOp
fiOpTrans =
    FilterOpTrans


{-| Filter a data stream so that only data in a given field that are within the
given range are used.

    filter (fiRange "date" (dtRange [ dtYear 2006 ] [ dtYear 2016 ]))

-}
fiRange : String -> FilterRange -> Filter
fiRange =
    FRange


{-| Filter a data stream in response to the value of a selection parameter. Useful
for creating interactive filtering from a selection.
-}
fiSelection : String -> Filter
fiSelection =
    FSelection


{-| Similar to [fiSelection](#fiSelection) except that an empty selection filters
out all values.
-}
fiSelectionEmpty : String -> Filter
fiSelectionEmpty =
    FSelectionEmpty


{-| Filter a data stream so that only valid data (i.e. not null or NaN) in a given
field are used.
-}
fiValid : String -> Filter
fiValid =
    FValid


{-| Map array-valued fields to a set of individual data objects, one per array entry.
-}
flatten : List String -> List LabelledSpec -> List LabelledSpec
flatten fields =
    (::) ( "flatten", JE.list JE.string fields )


{-| Similar to [flatten](#flatten) but allows the new output fields to be named
(second parameter).
-}
flattenAs : List String -> List String -> List LabelledSpec -> List LabelledSpec
flattenAs fields names =
    (::)
        ( "multiSpecs"
        , JE.object
            [ ( "flatten", JE.list JE.string fields )
            , ( "as", JE.list JE.string names )
            ]
        )


{-| Name of field used for encoding with a facet channel.
-}
fName : String -> FacetChannel
fName =
    FName


{-| Indicate a data field encoded as a facet property is nominal. Equivalent to
`fMType Nominal`. This is the default data type.
-}
fNominal : FacetChannel
fNominal =
    FmType Nominal


{-| Level of measurement when encoding as a facet. See also [fNominal](#fNominal),
fOrdinal](#fOrdinal), [fQuant](#fQuant), [fTemporal](#fTemporal) and [fGeo](#fGeo)
for shorthand equivalents.
-}
fMType : Measurement -> FacetChannel
fMType =
    FmType


{-| Indicate Boolean data type to be parsed when reading input data.
-}
foBoo : DataType
foBoo =
    FoBoo


{-| Date format for parsing input data using
[D3's formatting specifiers](https://github.com/d3/d3-time-format#locale_format)
or left as an empty string for default formatting.
-}
foDate : String -> DataType
foDate =
    FoDate


{-| Perform a _gather_ operation to _tidy_ a table. Collapse multiple data fields
into two new data fields: `key` containing the original data field names and `value`
containing the corresponding data values. This performs the same function as
['gather' in the Tidy Elm package](https://package.elm-lang.org/packages/gicentre/tidy/latest/Tidy#gather)
and the [pivot_longer](https://tidyr.tidyverse.org/dev/articles/pivot.html) /
[gather](https://tidyr.tidyverse.org/reference/gather.html) operation in the R
tidyverse . It is the inverse of [pivot](#pivot).

    data =
        dataFromColumns []
            << dataColumn "city" (strs [ "Bristol", "Sheffield", "Glasgow" ])
            << dataColumn "temp2017" (nums [ 12, 11, 7 ])
            << dataColumn "temp2018" (nums [ 14, 13, 10 ])

    trans =
        transform
            << fold [ "temp2017", "temp2018" ]

    enc =
        encoding
            << position X [ pName "key", pNominal ]
            << position Y [ pName "city", pNominal ]
            << size [ mName "value", mQuant ]

-}
fold : List String -> List LabelledSpec -> List LabelledSpec
fold fields =
    (::) ( "fold", JE.list JE.string fields )


{-| Similar to [fold](#fold) but allows the new output `key` and `value` fields
to be given alternative names.
-}
foldAs : List String -> String -> String -> List LabelledSpec -> List LabelledSpec
foldAs fields keyName valName =
    (::)
        ( "multiSpecs"
        , JE.object
            [ ( "fold", JE.list JE.string fields )
            , ( "as", JE.list JE.string [ keyName, valName ] )
            ]
        )


{-| Indicate numeric data type to be parsed when reading input data.
-}
foNum : DataType
foNum =
    FoNum


{-| Indicate a data field encoded as a facet property is ordinal. Equivalent to
`fMType Ordinal`.
-}
fOrdinal : FacetChannel
fOrdinal =
    FmType Ordinal


{-| Similar to [foDate](#foDate) but for UTC format dates.
-}
foUtc : String -> DataType
foUtc =
    FoUtc


{-| Indicate a data field encoded as a facet property is quantitative. Equivalent
to `fMType Quantitative`.
-}
fQuant : FacetChannel
fQuant =
    FmType Quantitative


{-| Sort order for a field when encoding with a faceted channel.

    row
        [ fName "site"
        , fOrdinal
        , fSort [ soByField "x" opMedian, soDescending ]
        ]

-}
fSort : List SortProperty -> FacetChannel
fSort =
    FSort


{-| Spacing in pixels between sub-views in a faceted view.
-}
fSpacing : Float -> FacetChannel
fSpacing =
    FSpacing


{-| Indicate a data field encoded as a facet property is temporal. Equivalent to
`fMType Temporal`.
-}
fTemporal : FacetChannel
fTemporal =
    FmType Temporal


{-| Field titles to be displayed as 'SUM(field)', 'YEAR(date)' etc.
-}
ftFunction : FieldTitleProperty
ftFunction =
    FTFunction


{-| Form of time unit aggregation of field values when encoding with a facet channel.
-}
fTimeUnit : TimeUnit -> FacetChannel
fTimeUnit =
    FTimeUnit


{-| Field titles to be displayed simply by their name without additional text.
-}
ftPlain : FieldTitleProperty
ftPlain =
    FTPlain


{-| Field titles to be displayed fully as 'Sum of field', 'Year of date' etc.
-}
ftVerbal : FieldTitleProperty
ftVerbal =
    FTVerbal


{-| Specify a bold font weight.
-}
fwBold : FontWeight
fwBold =
    Bold


{-| Specify a bolder font weight.
-}
fwBolder : FontWeight
fwBolder =
    Bolder


{-| Expression that evaluates to some font weight such as "bold", "lighter" or "600".
-}
fwExpr : String -> FontWeight
fwExpr =
    FWExpr


{-| Specify a lighter font weight.
-}
fwLighter : FontWeight
fwLighter =
    Lighter


{-| Specify a normal font weight.
-}
fwNormal : FontWeight
fwNormal =
    Normal


{-| Specify a numeric font weight that should be between 100 (lightest) and 900 (boldest).
-}
fwValue : Int -> FontWeight
fwValue w =
    if w <= 100 then
        W100

    else if w <= 200 then
        W200

    else if w <= 300 then
        W300

    else if w <= 400 then
        W400

    else if w <= 500 then
        W500

    else if w <= 600 then
        W600

    else if w <= 700 then
        W700

    else if w <= 800 then
        W800

    else
        W900


{-| Geo features to be used in a `geoshape` specification. Each feature object in
this collection can be created with [geometry](#geometry).

    geojson =
        geoFeatureCollection
            [ geometry (geoPolygon [ [ ( -3, 59 ), ( -3, 52 ), ( 4, 52 ), ( -3, 59 ) ] ])
                [ ( "myRegionName", str "Northern region" ) ]
            , geometry (geoPolygon [ [ ( -3, 52 ), ( 4, 52 ), ( 4, 45 ), ( -3, 52 ) ] ])
                [ ( "myRegionName", str "Southern region" ) ]
            ]

-}
geoFeatureCollection : List Spec -> Spec
geoFeatureCollection geoms =
    JE.object
        [ ( "type", JE.string "FeatureCollection" )
        , ( "features", toList geoms )
        ]


{-| Line geometry for programmatically creating GeoShapes. Equivalent to the
[GeoJson geometry `line` type](https://tools.ietf.org/html/rfc7946#section-3.1).
-}
geoLine : List ( Float, Float ) -> Geometry
geoLine =
    GeoLine


{-| Multi-line geometry for programmatically creating GeoShapes. Equivalent
to the [GeoJson geometry `multi-line` type](https://tools.ietf.org/html/rfc7946#section-3.1).
-}
geoLines : List (List ( Float, Float )) -> Geometry
geoLines =
    GeoLines


{-| Geometry objects to be used in a `geoshape` specification. Each geometry
object can be created with [geometry](#geometry).

    geojson =
        geometryCollection
            [ geometry (geoPolygon [ [ ( -3, 59 ), ( 4, 59 ), ( 4, 52 ), ( -3, 59 ) ] ]) []
            , geometry (geoPoint -3.5 55.5) []
            ]

-}
geometryCollection : List Spec -> Spec
geometryCollection geoms =
    JE.object
        [ ( "type", JE.string "GeometryCollection" )
        , ( "geometries", toList geoms )
        ]


{-| Geometric object to be used in a `geoshape`. The first parameter is
the geometric type, the second an optional list of properties to be associated
with the object.

      geojson =
          geometry (geoPolygon [ [ ( -3, 59 ), ( 4, 59 ), ( 4, 52 ), ( -3, 59 ) ] ]) []

-}
geometry : Geometry -> List ( String, DataValue ) -> Spec
geometry gType properties =
    if properties == [] then
        JE.object
            [ ( "type", JE.string "Feature" )
            , ( "geometry", JE.object (geometryTypeProperties gType) )
            ]

    else
        JE.object
            [ ( "type", JE.string "Feature" )
            , ( "geometry", JE.object (geometryTypeProperties gType) )
            , ( "properties", JE.object (List.map (\( k, val ) -> ( k, dataValueSpec val )) properties) )
            ]


{-| Point geometry for programmatically creating GeoShapes. Equivalent to
the [GeoJson geometry `point` type](https://tools.ietf.org/html/rfc7946#section-3.1).
-}
geoPoint : Float -> Float -> Geometry
geoPoint =
    GeoPoint


{-| Multi-point geometry for programmatically creating GeoShapes. Equivalent
to the [GeoJson geometry `multi-point` type](https://tools.ietf.org/html/rfc7946#section-3.1).
-}
geoPoints : List ( Float, Float ) -> Geometry
geoPoints =
    GeoPoints


{-| Polygon geometry for programmatically creating GeoShapes. Equivalent
to the [GeoJson geometry `polygon` type](https://tools.ietf.org/html/rfc7946#section-3.1).
-}
geoPolygon : List (List ( Float, Float )) -> Geometry
geoPolygon =
    GeoPolygon


{-| Multi-polygon geometry for programmatically creating GeoShapes. Equivalent
to the [GeoJson geometry `multi-polygon` type](https://tools.ietf.org/html/rfc7946#section-3.1).
-}
geoPolygons : List (List (List ( Float, Float ))) -> Geometry
geoPolygons =
    GeoPolygons


{-| [Geoshape](https://vega.github.io/vega-lite/docs/geoshape.html)
determined by geographically referenced coordinates.

    let
        data =
            dataFromUrl "city.json" [ topojsonFeature "boroughs" ]
    in
    toVegaLite
        [ data
        , geoshape [ maFill "lightgrey", maStroke "white" ]
        ]

-}
geoshape : List MarkProperty -> ( VLProperty, Spec )
geoshape =
    mark Geoshape


{-| A gnomonic map projection.
-}
gnomonic : Projection
gnomonic =
    Gnomonic


{-| Generate a grid of lines of longitude (meridians) and latitude (parallels).
The parameter can be used to specify the number and extent of lines, or to use
default values, provide an empty list.

    let
        proj =
            projection [ prType orthographic ]

        sphereSpec =
            asSpec [ sphere, geoshape [ maFill "aliceblue" ] ]

        gratSpec =
            asSpec
                [ graticule [ grStep ( 5, 5 ) ]
                , geoshape [ maFilled False, maStrokeWidth 0.3 ]
                ]
    in
    toVegaLite [ proj, layer [ sphereSpec, gratSpec ] ]

-}
graticule : List GraticuleProperty -> Data
graticule grProps =
    if grProps == [] then
        ( VLData, JE.object [ ( "graticule", JE.bool True ) ] )

    else
        ( VLData
        , JE.object [ ( "graticule", JE.object (List.map graticuleProperty grProps) ) ]
        )


{-| Set the extent of both major and minor graticule lines. The first parameter
is a (longitude,latitude) pair defining the minimum extent, the second parameter
the maximum extent.
-}
grExtent : ( Float, Float ) -> ( Float, Float ) -> GraticuleProperty
grExtent =
    GrExtent


{-| Set the extent of major graticule lines. The first parameter is a
(longitude,latitude) pair defining the minimum extent, the second parameter
the maximum extent.
-}
grExtentMajor : ( Float, Float ) -> ( Float, Float ) -> GraticuleProperty
grExtentMajor =
    GrExtentMajor


{-| Set the extent of minor graticule lines. The first parameter is a
(longitude,latitude) pair defining the minimum extent, the second parameter
the maximum extent.
-}
grExtentMinor : ( Float, Float ) -> ( Float, Float ) -> GraticuleProperty
grExtentMinor =
    GrExtentMinor


{-| Indicate a linear color gradient. See the
[Vega-Lite color gradient documentation](https://vega.github.io/vega-lite/docs/types.html#linear-gradient).
-}
grLinear : ColorGradient
grLinear =
    GrLinear


{-| The radius, normalised to [0, 1], of the inner circle for a radial color gradient.
Default is 0.
-}
grR1 : Float -> GradientProperty
grR1 =
    GrR1


{-| The radius, normalised to [0, 1], of the outer circle for a radial color gradient.
Default is 0.5.
-}
grR2 : Float -> GradientProperty
grR2 =
    GrR2


{-| Indicate a radial color gradient. See the
[Vega-Lite color gradient documentation](https://vega.github.io/vega-lite/docs/types.html#radial-gradient).
-}
grRadial : ColorGradient
grRadial =
    GrRadial


{-| Set the step sizes between all graticule lines. The parameter is a
(longitude,latitude) pair defining the EW and NS graticule intervals respectively.
-}
grStep : ( Float, Float ) -> GraticuleProperty
grStep =
    GrStep


{-| Set the step sizes between major graticule lines. By default, major graticule
lines extend to both poles, but minor lines stop at ±80 degrees latitude. The parameter
is a (longitude,latitude) pair defining the EW and NS graticule intervals respectively.
-}
grStepMajor : ( Float, Float ) -> GraticuleProperty
grStepMajor =
    GrStepMajor


{-| Set the step sizes between minor graticule lines. By default, major graticule
lines extend to both poles, but minor lines stop at ±80 degrees latitude. The parameter
is a (longitude,latitude) pair defining the EW and NS graticule intervals respectively.
-}
grStepMinor : ( Float, Float ) -> GraticuleProperty
grStepMinor =
    GrStepMinor


{-| Color interpolation points. Each tuple in the list is a position normalised
[0, 1] and its associated color.
-}
grStops : List ( Float, String ) -> GradientProperty
grStops =
    List.sortBy Tuple.first >> GrStops


{-| The precision of the graticule in degrees. If unspecified, the default of 2.5
degrees is used. Smaller values provide a less stepped appearance of curved lines
but take longer to render.
-}
grPrecision : Float -> GraticuleProperty
grPrecision =
    GrPrecision


{-| The x-coordinate, normalised to [0, 1], for the start of a color gradient. If
the gradient is linear the default is 0; if radial, it is the x-position of the
centre of the inner circle with a default of 0.5.
-}
grX1 : Float -> GradientProperty
grX1 =
    GrX1


{-| The x-coordinate, normalised to [0, 1], for the end of a color gradient. If
the gradient is linear the default is 1; if radial, it is the x-position of the
centre of the outer circle with a default of 0.5.
-}
grX2 : Float -> GradientProperty
grX2 =
    GrX2


{-| The y-coordinate, normalised to [0, 1], for the start of a color gradient. If
the gradient is linear the default is 0; if radial, it is the y-position of the
centre of the inner circle with a default of 0.5.
-}
grY1 : Float -> GradientProperty
grY1 =
    GrY1


{-| The y-coordinate, normalised to [0, 1], for the end of a color gradient. If
the gradient is linear the default is 1; if radial, it is the y-position of the
centre of the outer circle with a default of 0.5.
-}
grY2 : Float -> GradientProperty
grY2 =
    GrY2


{-| Center horizontal text alignment.
-}
haCenter : HAlign
haCenter =
    HAlignCenter


{-| Compute some aggregate summary statistics for a field to be encoded with a
hyperlink channel. The type of aggregation is determined by the given operation
parameter.
-}
hAggregate : Operation -> HyperlinkChannel
hAggregate =
    HAggregate


{-| Expression that evaluates to some text alignment such as "left", "right" or "center".
-}
haExpr : String -> HAlign
haExpr =
    HAlignExpr


{-| Left horizontal text alignment.
-}
haLeft : HAlign
haLeft =
    HAlignLeft


{-| Right horizontal text alignment.
-}
haRight : HAlign
haRight =
    HAlignRight


{-| Discretize numeric values into bins when encoding with a hyperlink channel.
-}
hBin : List BinProperty -> HyperlinkChannel
hBin =
    HBin


{-| Indicate that data encoded with a hyperlink channel are already binned.
-}
hBinned : HyperlinkChannel
hBinned =
    HBinned


{-| HCL color interpolation for continuous color scales.
-}
hcl : CInterpolate
hcl =
    Hcl


{-| HCL color interpolation in polar coordinate space for continuous color scales.
-}
hclLong : CInterpolate
hclLong =
    HclLong


{-| Specifications to be juxtaposed horizontally in a column layout of views.
-}
hConcat : List Spec -> ( VLProperty, Spec )
hConcat specs =
    ( VLHConcat, toList specs )


{-| Make a hyperlink channel encoding conditional on a predicate expression. A predicate
might be the result of evaluating a parameter ([prParam](#prParam)) or an expression
([prTest](#prTest)). The first parameter is the predicate that evaluates to true
or false; the second the encoding if true, the third the encoding if false.
-}
hCondition : Predicate -> List HyperlinkChannel -> List HyperlinkChannel -> HyperlinkChannel
hCondition =
    HCondition


{-| Deprecated in favour of [hCondition](#hCondition).
-}
hDataCondition : BooleanOp -> List HyperlinkChannel -> List HyperlinkChannel -> HyperlinkChannel
hDataCondition =
    HDataCondition False


{-| [Formatting pattern](https://vega.github.io/vega-lite/docs/format.html) for
facet header (title) values. To distinguish between formatting as numeric values
and data/time values, additionally use [hdFormatAsNum](#hdFormatAsNum),
[hdFormatAsTemporal](#hdFormatAsTemporal) or [hdFormatAsCustom](#hdFormatAsCustom).
-}
hdFormat : String -> HeaderProperty
hdFormat =
    HFormat


{-| Indicate that facet headers should be formatted with a registered custom formatter
with the given name. See [how to register a Vega-Lite custom formatter](https://vega.github.io/vega-lite/usage/compile.html#format-type).
-}
hdFormatAsCustom : String -> HeaderProperty
hdFormatAsCustom =
    HFormatAsCustom


{-| Indicate that facet headers should be formatted as numbers. To control the
precise numeric format, additionally use [hdFormat](#hdFormat) providing a
[d3 numeric format string](https://github.com/d3/d3-format#locale_format).
-}
hdFormatAsNum : HeaderProperty
hdFormatAsNum =
    HFormatAsNum


{-| Indicate that facet headers should be formatted as dates/times. To control the
precise temporal format, additionally use [hdFormat](#hdFormat) providing a
[d3 date/time format string](https://github.com/d3/d3-time-format#locale_format).
-}
hdFormatAsTemporal : HeaderProperty
hdFormatAsTemporal =
    HFormatAsTemporal


{-| Horizontal alignment of header labels. A 'label' is the
title for each sub-plot in a faceted view.
-}
hdLabelAlign : HAlign -> HeaderProperty
hdLabelAlign =
    HLabelAlign


{-| Anchor position of header labels. A 'label' is the title for each sub-plot
in a faceted view.
-}
hdLabelAnchor : Anchor -> HeaderProperty
hdLabelAnchor =
    HLabelAnchor


{-| Vertical alignment of header labels.
-}
hdLabelBaseline : VAlign -> HeaderProperty
hdLabelBaseline =
    HLabelBaseline


{-| Header label rotation angle (in degrees from horizontal) for a faceted view.
A 'label' is the title for each sub-plot in a faceted view.
-}
hdLabelAngle : Float -> HeaderProperty
hdLabelAngle x =
    HLabelAngle (Num (positiveAngle x))


{-| Header label text color for a faceted view.
-}
hdLabelColor : String -> HeaderProperty
hdLabelColor s =
    HLabelColor (Str s)


{-| [Expression](https://vega.github.io/vega/docs/expressions/) for customising
header labels. Can reference `datum.value` and `datum.label` for access to the
underlying data values and label text respectively.
-}
hdLabelExpr : String -> HeaderProperty
hdLabelExpr =
    HLabelExpr


{-| Header label font in a faceted view.
-}
hdLabelFont : String -> HeaderProperty
hdLabelFont s =
    HLabelFont (Str s)


{-| Header label font size in a faceted view.
-}
hdLabelFontSize : Float -> HeaderProperty
hdLabelFontSize n =
    HLabelFontSize (Num n)


{-| Header label font style (e.g. `italic`) in a faceted view.
-}
hdLabelFontStyle : String -> HeaderProperty
hdLabelFontStyle s =
    HLabelFontStyle (Str s)


{-| Header label font weight in a faceted view.
-}
hdLabelFontWeight : FontWeight -> HeaderProperty
hdLabelFontWeight =
    HLabelFontWeight


{-| Maximum length of a header label in a faceted view.
-}
hdLabelLimit : Float -> HeaderProperty
hdLabelLimit n =
    HLabelLimit (Num n)


{-| Header label line height in a faceted view (useful for multi-line labels).
-}
hdLabelLineHeight : Float -> HeaderProperty
hdLabelLineHeight n =
    HLabelLineHeight (Num n)


{-| The position of a header label relative to a sub-plot. A 'label' is the title
for each sub-plot in a faceted view.
-}
hdLabelOrient : Side -> HeaderProperty
hdLabelOrient =
    HLabelOrient


{-| Spacing in pixels between facet labels and the main plot area.
-}
hdLabelPadding : Float -> HeaderProperty
hdLabelPadding x =
    HLabelPadding (Num x)


{-| Whether or not labels in a faceted view are displayed.
-}
hdLabels : Bool -> HeaderProperty
hdLabels =
    HLabels


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to a
facet header property function requiring a numeric value. This can be used for interactive
parameterisation when an expression is bound to an input element. For example,

    ps =
        params
            << param "size"
                [ paValue (num 12)
                , paBind (ipRange [ inMax 32 ])
                ]

    enc =
        encoding
            << column
                [ fName "country"
                , fHeader [ hdNumExpr "size" hdLabelFontSize ]
                ]

-}
hdNumExpr : String -> (number -> HeaderProperty) -> HeaderProperty
hdNumExpr ex fn =
    case fn 0 of
        HLabelAngle _ ->
            HLabelAngle (NumExpr ex)

        HLabelFontSize _ ->
            HLabelFontSize (NumExpr ex)

        HLabelLimit _ ->
            HLabelLimit (NumExpr ex)

        HLabelLineHeight _ ->
            HLabelLineHeight (NumExpr ex)

        HLabelPadding _ ->
            HLabelPadding (NumExpr ex)

        HTitleAngle _ ->
            HTitleAngle (NumExpr ex)

        HTitleFontSize _ ->
            HTitleFontSize (NumExpr ex)

        HTitleLimit _ ->
            HTitleLimit (NumExpr ex)

        HTitleLineHeight _ ->
            HTitleLineHeight (NumExpr ex)

        HTitlePadding _ ->
            HTitlePadding (NumExpr ex)

        _ ->
            fn 0


{-| The relative position of both a header label and title relative to a sub-plot
(shortcut instead of specifying [hdLabelOrient](#hdLabelOrient) and [hdTitleOrient](#hdTitleOrient)
separately).
-}
hdOrient : Side -> HeaderProperty
hdOrient =
    HOrient


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to
a facet header property function requiring a string value. This can be used to provide an
interactive parameterisation of a header property when an expression is bound to an
input element. For example,

    ps =
        params
            << param "color"
                [ paValue (str "black")
                , paBind (ipColor [])
                ]

    enc =
        encoding
            << column
                [ fName "country"
                , fHeader [ hdStrExpr "color" hdLabelColor ]
                ]

-}
hdStrExpr : String -> (String -> HeaderProperty) -> HeaderProperty
hdStrExpr ex fn =
    case fn "" of
        HLabelColor _ ->
            HLabelColor (StrExpr ex)

        HLabelFont _ ->
            HLabelFont (StrExpr ex)

        HLabelFontStyle _ ->
            HLabelFontStyle (StrExpr ex)

        HTitleColor _ ->
            HTitleColor (StrExpr ex)

        HTitleFont _ ->
            HTitleFont (StrExpr ex)

        HTitleFontStyle _ ->
            HTitleFontStyle (StrExpr ex)

        _ ->
            fn ""


{-| Header title in a faceted view. A 'title' is the overall title describing the
collection of faceted plots. For multi-line titles, insert `\n` at each line break
or use a `"""` multi-line string.
-}
hdTitle : String -> HeaderProperty
hdTitle =
    HTitle


{-| Horizontal alignment of header title in a faceted view.
-}
hdTitleAlign : HAlign -> HeaderProperty
hdTitleAlign =
    HTitleAlign


{-| Anchor position of a header title in a faceted view.
-}
hdTitleAnchor : Anchor -> HeaderProperty
hdTitleAnchor =
    HTitleAnchor


{-| Text angle of a header title in a faceted view (degrees from horizontal).
-}
hdTitleAngle : Float -> HeaderProperty
hdTitleAngle x =
    HTitleAngle (Num (positiveAngle x))


{-| Vertical alignment of a header title in a faceted view.
-}
hdTitleBaseline : VAlign -> HeaderProperty
hdTitleBaseline =
    HTitleBaseline


{-| Text color of a header title in a faceted view.
-}
hdTitleColor : String -> HeaderProperty
hdTitleColor s =
    HTitleColor (Str s)


{-| Title font in a faceted view.
-}
hdTitleFont : String -> HeaderProperty
hdTitleFont s =
    HTitleFont (Str s)


{-| Title font size in a faceted view.
-}
hdTitleFontSize : Float -> HeaderProperty
hdTitleFontSize x =
    HTitleFontSize (Num x)


{-| Header title font style (e.g. `italic`) in a faceted view.
-}
hdTitleFontStyle : String -> HeaderProperty
hdTitleFontStyle s =
    HTitleFontStyle (Str s)


{-| Title font weight in a faceted view.
-}
hdTitleFontWeight : FontWeight -> HeaderProperty
hdTitleFontWeight =
    HTitleFontWeight


{-| Maximum length of a header title in a faceted view.
-}
hdTitleLimit : Float -> HeaderProperty
hdTitleLimit x =
    HTitleLimit (Num x)


{-| Header title line height in a faceted view (useful for multi-line titles).
-}
hdTitleLineHeight : Float -> HeaderProperty
hdTitleLineHeight x =
    HTitleLineHeight (Num x)


{-| The position of a header title relative to a group of sub-plots in a faceted
view.
-}
hdTitleOrient : Side -> HeaderProperty
hdTitleOrient =
    HTitleOrient


{-| Spacing in pixels between the main facet title and labels.
-}
hdTitlePadding : Float -> HeaderProperty
hdTitlePadding x =
    HTitlePadding (Num x)


{-| Override the default height of the visualization. If not specified the height
will be calculated based on the content of the visualization. How the content is
sized relative to this height specification can be customised with [autosize](#autosize).
-}
height : Float -> ( VLProperty, Spec )
height h =
    ( VLHeight, JE.float h )


{-| Set the height of the view to be that of the surrounding container. Allows
responsive sizing to be specified.
-}
heightOfContainer : ( VLProperty, Spec )
heightOfContainer =
    ( VLHeight, JE.string "container" )


{-| Set the height of the discrete y-field (e.g. individual bars in a horizontal
bar chart). The total height is then calculated based on the number of discrete
fields (e.g. bars).

    toVegaLite [ heightStep 17, data [], enc [], bar [] ]

-}
heightStep : Float -> ( VLProperty, Spec )
heightStep hs =
    ( VLHeightStep, JE.object [ ( "step", JE.float hs ) ] )


{-| Indicate a data field encoded as a hyperlink property is a geo feature.
Equivalent to `hMType GeoFeature`.
-}
hGeo : HyperlinkChannel
hGeo =
    HmType GeoFeature


{-| Level of measurement when encoding with a hyperlink or url channel. See also
[hNominal](#hNominal), [hOrdinal](#hOrdinal), [hQuant](#hQuant), [hTemporal](#hTemporal)
and [hGeo](#hGeo) for shorthand equivalents.
-}
hMType : Measurement -> HyperlinkChannel
hMType =
    HmType


{-| Name of field used for encoding with a hyperlink channel.
-}
hName : String -> HyperlinkChannel
hName =
    HName


{-| Indicate a data field encoded as a hyperlink or url property is nominal.
Equivalent to `hMType Nominal`. This is the default data type.
-}
hNominal : HyperlinkChannel
hNominal =
    HmType Nominal


{-| Indicate a data field encoded as a hyperlink property is ordinal. Equivalent to
`hMType Ordinal`.
-}
hOrdinal : HyperlinkChannel
hOrdinal =
    HmType Ordinal


{-| Hour of the day time unit used for discretizing temporal data.
-}
hours : TimeUnit
hours =
    Hours


{-| Hours and minutes time unit used for discretizing temporal data.
-}
hoursMinutes : TimeUnit
hoursMinutes =
    HoursMinutes


{-| Hours, minutes and seconds time unit used for discretizing temporal data.
-}
hoursMinutesSeconds : TimeUnit
hoursMinutesSeconds =
    HoursMinutesSeconds


{-| Reference in a hyperlink channel to a field name generated by [repeatFlow](#repeatFlow)
or [repeat](#repeat). The parameter identifies whether reference is being made to
fields that are to be arranged in columns, in rows or a with a flow layout.
-}
hRepeat : Arrangement -> HyperlinkChannel
hRepeat =
    HRepeat


{-| Deprecated in favour of [hCondition](#hCondition).
-}
hSelectionCondition : BooleanOp -> List HyperlinkChannel -> List HyperlinkChannel -> HyperlinkChannel
hSelectionCondition =
    HDataCondition True


{-| HSL color interpolation for continuous color scales.
-}
hsl : CInterpolate
hsl =
    Hsl


{-| HSL color interpolation in polar coordinate space for continuous color scales.
-}
hslLong : CInterpolate
hslLong =
    HslLong


{-| Literal string value when encoding with a hyperlink channel.
-}
hStr : String -> HyperlinkChannel
hStr =
    HString


{-| Indicate a data field encoded as a hyperlink or url property is temporal.
Equivalent to `hMType Temporal`.
-}
hTemporal : HyperlinkChannel
hTemporal =
    HmType Temporal


{-| Indicate a data field encoded as a hyperlink or url property is quantitative.
Equivalent to `hMType Quantitative`.
-}
hQuant : HyperlinkChannel
hQuant =
    HmType Quantitative


{-| Time unit aggregation of field values when encoding with a hyperlink channel.
-}
hTimeUnit : TimeUnit -> HyperlinkChannel
hTimeUnit =
    HTimeUnit


{-| Encode a hyperlink channel. The first parameter is a list of hyperlink channel
properties that characterise the hyperlinking such as the destination URL and cursor
type.

    encData =
        encoding
            << hyperlink [ hName "url", hNominal ]

    encLiteral =
        encoding
            << hyperlink [ hStr "http://www.imdb.com" ]

-}
hyperlink : List HyperlinkChannel -> List LabelledSpec -> List LabelledSpec
hyperlink hyperProps =
    (::) ( "href", JE.object (List.concatMap hyperlinkChannelProperties hyperProps) )


{-| Deprecated in favour of [ipCheckbox](#ipCheckbox).
-}
iCheckbox : String -> List InputProperty -> Binding
iCheckbox f =
    ICheckbox f


{-| Deprecated in favour of [ipColor](#ipColor).
-}
iColor : String -> List InputProperty -> Binding
iColor f =
    IColor f


{-| Deprecated in favour of [ipDate](#ipDate).
-}
iDate : String -> List InputProperty -> Binding
iDate f =
    IDate f


{-| Deprecated in favour of [ipDateTimeLocal](#ipDateTimeLocal).
-}
iDateTimeLocal : String -> List InputProperty -> Binding
iDateTimeLocal f =
    IDateTimeLocal f


{-| An 'identity' projection where longitude is projected directly to the x position
and latitude to the y position. Can also reflect either of the coordinates by
specifying [prReflectX](#prReflectX) / [prReflectY](#prReflectY) in the list of
projection properties.
-}
identityProjection : Projection
identityProjection =
    Identity


{-| [Image mark](https://vega.github.io/vega-lite/docs/image.html) for displaying
an image. The parameter is a list of standard mark properties for customising the
image. The image files to be displayed should be specified via the [url](#url)
channel. Normally, the width and height of the image should be specified with
[maWidth](#maWidth) and [maHeight](#maHeight).

    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 0.5, 1.5, 2.5 ])
                << dataColumn "y" (nums [ 0.5, 1.5, 2.5 ])

        enc =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y [ pName "y", pQuant ]
                << url [ hStr "myImage.png" ]
    in
    toVegaLite [ data [], enc [], image [ maWidth 50, maHeight 25 ] ]

Alternatively, data-driven images can be used by referencing a data field containing
image URLs.

    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 0.5, 1.5, 2.5 ])
                << dataColumn "y" (nums [ 0.5, 1.5, 2.5 ])
                << dataColumn "img" (strs [ "img1.png", "img2.png", "img3.png" ])

        enc =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y [ pName "y", pQuant ]
                << url [ hName "img", hNominal ]
    in
    toVegaLite [ data [], enc [], image [ maWidth 30, maHeight 30 ] ]

-}
image : List MarkProperty -> ( VLProperty, Spec )
image =
    mark Image


{-| 1d window over which data imputation values are generated. The two
parameters should either be `Just` a number indicating the offset from the current
data object, or `Nothing` to indicate unbounded rows preceding or following the
current data object.
-}
imFrame : Maybe Int -> Maybe Int -> ImputeProperty
imFrame =
    ImFrame


{-| Allow imputing of missing values on a per-group basis. For use with the impute
transform only and not a channel encoding.
-}
imGroupBy : List String -> ImputeProperty
imGroupBy =
    ImGroupBy


{-| Key values to be considered for imputation.
-}
imKeyVals : DataValues -> ImputeProperty
imKeyVals =
    ImKeyVals


{-| Key values to be considered for imputation as a sequence of numbers between
a start (first parameter), to less than an end (second parameter) in steps of
the third parameter.
-}
imKeyValSequence : Float -> Float -> Float -> ImputeProperty
imKeyValSequence =
    ImKeyValSequence


{-| Use maximum of values when imputing missing data.
-}
imMax : ImMethod
imMax =
    ImMax


{-| Use mean of values when imputing missing data.
-}
imMean : ImMethod
imMean =
    ImMean


{-| Use median of values when imputing missing data.
-}
imMedian : ImMethod
imMedian =
    ImMedian


{-| Imputation method to use when replacing values.
-}
imMethod : ImMethod -> ImputeProperty
imMethod =
    ImMethod


{-| Use maximum of values when imputing missing data.
-}
imMin : ImMethod
imMin =
    ImMin


{-| New value to use when imputing with [imValue](#imValue).
-}
imNewValue : DataValue -> ImputeProperty
imNewValue =
    ImNewValue


{-| Deprecated in favour of [ipMonth](#ipMonth).
-}
iMonth : String -> List InputProperty -> Binding
iMonth f =
    IMonth f


{-| Impute missing data values as a data transform. The first parameter is the
data field to process; the second the key field to uniquely identify data objects
within a group; the third customisable options.

For example, to impute the missing value of `b` with the mean of existing `b` values,
when `a` is 30 and its color group (`c`) is 1:

    let
        data =
            dataFromColumns []
                << dataColumn "a" (nums [ 0, 0, 10, 10, 20, 20, 30 ])
                << dataColumn "b" (nums [ 28, 91, 43, 55, 81, 53, 19 ])
                << dataColumn "c" (nums [ 0, 1, 0, 1, 0, 1, 0 ])

        trans =
            transform
                << impute "b" "a" [ imMethod imMean, imGroupBy [ "c" ] ]

        enc =
            encoding
                << position X [ pName "a", pQuant ]
                << position Y [ pName "b", pQuant ]
                << color [ mName "c", mNominal ]
    in
    toVegaLite [ data [], trans [], enc [], line [] ]

-}
impute : String -> String -> List ImputeProperty -> List LabelledSpec -> List LabelledSpec
impute fields k imProps =
    (::)
        ( "multiSpecs"
        , JE.object
            ([ ( "impute", JE.string fields ), ( "key", JE.string k ) ]
                ++ List.map imputeProperty imProps
            )
        )


{-| Use field value when imputing missing data.
-}
imValue : ImMethod
imValue =
    ImValue


{-| Options for a radio or select input element. Similar to [inDatumOptions](#inDatumOptions)
except that each option can be a list of data values. For example,

    inDataOptions [ nums [ 2, 3, 5, 7, 11, 13 ], boos [ True, False ] ]

-}
inDataOptions : List DataValues -> InputProperty
inDataOptions =
    InDataOptions


{-| Options for a radio or select input element. Unlike [inOptions](#inOptions),
this allows for mixed data types to be listed. For example, to create a list of
numbers and boolean values:

    inDatumOptions [ num 2, num 3, boo False, boo True ]

-}
inDatumOptions : List DataValue -> InputProperty
inDatumOptions =
    InDatumOptions


{-| Delay to introduce when processing input events in order to avoid unnecessary
event broadcasting.
-}
inDebounce : Float -> InputProperty
inDebounce =
    Debounce


{-| CSS selector indicating the parent element to which an input element should
be added. Allows the option of the input element to be outside the visualization
container.
-}
inElement : String -> InputProperty
inElement =
    Element


{-| Maximum slider value for a range input element.
-}
inMax : Float -> InputProperty
inMax =
    InMax


{-| Minimum slider value for a range input element.
-}
inMin : Float -> InputProperty
inMin =
    InMin


{-| Custom label for a radio or select input element.
-}
inName : String -> InputProperty
inName =
    InName


{-| Options for a radio or select input element. Assumes all options are strings.
For other types, consider [inDatumOptions](#inDatumOptions) or [inDataOptions](#inDataOptions).
-}
inOptions : List String -> InputProperty
inOptions =
    InOptions


{-| Initial place-holding text for input elements such as text fields.
-}
inPlaceholder : String -> InputProperty
inPlaceholder =
    InPlaceholder


{-| Minimum input element range slider increment.
-}
inStep : Float -> InputProperty
inStep =
    InStep


{-| Deprecated in favour of [ipNumber](#ipNumber).
-}
iNumber : String -> List InputProperty -> Binding
iNumber f =
    INumber f


{-| Checkbox input element that can bound to a named parameter.
-}
ipCheckbox : List InputProperty -> PBinding
ipCheckbox =
    IPCheckbox


{-| Color input element that can bound to a named parameter.
-}
ipColor : List InputProperty -> PBinding
ipColor =
    IPColor


{-| Date input element that can bound to a named parameter.
-}
ipDate : List InputProperty -> PBinding
ipDate =
    IPDate


{-| Local time input element that can bound to a named parameter.
-}
ipDateTimeLocal : List InputProperty -> PBinding
ipDateTimeLocal =
    IPDateTimeLocal


{-| Month input element that can bound to a named parameter.
-}
ipMonth : List InputProperty -> PBinding
ipMonth =
    IPMonth


{-| Number input element that can bound to a named parameter.
-}
ipNumber : List InputProperty -> PBinding
ipNumber =
    IPNumber


{-| Radio box input element that can bound to a named parameter.
-}
ipRadio : List InputProperty -> PBinding
ipRadio =
    IPRadio


{-| Range slider input element that can bound to a named parameter.
-}
ipRange : List InputProperty -> PBinding
ipRange =
    IPRange


{-| Select input element that can bound to a named parameter.
-}
ipSelect : List InputProperty -> PBinding
ipSelect =
    IPSelect


{-| Telephone number input element that can bound to a named parameter.
-}
ipTel : List InputProperty -> PBinding
ipTel =
    IPTel


{-| Text input element that can bound to a named parameter.
-}
ipText : List InputProperty -> PBinding
ipText =
    IPText


{-| Time input element that can bound to a named parameter.
-}
ipTime : List InputProperty -> PBinding
ipTime =
    IPTime


{-| Week input element that can bound to a named parameter.
-}
ipWeek : List InputProperty -> PBinding
ipWeek =
    IPWeek


{-| Deprecated in favour of [ipRadio](#ipRadio).
-}
iRadio : String -> List InputProperty -> Binding
iRadio f =
    IRadio f


{-| Deprecated in favour of [ipRange](#ipRange).
-}
iRange : String -> List InputProperty -> Binding
iRange f =
    IRange f


{-| Deprecated in favour of [ipSelect](#ipSelect).
-}
iSelect : String -> List InputProperty -> Binding
iSelect f =
    ISelect f


{-| Deprecated in favour of [ipTel](#ipTel).
-}
iTel : String -> List InputProperty -> Binding
iTel f =
    ITel f


{-| Deprecated in favour of [ipText](#ipText).
-}
iText : String -> List InputProperty -> Binding
iText f =
    IText f


{-| Deprecated in favour of [ipTime](#ipTime).
-}
iTime : String -> List InputProperty -> Binding
iTime f =
    ITime f


{-| Deprecated in favour of [ipWeek](#ipWeek).
-}
iWeek : String -> List InputProperty -> Binding
iWeek f =
    IWeek f


{-| Convert a string representing some JSON into a Spec. Useful when combined
with [dataFromJson](#dataFromJson) to compactly import inline JSON as data. For
example,

    data =
        jsonToSpec
            """
            {
                "Revenue" : [ 150, 225, 300 ],
                "Profit" : [ 20, 25, 30 ],
                "Order size" : [ 350, 500, 600 ],
                "New customers" : [ 1400, 2000, 2500 ],
                "Satisfaction" : [ 3.5, 4.25, 5 ]
            }
            """
            |> dataFromJson

This can also be used to store a full visualization specification from a JSON object.
But note this is not type-safe – if the JSON is not well-formed, a null value is returned.

-}
jsonToSpec : String -> Spec
jsonToSpec =
    let
        jsDecoder () =
            JD.oneOf
                [ JD.map JE.string JD.string
                , JD.map JE.int JD.int
                , JD.map JE.float JD.float
                , JD.map JE.bool JD.bool
                , JD.map (JE.list identity) (JD.lazy jsDecoder |> JD.list)
                , JD.map (Dict.toList >> JE.object) (JD.lazy jsDecoder |> JD.dict)
                , JD.null JE.null
                ]
    in
    JD.decodeString (jsDecoder ()) >> Result.withDefault JE.null


{-| Bevelled stroke join.
-}
joBevel : StrokeJoin
joBevel =
    JBevel


{-| Expression that evaluates to some stroke join style such as "bevel", "miter"
or "round".
-}
joExpr : String -> StrokeJoin
joExpr =
    JExpr


{-| Aggregation transformations to be used when encoding channels. Unlike
[aggregate](#aggregate), this transformation joins the results to the input data.
Can be helpful for creating derived values that combine raw data with some aggregate
measure, such as percentages of group totals. The first parameter is a list
of the named aggregation operations to apply. The second is a list of possible
window aggregate field properties, such as a field to group by when aggregating.
The third parameter is a list of transformations to which this is added.

    transform
        << joinAggregate [ opAs opMean "rating" "avYearRating" ]
            [ wiGroupBy [ "year" ] ]
        << filter (fiExpr "(datum.rating - datum.avYearRating) > 3")

For details, see the
[Vega-Lite join aggregate documentation](https://vega.github.io/vega-lite/docs/joinaggregate.html)

-}
joinAggregate : List Spec -> List WindowProperty -> List LabelledSpec -> List LabelledSpec
joinAggregate ops wProps =
    (::)
        ( "multiSpecs"
        , JE.object (( "joinaggregate", toList ops ) :: List.map windowProperty wProps)
        )


{-| Mitred stroke join.
-}
joMiter : StrokeJoin
joMiter =
    JMiter


{-| Rounded stroke join.
-}
joRound : StrokeJoin
joRound =
    JRound


{-| Property to be extracted from some JSON when it has some surrounding structure.
e.g., specifying the property `values.features` is equivalent to retrieving
`json.values.features` from a JSON object with a custom delimiter.
-}
jsonProperty : String -> Format
jsonProperty =
    JSON


{-| Encode a key channel for use with the [Vega View API](https://vega.github.io/vega/docs/api/view/#data).
The first parameter identifies a list of key encoding options (just the name of
the data field to use as a unique key for data binding and its type).
-}
key : List KeyChannel -> List LabelledSpec -> List LabelledSpec
key kProps =
    (::) ( "key", List.map keyChannelProperty kProps |> JE.object )


{-| Indicate a data field encoded as a key channel property stores geo-features.
Equivalent to `kMType GeoFeature`.
-}
kGeo : KeyChannel
kGeo =
    KmType GeoFeature


{-| Level of measurement when encoding with a key channel. See also [kNominal](#kNominal),
[kOrdinal](#kOrdinal), [kQuant](#kQuant), [kTemporal](#kTemporal) and [kGeo](#kGeo)
for shorthand equivalents.
-}
kMType : Measurement -> KeyChannel
kMType =
    KmType


{-| Name of field used for encoding with a key channel.
-}
kName : String -> KeyChannel
kName =
    KName


{-| Indicate a data field encoded as a key channel property is nominal. Equivalent
to `kMType Nominal`. This is the default data type.
-}
kNominal : KeyChannel
kNominal =
    KmType Nominal


{-| Indicate a data field encoded as a key channel property is ordinal. Equivalent
to `kMType Ordinal`.
-}
kOrdinal : KeyChannel
kOrdinal =
    KmType Ordinal


{-| Indicate a data field encoded as a key channel property is quantitative.
Equivalent to `kMType Quantitative`.
-}
kQuant : KeyChannel
kQuant =
    KmType Quantitative


{-| Indicate a data field encoded as a key channel property is temporal.
Equivalent to `kMType Temporal`.
-}
kTemporal : KeyChannel
kTemporal =
    KmType Temporal


{-| Lab color interpolation for continuous color scales.
-}
lab : CInterpolate
lab =
    Lab


{-| Assign a list of specifications to superposed layers in a visualization.
For example, adding text annotations to a bar chart:

    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 1, 2, 3, 4, 5 ])
                << dataColumn "a" (nums [ 28, 91, 43, 55, 81 ])

        enc =
            encoding
                << position X [ pName "x", pOrdinal ]
                << position Y [ pName "a", pQuant ]
                << text [ tName "a", tNominal ]
    in
    toVegaLite
        [ data []
        , enc []
        , layer
            [ asSpec [ bar [] ]
            , asSpec [ textMark [ maDy -8 ], enc [] ]
            ]
        ]

-}
layer : List Spec -> ( VLProperty, Spec )
layer specs =
    ( VLLayer, toList specs )


{-| Create a list of fields to use in set of repeated layers. The list of fields
named here can be referenced in an encoding with `pRepeat layer`, `mRepeat layer` etc.
-}
layerFields : List String -> RepeatFields
layerFields =
    LayerFields


{-| [ARIA](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA) properties
for providing accessible SVG output associated with a legend. If an empty list is
provided, ARIA tagging will be switched off.
-}
leAria : List Aria -> LegendProperty
leAria =
    LAria


{-| Limit height of legend entries.
-}
leClipHeight : Float -> LegendProperty
leClipHeight n =
    LClipHeight (Num n)


{-| Default [ARIA](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA)
properties for providing accessible SVG output associated with a legend. If an empty
list is provided, ARIA tagging will be switched off.
-}
lecoAria : List Aria -> LegendConfig
lecoAria =
    LeAria


{-| Default maximum height of legend entries.
-}
lecoClipHeight : Float -> LegendConfig
lecoClipHeight =
    LeClipHeight


{-| Default horizontal padding between symbol legend entries.
-}
lecoColumnPadding : Float -> LegendConfig
lecoColumnPadding =
    LeColumnPadding


{-| Default number of columns in which to arrange symbol legend entries.
-}
lecoColumns : Float -> LegendConfig
lecoColumns =
    LeColumns


{-| Default legend corner radius.
-}
lecoCornerRadius : Float -> LegendConfig
lecoCornerRadius =
    CornerRadius


{-| Whether or not legends should be disabled by default.
-}
lecoDisable : Bool -> LegendConfig
lecoDisable =
    LeDisable


{-| Default spacing between legend items.
-}
lecoEntryPadding : Float -> LegendConfig
lecoEntryPadding =
    EntryPadding


{-| Default background legend color.
-}
lecoFillColor : String -> LegendConfig
lecoFillColor =
    FillColor


{-| Default vertical alignment for labels in a color ramp legend.
-}
lecoGradientLabelBaseline : VAlign -> LegendConfig
lecoGradientLabelBaseline =
    GradientLabelBaseline


{-| Default maximum allowable length for labels in a color ramp legend.
-}
lecoGradientLabelLimit : Float -> LegendConfig
lecoGradientLabelLimit =
    GradientLabelLimit


{-| Default vertical offset in pixel units for labels in a color ramp legend.
-}
lecoGradientLabelOffset : Float -> LegendConfig
lecoGradientLabelOffset =
    GradientLabelOffset


{-| Default opacity of a color ramp legend.
-}
lecoGradientOpacity : Float -> LegendConfig
lecoGradientOpacity =
    GradientLabelOffset


{-| Default color for strokes in a color ramp legend.
-}
lecoGradientStrokeColor : String -> LegendConfig
lecoGradientStrokeColor =
    GradientStrokeColor


{-| Default width for strokes in a color ramp legend.
-}
lecoGradientStrokeWidth : Float -> LegendConfig
lecoGradientStrokeWidth =
    GradientStrokeWidth


{-| Default height of a color ramp legend.
-}
lecoGradientHeight : Float -> LegendConfig
lecoGradientHeight =
    GradientHeight


{-| Default width of a color ramp legend.
-}
lecoGradientWidth : Float -> LegendConfig
lecoGradientWidth =
    GradientWidth


{-| Default alignment to apply to symbol legends rows and columns.
-}
lecoGridAlign : CompositionAlignment -> LegendConfig
lecoGridAlign =
    LeGridAlign


{-| Default horizontal alignment of legend labels.
-}
lecoLabelAlign : HAlign -> LegendConfig
lecoLabelAlign =
    LeLabelAlign


{-| Default vertical alignment of legend labels.
-}
lecoLabelBaseline : VAlign -> LegendConfig
lecoLabelBaseline =
    LeLabelBaseline


{-| Default color for legend labels.
-}
lecoLabelColor : String -> LegendConfig
lecoLabelColor =
    LeLabelColor


{-| Default font for legend labels.
-}
lecoLabelFont : String -> LegendConfig
lecoLabelFont =
    LeLabelFont


{-| Default font size of legend labels.
-}
lecoLabelFontSize : Float -> LegendConfig
lecoLabelFontSize =
    LeLabelFontSize


{-| Default font style (italic etc.) of legend labels.
-}
lecoLabelFontStyle : String -> LegendConfig
lecoLabelFontStyle =
    LeLabelFontStyle


{-| Default font weight of legend labels.
-}
lecoLabelFontWeight : FontWeight -> LegendConfig
lecoLabelFontWeight =
    LeLabelFontWeight


{-| Default maximum width for legend labels in pixel units.
-}
lecoLabelLimit : Float -> LegendConfig
lecoLabelLimit =
    LeLabelLimit


{-| Default offset for legend labels.
-}
lecoLabelOffset : Float -> LegendConfig
lecoLabelOffset =
    LeLabelOffset


{-| Default offset in pixel units between the legend and the enclosing
group or data rectangle.
-}
lecoOffset : Float -> LegendConfig
lecoOffset =
    Offset


{-| Default legend position relative to the main plot content.
-}
lecoOrient : LegendOrientation -> LegendConfig
lecoOrient =
    Orient


{-| Default spacing in pixel units between a legend and axis.
-}
lecoPadding : Float -> LegendConfig
lecoPadding =
    LePadding


{-| Default vertical spacing in pixel units between legend symbol entries.
-}
lecoRowPadding : Float -> LegendConfig
lecoRowPadding =
    LeRowPadding


{-| Deprecated as time labels are already abbreviated by default in a legend.
-}
lecoShortTimeLabels : Bool -> LegendConfig
lecoShortTimeLabels =
    LeShortTimeLabels


{-| Default legend border color.
-}
lecoStrokeColor : String -> LegendConfig
lecoStrokeColor =
    StrokeColor


{-| Default legend border stroke dash style.
-}
lecoStrokeDash : List Float -> LegendConfig
lecoStrokeDash =
    LeStrokeDash


{-| Default legend border stroke width.
-}
lecoStrokeWidth : Float -> LegendConfig
lecoStrokeWidth =
    LeStrokeWidth


{-| Default legend symbol fill color for when no fill scale color in legend encoding.
-}
lecoSymbolBaseFillColor : String -> LegendConfig
lecoSymbolBaseFillColor =
    SymbolBaseFillColor


{-| Default legend symbol stroke color for when no stroke scale color in legend encoding.
-}
lecoSymbolBaseStrokeColor : String -> LegendConfig
lecoSymbolBaseStrokeColor =
    SymbolBaseStrokeColor


{-| Default legend symbol dash style in legend encoding.
-}
lecoSymbolDash : List Float -> LegendConfig
lecoSymbolDash =
    SymbolDash


{-| Default legend symbol dash offset in legend encoding.
-}
lecoSymbolDashOffset : Float -> LegendConfig
lecoSymbolDashOffset =
    SymbolDashOffset


{-| Default legend symbol fill color.
-}
lecoSymbolFillColor : String -> LegendConfig
lecoSymbolFillColor =
    SymbolFillColor


{-| Default legend symbol fill color.
-}
lecoSymbolLimit : Int -> LegendConfig
lecoSymbolLimit =
    SymbolLimit


{-| Default horizontal pixel offset for legend symbols.
-}
lecoSymbolOffset : Float -> LegendConfig
lecoSymbolOffset =
    SymbolOffset


{-| Default legend symbol type.
-}
lecoSymbolType : Symbol -> LegendConfig
lecoSymbolType =
    SymbolType


{-| Default legend symbol opacity.
-}
lecoSymbolOpacity : Float -> LegendConfig
lecoSymbolOpacity =
    SymbolOpacity


{-| Default legend symbol size.
-}
lecoSymbolSize : Float -> LegendConfig
lecoSymbolSize =
    SymbolSize


{-| Default legend symbol stroke width.
-}
lecoSymbolStrokeWidth : Float -> LegendConfig
lecoSymbolStrokeWidth =
    SymbolStrokeWidth


{-| Default legend symbol outline color.
-}
lecoSymbolStrokeColor : String -> LegendConfig
lecoSymbolStrokeColor =
    SymbolStrokeColor


{-| Default horizontal alignment for legend titles.
-}
lecoTitleAlign : HAlign -> LegendConfig
lecoTitleAlign =
    LeTitleAlign


{-| Default anchoring for legend titles.
-}
lecoTitleAnchor : Anchor -> LegendConfig
lecoTitleAnchor =
    LeTitleAnchor


{-| Default vertical alignment for legend titles.
-}
lecoTitleBaseline : VAlign -> LegendConfig
lecoTitleBaseline =
    LeTitleBaseline


{-| Default color legend titles.
-}
lecoTitleColor : String -> LegendConfig
lecoTitleColor =
    LeTitleColor


{-| Default font for legend titles.
-}
lecoTitleFont : String -> LegendConfig
lecoTitleFont =
    LeTitleFont


{-| Default font size for legend titles.
-}
lecoTitleFontSize : Float -> LegendConfig
lecoTitleFontSize =
    LeTitleFontSize


{-| Default font style (italic etc) for legend titles.
-}
lecoTitleFontStyle : String -> LegendConfig
lecoTitleFontStyle =
    LeTitleFontStyle


{-| Default font weight for legend titles.
-}
lecoTitleFontWeight : FontWeight -> LegendConfig
lecoTitleFontWeight =
    LeTitleFontWeight


{-| Default maximum size in pixel units for legend titles.
-}
lecoTitleLimit : Float -> LegendConfig
lecoTitleLimit =
    LeTitleLimit


{-| Default line height for multi-line legend titles.
-}
lecoTitleLineHeight : Float -> LegendConfig
lecoTitleLineHeight =
    LeTitleLineHeight


{-| Default opacity of a legend's title.
-}
lecoTitleOpacity : Float -> LegendConfig
lecoTitleOpacity =
    LeTitleOpacity


{-| Default spacing in pixel units between title and legend.
-}
lecoTitlePadding : Float -> LegendConfig
lecoTitlePadding =
    LeTitlePadding


{-| Legend corner radius.
-}
leCornerRadius : Float -> LegendProperty
leCornerRadius n =
    LCornerRadius (Num n)


{-| Default opacity of unselected legend items when made interactive via
[seBindLegend](#seBindLegend).
-}
lecoUnselectedOpacity : Float -> LegendConfig
lecoUnselectedOpacity =
    LeUnselectedOpacity


{-| Default direction of a color ramp legend.
-}
lecoGradientDirection : MarkOrientation -> LegendConfig
lecoGradientDirection =
    GradientDirection


{-| Strategy for resolving overlapping legend labels.
-}
lecoLabelOverlap : OverlapStrategy -> LegendConfig
lecoLabelOverlap =
    LeLabelOverlap


{-| Default direction of a symbol legend.
-}
lecoSymbolDirection : MarkOrientation -> LegendConfig
lecoSymbolDirection =
    SymbolDirection


{-| Horizontal padding between symbol legend entries.
-}
leColumnPadding : Float -> LegendProperty
leColumnPadding n =
    LColumnPadding (Num n)


{-| Number of columns in which to arrange symbol legend entries.
-}
leColumns : Float -> LegendProperty
leColumns n =
    LColumns (Num n)


{-| Direction of a legend.
-}
leDirection : MarkOrientation -> LegendProperty
leDirection =
    LDirection


{-| Legend background color.
-}
leFillColor : String -> LegendProperty
leFillColor s =
    LFillColor (Str s)


{-| [Formatting pattern](https://vega.github.io/vega-lite/docs/format.html) for
legend values. To distinguish between formatting as numeric values and data/time values,
additionally use [leFormatAsNum](#leFormatAsNum), [leFormatAsTemporal](#leFormatAsTemporal)
or [leFormatAsCustom](#leFormatAsCustom).
-}
leFormat : String -> LegendProperty
leFormat s =
    LFormat (Str s)


{-| Indicate that legend labels should be formatted with a registered custom formatter
with the given name. See [how to register a Vega-Lite custom formatter](https://vega.github.io/vega-lite/usage/compile.html#format-type).
-}
leFormatAsCustom : String -> LegendProperty
leFormatAsCustom s =
    LFormatAsCustom (Str s)


{-| Indicate that legend labels should be formatted as numbers. To control the precise
numeric format, additionally use [leFormat](#leFormat) providing a
[d3 numeric format string](https://github.com/d3/d3-format#locale_format).
-}
leFormatAsNum : LegendProperty
leFormatAsNum =
    LFormatAsNum


{-| Indicate that legend labels should be formatted as dates/times. To control the
precise temporal format, additionally use [leFormat](#leFormat) providing a
[d3 date/time format string](https://github.com/d3/d3-time-format#locale_format).
-}
leFormatAsTemporal : LegendProperty
leFormatAsTemporal =
    LFormatAsTemporal


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to a
legend property function requiring a numeric value. This can be used for interactive
parameterisation when an expression is bound to an input element. For example,

    ps =
        params
            << param "xPos"
                [ paValue (num 0)
                , paBind (ipRange [ inMax 100 ])
                ]

    enc =
        encoding
            << color
                [ mName "animal"
                , mLegend [ leNumExpr "xPos" leX ]
                ]

-}
leNumExpr : String -> (number -> LegendProperty) -> LegendProperty
leNumExpr ex fn =
    case fn 0 of
        LClipHeight _ ->
            LClipHeight (NumExpr ex)

        LColumnPadding _ ->
            LColumnPadding (NumExpr ex)

        LColumns _ ->
            LColumns (NumExpr ex)

        LCornerRadius _ ->
            LCornerRadius (NumExpr ex)

        LGradientLength _ ->
            LGradientLength (NumExpr ex)

        LGradientOpacity _ ->
            LGradientOpacity (NumExpr ex)

        LGradientThickness _ ->
            LGradientThickness (NumExpr ex)

        LGradientStrokeWidth _ ->
            LGradientStrokeWidth (NumExpr ex)

        LLabelFontSize _ ->
            LLabelFontSize (NumExpr ex)

        LLabelLimit _ ->
            LLabelLimit (NumExpr ex)

        LLabelOffset _ ->
            LLabelOffset (NumExpr ex)

        LOffset _ ->
            LOffset (NumExpr ex)

        LPadding _ ->
            LPadding (NumExpr ex)

        LRowPadding _ ->
            LRowPadding (NumExpr ex)

        LStrokeWidth _ ->
            LStrokeWidth (NumExpr ex)

        LSymbolDashOffset _ ->
            LSymbolDashOffset (NumExpr ex)

        LSymbolLimit _ ->
            LSymbolLimit (NumExpr ex)

        LSymbolOffset _ ->
            LSymbolOffset (NumExpr ex)

        LSymbolOpacity _ ->
            LSymbolOpacity (NumExpr ex)

        LSymbolSize _ ->
            LSymbolSize (NumExpr ex)

        LSymbolStrokeWidth _ ->
            LSymbolStrokeWidth (NumExpr ex)

        LTickCount _ ->
            LTickCount (NumExpr ex)

        LTitleFontSize _ ->
            LTitleFontSize (NumExpr ex)

        LTitleLimit _ ->
            LTitleLimit (NumExpr ex)

        LTitleLineHeight _ ->
            LTitleLineHeight (NumExpr ex)

        LTitleOpacity _ ->
            LTitleOpacity (NumExpr ex)

        LTitlePadding _ ->
            LTitlePadding (NumExpr ex)

        LeX _ ->
            LeX (NumExpr ex)

        LeY _ ->
            LeY (NumExpr ex)

        LZIndex _ ->
            LZIndex (NumExpr ex)

        _ ->
            fn 0


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to
a legend property function requiring a list of numbers (for dash styles). This can
be used to provide an interactive parameterisation of an axis dash property when
an expression is bound to an input element. For example,

    ps =
        params
            << param "dashStyle"
                [ paValue nums []
                , paBind (ipSelect [ inDataOptions [ nums [ 2, 2 ], nums [ 8, 8 ] ] ])
                ]

    enc =
        encoding
            << color
                [ mName "country"
                , mLegned [ leNumsExpr "dashStyle" leSymbolDash ]
                ]

-}
leNumsExpr : String -> (List number -> LegendProperty) -> LegendProperty
leNumsExpr ex fn =
    case fn [] of
        LSymbolDash _ ->
            LSymbolDash (NumsExpr ex)

        _ ->
            fn []


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to
an legend property function requiring a string value. This can be used to provide an
interactive parameterisation of a legend property when an expression is bound to an
input element. For example,

    ps =
        params
            << param "color"
                [ paValue (str "black")
                , paBind (ipColor [])
                ]

    enc =
        encoding
            << color
                [ mName "animal"
                , mLegend [ leStrExpr "color" leTitleColor ]
                ]

-}
leStrExpr : String -> (String -> LegendProperty) -> LegendProperty
leStrExpr ex fn =
    case fn "" of
        LFillColor _ ->
            LFillColor (StrExpr ex)

        LFormat _ ->
            LFormat (StrExpr ex)

        LFormatAsCustom _ ->
            LFormatAsCustom (StrExpr ex)

        LGradientStrokeColor _ ->
            LGradientStrokeColor (StrExpr ex)

        LLabelColor _ ->
            LLabelColor (StrExpr ex)

        LLabelFont _ ->
            LLabelFont (StrExpr ex)

        LLabelFontStyle _ ->
            LLabelFontStyle (StrExpr ex)

        LStrokeColor _ ->
            LStrokeColor (StrExpr ex)

        LSymbolFillColor _ ->
            LSymbolFillColor (StrExpr ex)

        LSymbolStrokeColor _ ->
            LSymbolStrokeColor (StrExpr ex)

        LTitle _ ->
            LTitle (StrExpr ex)

        LTitleColor _ ->
            LTitleColor (StrExpr ex)

        LTitleFont _ ->
            LTitleFont (StrExpr ex)

        LTitleFontStyle _ ->
            LTitleFontStyle (StrExpr ex)

        _ ->
            fn ""


{-| A gradient legend for continuous quantitative data.
-}
leGradient : Legend
leGradient =
    Gradient


{-| Length in pixels of the primary axis of a color ramp legend.
-}
leGradientLength : Float -> LegendProperty
leGradientLength n =
    LGradientLength (Num n)


{-| Opacity of a color ramp legend.
-}
leGradientOpacity : Float -> LegendProperty
leGradientOpacity n =
    LGradientOpacity (Num n)


{-| Color for strokes in a color ramp legend.
-}
leGradientStrokeColor : String -> LegendProperty
leGradientStrokeColor s =
    LGradientStrokeColor (Str s)


{-| Width for strokes in a color ramp legend.
-}
leGradientStrokeWidth : Float -> LegendProperty
leGradientStrokeWidth n =
    LGradientStrokeWidth (Num n)


{-| Thickness in pixels of a color ramp legend.
-}
leGradientThickness : Float -> LegendProperty
leGradientThickness n =
    LGradientThickness (Num n)


{-| Alignment to apply to symbol legends rows and columns.
-}
leGridAlign : CompositionAlignment -> LegendProperty
leGridAlign =
    LGridAlign


{-| Horizontal alignment of legend labels.
-}
leLabelAlign : HAlign -> LegendProperty
leLabelAlign =
    LLabelAlign


{-| Vertical alignment of legend labels.
-}
leLabelBaseline : VAlign -> LegendProperty
leLabelBaseline =
    LLabelBaseline


{-| Color for legend labels.
-}
leLabelColor : String -> LegendProperty
leLabelColor s =
    LLabelColor (Str s)


{-| Font for legend labels.
-}
leLabelFont : String -> LegendProperty
leLabelFont s =
    LLabelFont (Str s)


{-| Font size legend labels.
-}
leLabelFontSize : Float -> LegendProperty
leLabelFontSize n =
    LLabelFontSize (Num n)


{-| Font style (e.g italic) for legend labels.
-}
leLabelFontStyle : String -> LegendProperty
leLabelFontStyle s =
    LLabelFontStyle (Str s)


{-| Font weight for legend labels.
-}
leLabelFontWeight : FontWeight -> LegendProperty
leLabelFontWeight =
    LLabelFontWeight


{-| Maximum width for legend labels in pixel units.
-}
leLabelLimit : Float -> LegendProperty
leLabelLimit n =
    LLabelLimit (Num n)


{-| Offset for legend labels.
-}
leLabelOffset : Float -> LegendProperty
leLabelOffset n =
    LLabelOffset (Num n)


{-| Strategy for resolving overlapping legend labels.
-}
leLabelOverlap : OverlapStrategy -> LegendProperty
leLabelOverlap =
    LLabelOverlap


{-| Offset in pixels of a legend from the encoded marks it describes. If the legend
orientation is one of `loTop`, `loBottom`, `loLeft` or `loRight`, a positive offset
moves the legend outwards away from the encoded marks. If it is one of `loTopLeft`,
`loTopRight`, `loBottomLeft` or `loBottomRight` a positive offset will move it
inwards away from the corner. If `loNone`, the offset has no effect.
-}
leOffset : Float -> LegendProperty
leOffset n =
    LOffset (Num n)


{-| Position of a legend in a scene.
-}
leOrient : LegendOrientation -> LegendProperty
leOrient =
    LOrient


{-| Padding in pixels between a legend and axis.
-}
lePadding : Float -> LegendProperty
lePadding n =
    LPadding (Num n)


{-| Vertical spacing in pixel units between a symbol legend entries.
-}
leRowPadding : Float -> LegendProperty
leRowPadding n =
    LRowPadding (Num n)


{-| Legend border color.
-}
leStrokeColor : String -> LegendProperty
leStrokeColor s =
    LStrokeColor (Str s)


{-| Legend border stroke width.
-}
leStrokeWidth : Float -> LegendProperty
leStrokeWidth n =
    LStrokeWidth (Num n)


{-| A symbol legend for categorical data.
-}
leSymbol : Legend
leSymbol =
    Symbol


{-| Legend symbol dash style in legend encoding.
-}
leSymbolDash : List Float -> LegendProperty
leSymbolDash ns =
    LSymbolDash (Nums ns)


{-| Legend symbol dash offset in legend encoding.
-}
leSymbolDashOffset : Float -> LegendProperty
leSymbolDashOffset n =
    LSymbolDashOffset (Num n)


{-| Legend symbol fill color.
-}
leSymbolFillColor : String -> LegendProperty
leSymbolFillColor s =
    LSymbolFillColor (Str s)


{-| Maximum number of symbols in a legend.
-}
leSymbolLimit : Int -> LegendProperty
leSymbolLimit n =
    LSymbolLimit (Num (toFloat n))


{-| Legend symbol type.
-}
leSymbolType : Symbol -> LegendProperty
leSymbolType =
    LSymbolType


{-| Legend symbol size.
-}
leSymbolSize : Float -> LegendProperty
leSymbolSize n =
    LSymbolSize (Num n)


{-| Symbol offset between legend symbols and legend area.
-}
leSymbolOffset : Float -> LegendProperty
leSymbolOffset n =
    LSymbolOffset (Num n)


{-| Legend symbol opacity.
-}
leSymbolOpacity : Float -> LegendProperty
leSymbolOpacity n =
    LSymbolOpacity (Num n)


{-| Legend symbol stroke width.
-}
leSymbolStrokeWidth : Float -> LegendProperty
leSymbolStrokeWidth n =
    LSymbolStrokeWidth (Num n)


{-| Legend symbol outline color.
-}
leSymbolStrokeColor : String -> LegendProperty
leSymbolStrokeColor s =
    LSymbolStrokeColor (Str s)


{-| Number of tick marks in a quantitative legend.
-}
leTickCount : Float -> LegendProperty
leTickCount n =
    LTickCount (Num n)


{-| Title of a legend. For multi-line titles, insert `\n` at each line break or
use a `"""` multi-line string.
-}
leTitle : String -> LegendProperty
leTitle s =
    LTitle (Str s)


{-| Horizontal alignment for legend titles.
-}
leTitleAlign : HAlign -> LegendProperty
leTitleAlign =
    LTitleAlign


{-| Horizontal alignment for legend titles.
-}
leTitleAnchor : Anchor -> LegendProperty
leTitleAnchor =
    LTitleAnchor


{-| Vertical alignment for legend titles.
-}
leTitleBaseline : VAlign -> LegendProperty
leTitleBaseline =
    LTitleBaseline


{-| Color for legend title.
-}
leTitleColor : String -> LegendProperty
leTitleColor s =
    LTitleColor (Str s)


{-| Font for legend titles.
-}
leTitleFont : String -> LegendProperty
leTitleFont s =
    LTitleFont (Str s)


{-| Font size for legend titles.
-}
leTitleFontSize : Float -> LegendProperty
leTitleFontSize n =
    LTitleFontSize (Num n)


{-| Font style (italic etc.) for legend titles.
-}
leTitleFontStyle : String -> LegendProperty
leTitleFontStyle s =
    LTitleFontStyle (Str s)


{-| Font weight for legend titles.
-}
leTitleFontWeight : FontWeight -> LegendProperty
leTitleFontWeight =
    LTitleFontWeight


{-| Maximum size in pixel units for legend titles.
-}
leTitleLimit : Float -> LegendProperty
leTitleLimit n =
    LTitleLimit (Num n)


{-| Height in pixels for each line of a multi-line legend title.
-}
leTitleLineHeight : Float -> LegendProperty
leTitleLineHeight n =
    LTitleLineHeight (Num n)


{-| Opacity of a legend's title.
-}
leTitleOpacity : Float -> LegendProperty
leTitleOpacity n =
    LTitleOpacity (Num n)


{-| Position of a legend's title relative to the main legend content.
-}
leTitleOrient : LegendOrientation -> LegendProperty
leTitleOrient =
    LTitleOrient


{-| Spacing in pixel units between title and legend.
-}
leTitlePadding : Float -> LegendProperty
leTitlePadding n =
    LTitlePadding (Num n)


{-| Type of legend.
-}
leType : Legend -> LegendProperty
leType =
    LType



{- | Set the opacity of unselected legend items when made interactive via
   [seBindLegend](#seBindLegend).
   -
   -- TODO: Pending resolution of https://github.com/vega/vega-lite/issues/5921
   leUnselectedOpacity : Float -> LegendProperty
   leUnselectedOpacity =
       LUnselectedOpacity
-}


{-| An explicit set of legend values.
-}
leValues : DataValues -> LegendProperty
leValues =
    LValues


{-| x-position of legend group in pixel units for absolute positioning when
[leOrient](#leOrient) is set to `loNone`.
-}
leX : Float -> LegendProperty
leX n =
    LeX (Num n)


{-| y-position of legend group in pixel units for absolute positioning when
[leOrient](#leOrient) is set to `loNone`.
-}
leY : Float -> LegendProperty
leY n =
    LeY (Num n)


{-| Drawing order of a legend relative to other chart elements. To
place a legend in front of others use a positive integer, or 0 to draw behind.
-}
leZIndex : Int -> LegendProperty
leZIndex n =
    LZIndex (Num (toFloat n))


{-| [Line mark](https://vega.github.io/vega-lite/docs/line.html) for symbolising
a sequence of values.
-}
line : List MarkProperty -> ( VLProperty, Spec )
line =
    mark Line


{-| Properties of a line marker that is overlaid on an area mark. Used
when specifying an [maLine](#maLine).
-}
lmMarker : List MarkProperty -> LineMarker
lmMarker =
    LMMarker


{-| Indicate no line marker on an area mark.
-}
lmNone : LineMarker
lmNone =
    LMNone


{-| Position legend outside and below the visualization it describes.
-}
loBottom : LegendOrientation
loBottom =
    Bottom


{-| Position legend within the visualization it describes in the bottom-left corner.
-}
loBottomLeft : LegendOrientation
loBottomLeft =
    BottomLeft


{-| Position legend within the visualization it describes in the bottom-right corner.
-}
loBottomRight : LegendOrientation
loBottomRight =
    BottomRight


{-| Generate a _loess_ (locally-estimated scatterplot smoothing) trendline through
a pair of data fields. The first parameter is the name of the field representing
the dependent variable (commonly mapped to the y-axis), the second is the name of
the field representing the independent variable (commonly mapped to the x-axis).
The third parameter is a list of optional loess parameters to customise the trend
fitting.
-}
loess : String -> String -> List LoessProperty -> List LabelledSpec -> List LabelledSpec
loess depField indField lsProps =
    (::)
        ( "multiSpecs"
        , JE.object
            ([ ( "loess", JE.string depField ), ( "on", JE.string indField ) ]
                ++ List.map loessProperty lsProps
            )
        )


{-| Position legend to the left of the visualization it describes.
-}
loLeft : LegendOrientation
loLeft =
    Left


{-| Do not perform automatic legend positioning (allows legend to be located explicitly
via `x` `y` coordinates).
-}
loNone : LegendOrientation
loNone =
    None


{-| Perform a lookup of named fields between two data sources. This allows you to
find values in one data source based on the values in another. The first parameter
is the field in the primary data source to act as key, the second is the secondary
data source which can be specified with a call to `dataFromUrl` or other data
generating function. The third is the name of the field in the secondary
data source to match values with the primary key. The fourth parameter is the list
of fields to be stored when the keys match.

For linking data with interactive selections, see [lookupSelection](#lookupSelection).

A common use for lookup is to join geographic and attribute data sources. Below
`geodata` is the primary data source containing borough boundaries and `censusData`
the secondary data source containing attribute data. Both have common data field
values identifying a borough (`id` and `borough`) that is used to join the data sources:

    geoData =
        dataFromUrl "city.json" [ topojsonFeature "boroughs" ]

    censusData =
        dataFromUrl "census.csv" []

    trans =
        transform
            << lookup "id"
                (censusData [])
                "borough"
                (luFields [ "carOwnership", "numBedrooms" ])

-}
lookup : String -> Data -> String -> LookupFields -> List LabelledSpec -> List LabelledSpec
lookup key1 ( _, spec ) key2 lufs =
    (::)
        ( "multiSpecs"
        , case lufs of
            LUFields fs ->
                JE.object
                    [ ( "lookup", JE.string key1 )
                    , ( "from"
                      , JE.object
                            [ ( "data", spec )
                            , ( "key", JE.string key2 )
                            , ( "fields", JE.list JE.string fs )
                            ]
                      )
                    ]

            LUFieldsAs fas ->
                JE.object
                    [ ( "lookup", JE.string key1 )
                    , ( "from"
                      , JE.object
                            [ ( "data", spec )
                            , ( "key", JE.string key2 )
                            , ( "fields", JE.list (\( f, _ ) -> JE.string f) fas )
                            ]
                      )
                    , ( "as", JE.list (\( _, a ) -> JE.string a) fas )
                    ]

            LUAs s ->
                JE.object
                    [ ( "lookup", JE.string key1 )
                    , ( "from"
                      , JE.object
                            [ ( "data", spec )
                            , ( "key", JE.string key2 )
                            ]
                      )
                    , ( "as", JE.string s )
                    ]

            LUFieldsWithDefault fs def ->
                JE.object
                    [ ( "lookup", JE.string key1 )
                    , ( "from"
                      , JE.object
                            [ ( "data", spec )
                            , ( "key", JE.string key2 )
                            , ( "fields", JE.list JE.string fs )
                            ]
                      )
                    , ( "default", JE.string def )
                    ]

            LUFieldsAsWithDefault fas def ->
                JE.object
                    [ ( "lookup", JE.string key1 )
                    , ( "from"
                      , JE.object
                            [ ( "data", spec )
                            , ( "key", JE.string key2 )
                            , ( "fields", JE.list (\( f, _ ) -> JE.string f) fas )
                            ]
                      )
                    , ( "as", JE.list (\( _, a ) -> JE.string a) fas )
                    , ( "default", JE.string def )
                    ]

            LUAsWithDefault s def ->
                JE.object
                    [ ( "lookup", JE.string key1 )
                    , ( "from"
                      , JE.object
                            [ ( "data", spec )
                            , ( "key", JE.string key2 )
                            ]
                      )
                    , ( "as", JE.string s )
                    , ( "default", JE.string def )
                    ]
        )


{-| Attach the results of an interactive selection to a primary data source.
The first three parameters are the field in the primary data source to look up;
the name of the interactive selection parameter; and the name of the field in the
selection to link with the primary data field. This is similar to [lookup](#lookup)
except that the data in a selection are used in place of the secondary data source.

      ps =
          params
              << param "mySel"
                  [ paSelect sePoint [ seOn "mouseover", seEncodings [ chX ] ] ]

      trans =
          transform
              << lookupSelection "country" "mySel" "country"

-}
lookupSelection : String -> String -> String -> List LabelledSpec -> List LabelledSpec
lookupSelection key1 selName key2 =
    (::)
        ( "multiSpecs"
        , JE.object
            [ ( "lookup", JE.string key1 )
            , ( "from"
              , JE.object
                    [ ( "param", JE.string selName )
                    , ( "key", JE.string key2 )
                    ]
              )
            ]
        )


{-| Position legend outside and to the right of the visualization it describes.
-}
loRight : LegendOrientation
loRight =
    Right


{-| Position legend outside and above the visualization it describes.
-}
loTop : LegendOrientation
loTop =
    Top


{-| Position legend within the visualization it describes in the top-left corner.
-}
loTopLeft : LegendOrientation
loTopLeft =
    TopLeft


{-| Position legend within the visualization it describes in the top-right corner.
-}
loTopRight : LegendOrientation
loTopRight =
    TopRight


{-| Name the outputs of a loess transform. The first parameter is the name to
give the field containing the smoothed independent variable, the second the name to
give the field containing smoothed dependent variable. If not specified, the
original input independent and dependent field names are used.
-}
lsAs : String -> String -> LoessProperty
lsAs =
    LsAs


{-| The bandwidth scaled between [0,1] to determine the amount of loess smoothing.
Default value is 0.3
-}
lsBandwidth : Float -> LoessProperty
lsBandwidth bw =
    LsBandwidth (min 1 (max 0 bw))


{-| The data fields to group by when generating a loess trendline. If not specified,
a single group containing all data objects will be used.
-}
lsGroupBy : List String -> LoessProperty
lsGroupBy =
    LsGroupBy


{-| Name to give the entire set of fields in a secondary data source when performing
a [lookup](#lookup). To refer to individual fields via this name, use Javascript
dot notation (or if the field contains spaces, use equivalent array index notation
in single quotes such as `o['my field']`).

    data =
        dataFromUrl "data/flights-airport.csv" []

    trans =
        transform
            << lookup "origin"
                (dataFromUrl "data/airports.csv" [])
                "iata"
                (luAs "o")

    enc =
        encoding
            << position Longitude [ pName "o.longitude", pQuant ]
            << position Latitude [ pName "o.latitude", pQuant ]

-}
luAs : String -> LookupFields
luAs =
    LUAs


{-| The same as [luAs](#luAs) except with a second parameter providing the default
value if the lookup fails.
-}
luAsWithDefault : String -> String -> LookupFields
luAsWithDefault =
    LUAsWithDefault


{-| Names of the fields to be returned from a secondary data source when performing
a [lookup](#lookup) transformation.
-}
luFields : List String -> LookupFields
luFields =
    LUFields


{-| Names of the fields and their aliases to be returned from a secondary data
source when performing a [lookup](#lookup) transformation. Each tuple should be
a name of a field to return followed by the new name to give it. Unlike [luAs](#luAs)
this allows separate aliases to be given to each matched field.
-}
luFieldsAs : List ( String, String ) -> LookupFields
luFieldsAs =
    LUFieldsAs


{-| The same as [luFieldsAs](#luFieldsAs) except with a second parameter providing
the default value if the lookup fails.
-}
luFieldsAsWithDefault : List ( String, String ) -> String -> LookupFields
luFieldsAsWithDefault =
    LUFieldsAsWithDefault


{-| The same as [luFields](#luFields) except with a second parameter providing
the default value if the lookup fails.
-}
luFieldsWithDefault : List String -> String -> LookupFields
luFieldsWithDefault =
    LUFieldsWithDefault


{-| Horizontal alignment of a text mark.
-}
maAlign : HAlign -> MarkProperty
maAlign =
    MAlign


{-| Rotation angle of a text mark (degrees from horizontal).
-}
maAngle : Float -> MarkProperty
maAngle n =
    MAngle (Num (positiveAngle n))


{-| [ARIA](https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA) properties
for providing accessible SVG output associated with a mark. If an empty list is
provided, ARIA tagging will be switched off.
-}
maAria : List Aria -> MarkProperty
maAria =
    MAria


{-| Whether or not the aspect ratio of an image mark should be preserved.
-}
maAspect : Bool -> MarkProperty
maAspect b =
    MAspect (Boo b)


{-| Band size of a bar mark.
-}
maBandSize : Float -> MarkProperty
maBandSize n =
    MBandSize (Num n)


{-| Vertical alignment of a text mark.
-}
maBaseline : VAlign -> MarkProperty
maBaseline =
    MBaseline


{-| Offset between bars for a binned field using a bar mark.
-}
maBinSpacing : Float -> MarkProperty
maBinSpacing n =
    MBinSpacing (Num n)


{-| Color blend mode for drawing an item over its current background. Standard
[CSS blend modes](https://developer.mozilla.org/en-US/docs/Web/CSS/mix-blend-mode)
can be specified such as [bmHue](#bmHue), [bmDarken](#bmDarken) etc.
-}
maBlend : BlendMode -> MarkProperty
maBlend =
    MBlend


{-| Border properties for an errorband mark.
-}
maBorders : List MarkProperty -> MarkProperty
maBorders =
    MBorders


{-| Box symbol properties for the boxplot mark. If an empty list is provided, no
box will be shown.
-}
maBox : List MarkProperty -> MarkProperty
maBox =
    MBox


{-| Whether or not a mark should be clipped to the enclosing group's dimensions.
-}
maClip : Bool -> MarkProperty
maClip b =
    MClip (Boo b)


{-| Default color of a mark. Note that `maFill` and `maStroke` have higher
precedence and will override this if specified. Color strings can use any valid
HTML color specification.

    maColor "#eee"

    maColor "#734FD8"

    maColor "crimson"

    maColor "rgb(255,204,210)"

    maColor "hsl(180, 50%, 50%)"

-}
maColor : String -> MarkProperty
maColor s =
    MColor (Str s)


{-| A color gradient to apply to a mark. The first parameter indicates whether the
gradient should be linear or radial. The second is a set of customisation options
for the colors, positioning and rate of change of the gradient. For example,
to set a radial red-blue color gradient for a mark:

    maColorGradient grRadial [ grStops [ ( 0, "red" ), ( 1, "blue" ) ] ]

-}
maColorGradient : ColorGradient -> List GradientProperty -> MarkProperty
maColorGradient =
    MColorGradient


{-| The radius in pixels of selected marks' corners. For rectangular marks, it
shapes all four corners; for [arc](#arc) marks it shapes the vertices of segment.
Default is 0 indicating no rounding.
-}
maCornerRadius : Float -> MarkProperty
maCornerRadius n =
    MCornerRadius (Num n)


{-| The radius in pixels of the bottom-left corner of a rectangle mark. Will override
any value specified in [maCornerRadius](#maCornerRadius).
-}
maCornerRadiusBottomLeft : Float -> MarkProperty
maCornerRadiusBottomLeft n =
    MCornerRadiusBL (Num n)


{-| The radius in pixels of the bottom-right corner of a rectangle mark. Will override
any value specified in [maCornerRadius](#maCornerRadius).
-}
maCornerRadiusBottomRight : Float -> MarkProperty
maCornerRadiusBottomRight n =
    MCornerRadiusBR (Num n)


{-| The radius in pixels of the 'end' corners of a bar mark. For vertical bars
this would be the top corners and for horizontal bars, the right corners.
-}
maCornerRadiusEnd : Float -> MarkProperty
maCornerRadiusEnd n =
    MCornerRadiusEnd (Num n)


{-| The radius in pixels of the top-left corner of a rectangle mark. Will override
any value specified in [maCornerRadius](#maCornerRadius).
-}
maCornerRadiusTopLeft : Float -> MarkProperty
maCornerRadiusTopLeft n =
    MCornerRadiusTL (Num n)


{-| The radius in pixels of the top-right corner of a rectangle mark. Will override
any value specified in [maCornerRadius](#maCornerRadius).
-}
maCornerRadiusTopRight : Float -> MarkProperty
maCornerRadiusTopRight n =
    MCornerRadiusTR (Num n)


{-| Cursor to be associated with a hyperlink mark.
-}
maCursor : Cursor -> MarkProperty
maCursor =
    MCursor


{-| Continuous band size of a bar mark.
-}
maContinuousBandSize : Float -> MarkProperty
maContinuousBandSize n =
    MContinuousBandSize (Num n)


{-| Direction of text, which determines which end is truncated in cases where text
is larger than available space.
-}
maDir : TextDirection -> MarkProperty
maDir =
    MDir


{-| Discrete band size of a bar mark.
-}
maDiscreteBandSize : Float -> MarkProperty
maDiscreteBandSize n =
    MDiscreteBandSize (Num n)


{-| Horizontal offset between a text mark and its anchor.
-}
maDx : Float -> MarkProperty
maDx n =
    MdX (Num n)


{-| Vertical offset between a text mark and its anchor.
-}
maDy : Float -> MarkProperty
maDy n =
    MdY (Num n)


{-| Text to indicate a truncated piece of text (default is the ellipsis ...)
-}
maEllipsis : String -> MarkProperty
maEllipsis s =
    MEllipsis (Str s)


{-| Extent of whiskers used in a boxplot, error bars or error bands.
-}
maExtent : SummaryExtent -> MarkProperty
maExtent =
    MExtent


{-| Default fill color of a mark. Color strings can use any valid HTML color
specification.

    maFill "#eee"

    maFill "#734FD8"

    maFill "crimson"

    maFill "rgb(255,204,210)"

    maFill "rgba(255,50,80,0.3)"

    maFill "hsl(180, 50%, 50%)"

Usually, to avoid filling the interior of a mark, use [maFilled False](#maFilled),
but `maFill ""` can instead be used for cases where an interactive tooltip needs
to 'see through' a stroked mark to one underneath it in a layered specification.

-}
maFill : String -> MarkProperty
maFill s =
    MFill (Str s)


{-| Whether or not a mark's color should be used as the fill color instead of
stroke color.
-}
maFilled : Bool -> MarkProperty
maFilled b =
    MFilled (Boo b)


{-| A color gradient to apply to a mark's interior. The first parameter indicates
whether the gradient should be linear or radial. The second is a set of customisation
options for the colors, positioning and rate of change of the gradient. For example,
to set a radial red-blue color gradient as a fill for a mark:

    maStrokeGradient grRadial [ grStops [ ( 0, "red" ), ( 1, "blue" ) ] ]

Fill gradients have a higher priority than [maColorGradient](#maColorGradient).

-}
maFillGradient : ColorGradient -> List GradientProperty -> MarkProperty
maFillGradient =
    MFillGradient


{-| Fill opacity of a mark.
-}
maFillOpacity : Float -> MarkProperty
maFillOpacity n =
    MFillOpacity (Num n)


{-| Font of a text mark. Can be any font name made accessible via a css file (or
a generic font like `serif`, `monospace` etc.).
-}
maFont : String -> MarkProperty
maFont s =
    MFont (Str s)


{-| Font size in pixels used by a text mark.
-}
maFontSize : Float -> MarkProperty
maFontSize n =
    MFontSize (Num n)


{-| Font style (e.g. `italic`) used by a text mark.
-}
maFontStyle : String -> MarkProperty
maFontStyle s =
    MFontStyle (Str s)


{-| Font weight used by a text mark.
-}
maFontWeight : FontWeight -> MarkProperty
maFontWeight =
    MFontWeight


{-| Compute some aggregate summary statistics for a field to be encoded with a
mark property channel. The type of aggregation is determined by the given operation
parameter.
-}
mAggregate : Operation -> MarkChannel
mAggregate =
    MAggregate


{-| Explicitly set the height of a mark.
-}
maHeight : Float -> MarkProperty
maHeight n =
    MHeight (Num n)


{-| Hyperlink to be associated with a mark making it a clickable hyperlink.
-}
maHRef : String -> MarkProperty
maHRef s =
    MHRef (Str s)


{-| Fix the inner radius (R2) of a radial plot. Can be used for creating 'holes'
in pie chart.
-}
maInnerRadius : Float -> MarkProperty
maInnerRadius n =
    MInnerRadius (Num n)


{-| Interpolation method used by line and area marks. For example, to create a
curved line joining data points:

    line [ maInterpolate miMonotone ]

-}
maInterpolate : MarkInterpolation -> MarkProperty
maInterpolate =
    MInterpolate


{-| Width in pixels indicating maximum permitted space for a text mark. Any mark
that exceeds this limit will be truncated with an ellipsis.
-}
maLimit : Float -> MarkProperty
maLimit n =
    MLimit (Num n)


{-| Line height for multi-line text marks.
-}
maLineHeight : Float -> MarkProperty
maLineHeight n =
    MLineHeight (Num n)


{-| Appearance of a line marker joining the vertices of an area mark.

    area
        [ maLine (lmMarker [ maStroke "black" ])
        , maInterpolate miMonotone
        ]

-}
maLine : LineMarker -> MarkProperty
maLine =
    MLine


{-| Median line properties for the boxplot mark. If an empty list is provided,
no median line will be shown.
-}
maMedian : List MarkProperty -> MarkProperty
maMedian =
    MMedian


{-| Overall opacity of a mark in the range 0 (completely transparent) to 1
(completely opaque).
-}
maOpacity : Float -> MarkProperty
maOpacity n =
    MOpacity (Num n)


{-| Ordering of vertices in a line or area mark. If true (default), order is
determined by measurement type or order channel. If false, the original data order
is used.
-}
maOrder : Bool -> MarkProperty
maOrder b =
    MOrder (Boo b)


{-| Orientation of a non-stacked bar, tick, area or line mark.
-}
maOrient : MarkOrientation -> MarkProperty
maOrient =
    MOrient


{-| Fix the outer radius (R) of a radial plot.
-}
maOuterRadius : Float -> MarkProperty
maOuterRadius n =
    MOuterRadius (Num n)


{-| Outlier symbol properties for the boxplot mark. If an empty list is provided,
no outliers will be shown.
-}
maOutliers : List MarkProperty -> MarkProperty
maOutliers =
    MOutliers


{-| Angular padding applied to sides of an arc (radians)s.
-}
maPadAngle : Float -> MarkProperty
maPadAngle n =
    MPadAngle (Num n)


{-| Appearance of a point marker joining the vertices of a line or area mark.

    line [ maPoint (pmMarker [ maFill "black" ]) ]

-}
maPoint : PointMarker -> MarkProperty
maPoint =
    MPoint


{-| Radial offset of a text mark from an origin specified in Cartesian `X` and `Y`
coordinates.
-}
maRadius : Float -> MarkProperty
maRadius n =
    MRadius (Num n)


{-| Polar coordinate radial offset of a text or arc mark from a polar origin
specified with `Theta` and `R`.
-}
maRadiusOffset : Float -> MarkProperty
maRadiusOffset n =
    MRadiusOffset (Num n)


{-| Polar coordinate inner radial offset of an arc mark from a polar origin
specified with `Theta`, `R` and `R2`.
-}
maRadius2Offset : Float -> MarkProperty
maRadius2Offset n =
    MRadius2Offset (Num n)


{-| Determine whether or not invalid (`null` and `NaN`) values are considered for
encoding as marks. If `true` (default), invalid values are ignored, otherwise
they are treated as if 0.
-}
maRemoveInvalid : Bool -> MarkProperty
maRemoveInvalid b =
    MRemoveInvalid (Boo b)


{-| Rule (main line) properties for the errorbar and boxplot marks. If an empty
list is provided, no rule will be shown.
-}
maRule : List MarkProperty -> MarkProperty
maRule =
    MRule


{-| Shape of a point mark.
-}
maShape : Symbol -> MarkProperty
maShape =
    MShape


{-| Whether or not month and weekday names are abbreviated in a text mark.
-}
maShortTimeLabels : Bool -> MarkProperty
maShortTimeLabels b =
    MShortTimeLabels (Boo b)


{-| Size of a mark in square units. For example, to create a circle of diameter
50 pixels:

    circle [ maSize 2500 ]

-}
maSize : Float -> MarkProperty
maSize n =
    MSize (Num n)


{-| Default stroke color of a mark. Color strings can use any valid HTML color
specification.

    maStroke "#eee"

    maStroke "#734FD8"

    maStroke "crimson"

    maStroke "rgb(255,204,210)"

    maStroke "hsl(180, 50%, 50%)"

An empty string (`""`) indicates that no stroke around a mark be drawn.

-}
maStroke : String -> MarkProperty
maStroke s =
    MStroke (Str s)


{-| Cap style of a mark's stroke.
-}
maStrokeCap : StrokeCap -> MarkProperty
maStrokeCap =
    MStrokeCap


{-| Stroke dash style used by a mark. Determined by an alternating 'on-off'
sequence of line lengths.
-}
maStrokeDash : List Float -> MarkProperty
maStrokeDash xs =
    MStrokeDash (Nums xs)


{-| Expression that evaluates to a stroke dash style (list of numbers).
-}
maStrokeDashExpr : String -> MarkProperty
maStrokeDashExpr s =
    MStrokeDash (NumsExpr s)


{-| Number of pixels before the first line dash is drawn.
-}
maStrokeDashOffset : Float -> MarkProperty
maStrokeDashOffset n =
    MStrokeDashOffset (Num n)


{-| A color gradient to apply to a mark's boundary stroke. The first parameter indicates
whether the gradient should be linear or radial. The second is a set of customisation
options for the colors, positioning and rate of change of the gradient. For example,
to set a radial red-blue color gradient for a mark's stroke:

    maStrokeGradient grRadial [ grStops [ ( 0, "red" ), ( 1, "blue" ) ] ]

Stroke gradients have a higher priority than [maColorGradient](#maColorGradient).

-}
maStrokeGradient : ColorGradient -> List GradientProperty -> MarkProperty
maStrokeGradient =
    MStrokeGradient


{-| Line segment join style of a mark's stroke.
-}
maStrokeJoin : StrokeJoin -> MarkProperty
maStrokeJoin =
    MStrokeJoin


{-| Mitre limit at which to bevel a join between line segments of a mark's stroke.
-}
maStrokeMiterLimit : Float -> MarkProperty
maStrokeMiterLimit n =
    MStrokeMiterLimit (Num n)


{-| Stroke opacity of a mark in the range 0 to 1.
-}
maStrokeOpacity : Float -> MarkProperty
maStrokeOpacity n =
    MStrokeOpacity (Num n)


{-| Stroke width of a mark in pixel units.
-}
maStrokeWidth : Float -> MarkProperty
maStrokeWidth n =
    MStrokeWidth (Num n)


{-| Names of custom styles to apply to a mark. Each should refer to a named style
defined in a separate style configuration with [coMarkStyles](#coMarkStyles).
While this is provided for compatibility with Vega-Lite style specification, for
greater type safety in elm-vegalite, instead create functions that generate
[MarkProperties](#MarkProperty).
-}
maStyle : List String -> MarkProperty
maStyle =
    MStyle


{-| Interpolation tension used when interpolating line and area marks.
-}
maTension : Float -> MarkProperty
maTension n =
    MTension (Num n)


{-| Placeholder text for a text mark for when a text channel is not specified.
Multi-line text can be specified by adding a `\n` at each line break or by using
a `"""` multi-line string.
-}
maText : String -> MarkProperty
maText s =
    MText (Str s)


{-| Polar coordinate angle (clockwise from north in radians) of an arc or text mark.
If a [text mark](#textMark) it represents polar coordinate angle relative to an
origin determined by its x and y properties. For an [arc mark](#arc) it is its
length in radians or, when combined with [maTheta2](#maTheta2), the arc's start
angle.
-}
maTheta : Float -> MarkProperty
maTheta n =
    MTheta (Num n)


{-| Polar coordinate angle (clockwise from north in radians) of the end of an
[arc mark](#arc).
-}
maTheta2 : Float -> MarkProperty
maTheta2 n =
    MTheta2 (Num n)


{-| Clockwise angular offset (in radians) of a radially positioned mark.
-}
maThetaOffset : Float -> MarkProperty
maThetaOffset n =
    MThetaOffset (Num n)


{-| Clockwise angular offset (in radians) of the second theta value of a radially
positioned mark. Useful when the offsets to apply to the start and end angle of
an arc need to be set independently.
-}
maTheta2Offset : Float -> MarkProperty
maTheta2Offset n =
    MTheta2Offset (Num n)


{-| Thickness of a tick mark.
-}
maThickness : Float -> MarkProperty
maThickness n =
    MThickness (Num n)


{-| Tick properties for the errorbar or boxplot mark.
-}
maTicks : List MarkProperty -> MarkProperty
maTicks =
    MTicks


{-| Source of a mark's tooltip content.
-}
maTooltip : TooltipContent -> MarkProperty
maTooltip =
    MTooltip


{-| Explicitly set the width of a mark (e.g. bar width)
-}
maWidth : Float -> MarkProperty
maWidth n =
    MWidth (Num n)


{-| X position of a mark.
-}
maX : Float -> MarkProperty
maX n =
    MX (Num n)


{-| X2 position (secondary x value for lines and areal marks).
-}
maX2 : Float -> MarkProperty
maX2 n =
    MX2 (Num n)


{-| X position offset for a mark.
-}
maXOffset : Float -> MarkProperty
maXOffset n =
    MXOffset (Num n)


{-| X2 position offset for a mark.
-}
maX2Offset : Float -> MarkProperty
maX2Offset n =
    MX2Offset (Num n)


{-| Y position of a mark.
-}
maY : Float -> MarkProperty
maY n =
    MY (Num n)


{-| Y2 position (secondary y value for lines and areal marks).
-}
maY2 : Float -> MarkProperty
maY2 n =
    MY2 (Num n)


{-| Y position offset for a mark.
-}
maYOffset : Float -> MarkProperty
maYOffset n =
    MYOffset (Num n)


{-| Y2 position offset for a mark.
-}
maY2Offset : Float -> MarkProperty
maY2Offset n =
    MY2Offset (Num n)


{-| Apply offset relative to band width for a mark property. Value should be in
the range [0, 1] as a proportion of the band width.
-}
mBand : Float -> MarkChannel
mBand =
    MBand


{-| Discretize numeric values into bins when encoding with a mark property channel.
-}
mBin : List BinProperty -> MarkChannel
mBin =
    MBin


{-| Indicate that data encoding with a mark are already binned.
-}
mBinned : MarkChannel
mBinned =
    MBinned


{-| Boolean value when encoding with a mark property channel.
-}
mBoo : Bool -> MarkChannel
mBoo =
    MBoolean


{-| Make a mark channel encoding conditional on a predicate expression. A predicate
might be the result of evaluating a parameter ([prParam](#prParam)) or an expression
([prTest](#prTest)). The first parameter is the predicate that evaluates to true
or false; the second the encoding if true, the third the encoding if false.
For example, to encode in one of two colours depending on a selection:

    encoding
        << color
            [ mCondition (prParam "mySelection")
                [ mStr "red" ]
                [ mStr "black" ]
            ]

-}
mCondition : Predicate -> List MarkChannel -> List MarkChannel -> MarkChannel
mCondition =
    MCondition


{-| Make a mark channel conditional on a sequence of predicate values. This can
be used when several predicates need to be tested in sequence each with their own
encoding outcome ('if-else'). For example a four-way conditional color encoding
can be specified as:

    encoding
        << color
            [ mConditions
                [ ( prTest (expr "datum.value < 40"), [ mStr "blue" ] )
                , ( prTest (expr "datum.value < 50"), [ mStr "red" ] )
                , ( prTest (expr "datum.value < 60"), [ mStr "yellow" ] )
                ]
                [ mStr "black" ]
            ]

-}
mConditions : List ( Predicate, List MarkChannel ) -> List MarkChannel -> MarkChannel
mConditions =
    MConditions


{-| Deprecated in favour of [mCondition](#mCondition). Instead of

    mDataCondition [ ( expr "datum.x == null", [ mStr "grey" ] ) ] [ mStr "black" ]

use

    mCondition (prTest (expr "datum.x == null")) [ mStr "grey" ] [ mStr "black" ]

-}
mDataCondition : List ( BooleanOp, List MarkChannel ) -> List MarkChannel -> MarkChannel
mDataCondition =
    MDataCondition False


{-| Name of a literal data item used for encoding with a mark property channel.
Unlike [mNum](#mNum), [mStr](#mStr) and [mBoo](#mBoo), datum literals represent
values in data space.
-}
mDatum : DataValue -> MarkChannel
mDatum =
    MDatum


{-| A Mercator map projection. This is the default projection of longitude,latitude
values if no projection is set explicitly. It preserves shape (local angle) and lines
of equal angular bearing remain parallel straight lines. But area is significantly
enlarged towards the poles.
-}
mercator : Projection
mercator =
    Mercator


{-| Indicate a data field encoded as a mark property is a geo feature. Equivalent
to `mMType GeoFeature`.
-}
mGeo : MarkChannel
mGeo =
    MmType GeoFeature


{-| Cubic basis spline interpolation between points anchored at first and last points.
-}
miBasis : MarkInterpolation
miBasis =
    Basis


{-| Closed cubic basis spline interpolation between points forming a polygon.
-}
miBasisClosed : MarkInterpolation
miBasisClosed =
    BasisClosed


{-| Open cubic basis spline interpolation between points, which may not intersect
first and last points.
-}
miBasisOpen : MarkInterpolation
miBasisOpen =
    BasisOpen


{-| Bundle curve interpolation between points.
-}
miBundle : MarkInterpolation
miBundle =
    Bundle


{-| Cubic cardinal spline interpolation between points anchored at first and last
points.
-}
miCardinal : MarkInterpolation
miCardinal =
    Cardinal


{-| Closed cubic cardinal spline interpolation between points forming a polygon.
-}
miCardinalClosed : MarkInterpolation
miCardinalClosed =
    CardinalClosed


{-| Open cubic cardinal spline interpolation between points, which may not intersect
first and last points
-}
miCardinalOpen : MarkInterpolation
miCardinalOpen =
    CardinalOpen


{-| Expression that evaluates to some interpolation method such as "linear", "basis"
or "monotone".
-}
miExpr : String -> MarkInterpolation
miExpr =
    InterpolateExpr


{-| Linear (straight) interpolation between points.
-}
miLinear : MarkInterpolation
miLinear =
    Linear


{-| Linear (straight) interpolation between points that joins the first and last
points in a sequence to form a closed polygon.
-}
miLinearClosed : MarkInterpolation
miLinearClosed =
    LinearClosed


{-| Milliseconds time unit used for discretizing temporal data.
-}
milliseconds : TimeUnit
milliseconds =
    Milliseconds


{-| Cubic spline interpolation that preserves monotonicity between points.
-}
miMonotone : MarkInterpolation
miMonotone =
    Monotone


{-| Minute of the hour time unit used for discretizing temporal data.
-}
minutes : TimeUnit
minutes =
    Minutes


{-| Minutes and seconds time unit used for discretizing temporal data.
-}
minutesSeconds : TimeUnit
minutesSeconds =
    MinutesSeconds


{-| Piecewise (stepped) constant interpolation function centred on each point in
a sequence.
-}
miStepwise : MarkInterpolation
miStepwise =
    Stepwise


{-| Piecewise (stepped) constant interpolation function after each point in a sequence.
-}
miStepAfter : MarkInterpolation
miStepAfter =
    StepAfter


{-| Piecewise (stepped) constant interpolation function before each point in a sequence.
-}
miStepBefore : MarkInterpolation
miStepBefore =
    StepBefore


{-| Properties of a legend that describes a mark's encoding. For no legend, provide
an empty list as the parameter.
-}
mLegend : List LegendProperty -> MarkChannel
mLegend =
    MLegend


{-| Level of measurement when encoding with a mark property channel. See also
[nNominal](#mNominal), [mOrdinal](#mOrdinal), [mQuant](#mQuant), [mTemporal](#mTemporal)
and [mGeo](#mGeo) for shorthand equivalents.
-}
mMType : Measurement -> MarkChannel
mMType =
    MmType


{-| Name of field used for encoding with a mark property channel.
-}
mName : String -> MarkChannel
mName =
    MName


{-| Indicate a data field encoded as a mark property is nominal. Equivalent to
`mMType Nominal`. This is the default data type.
-}
mNominal : MarkChannel
mNominal =
    MmType Nominal


{-| Literal numeric value when encoding with a mark property channel.
-}
mNum : Float -> MarkChannel
mNum =
    MNumber


{-| Indicate horizontal mark orientation.
-}
moHorizontal : MarkOrientation
moHorizontal =
    MOHorizontal


{-| Month of the year used for discretizing temporal data. This will ignore year so
useful for looking at monthly seasonal patterns through the year.
-}
month : TimeUnit
month =
    Month


{-| Day of the year for discretizing temporal data. This will ignore year so useful
for looking at seasonal patterns through the year.
-}
monthDate : TimeUnit
monthDate =
    MonthDate


{-| Hour of the year used for discretizing temporal data. This will ignore year so
useful for looking at seasonal patterns with hourly resolution.
-}
monthDateHours : TimeUnit
monthDateHours =
    MonthDateHours


{-| Minute of the year used for discretizing temporal data. This will ignore year
so useful for looking at seasonal patterns with one-minute resolution.
-}
monthDateHoursMinutes : TimeUnit
monthDateHoursMinutes =
    MonthDateHoursMinutes


{-| Second of the year used for discretizing temporal data. This will ignore year
so useful for looking at seasonal patterns with one-second resolution.
-}
monthDateHoursMinutesSeconds : TimeUnit
monthDateHoursMinutesSeconds =
    MonthDateHoursMinutesSeconds


{-| Indicate a data field encoded as a mark property is ordinal. Equivalent to
`mMType Ordinal`.
-}
mOrdinal : MarkChannel
mOrdinal =
    MmType Ordinal


{-| Indicate vertical mark orientation.
-}
moVertical : MarkOrientation
moVertical =
    MOVertical


{-| SVG path string used when encoding with a mark property channel. Useful
for providing custom shapes.
-}
mPath : String -> MarkChannel
mPath =
    MPath


{-| Indicate a data field encoded as a mark property is quantitative. Equivalent to
`mMType Quantitative`.
-}
mQuant : MarkChannel
mQuant =
    MmType Quantitative


{-| Reference in a mark channel to a field name generated by [repeatFlow](#repeatFlow)
or [repeat](#repeat). The parameter identifies whether reference is being made to
fields that are to be encoded in layers, or in columns / rows with a flow layout.
-}
mRepeat : Arrangement -> MarkChannel
mRepeat =
    MRepeat


{-| Reference in a mark channel to a datum value generated by [repeatFlow](#repeatFlow)
or [repeat](#repeat). The parameter identifies whether reference is being made to
a datum that is to be encoded in layers, or in columns / rows with a flow layout.
-}
mRepeatDatum : Arrangement -> MarkChannel
mRepeatDatum =
    MRepeatDatum


{-| Scaling applied to a field when encoding with a mark property channel.
The scale will transform a field's value into a color, shape, size etc.
-}
mScale : List ScaleProperty -> MarkChannel
mScale =
    MScale


{-| Deprecated in favour of [mCondition](#mCondition). Instead of

    mSelectionCondition (selectionName "mySelection") [ mStr "red" ] [ mStr "black" ]

use

    mCondition (prParam "mySelection") [ mStr "red" ] [ mStr "black" ]

-}
mSelectionCondition : BooleanOp -> List MarkChannel -> List MarkChannel -> MarkChannel
mSelectionCondition bo tMcs =
    MDataCondition True [ ( bo, tMcs ) ]


{-| Sort order when encoding sortable mark properties such as colour.
-}
mSort : List SortProperty -> MarkChannel
mSort =
    MSort


{-| Literal string value when encoding with a mark property channel.
-}
mStr : String -> MarkChannel
mStr =
    MString


{-| A symbol literal when encoding with a mark property channel. Can be useful when
making a symbol dependent on some data or selection condition.
-}
mSymbol : Symbol -> MarkChannel
mSymbol sym =
    MString (symbolLabel sym)


{-| Indicate a data field encoded as a mark property is temporal. Equivalent to
`mMType Temporal`.
-}
mTemporal : MarkChannel
mTemporal =
    MmType Temporal


{-| Time unit aggregation of field values when encoding with a mark property channel.
-}
mTimeUnit : TimeUnit -> MarkChannel
mTimeUnit =
    MTimeUnit


{-| Title of a field when encoding with a mark property channel. For multi-line titles,
insert `\n` at each line break or use a `"""` multi-line string.
-}
mTitle : String -> MarkChannel
mTitle =
    MTitle


{-| Name to be associated with a visualization.
-}
name : String -> ( VLProperty, Spec )
name s =
    ( VLName, JE.string s )


{-| A natural earth map projection.
-}
naturalEarth1 : Projection
naturalEarth1 =
    NaturalEarth1


{-| Nice time intervals that try to align with whole or rounded days.
-}
niDay : ScaleNice
niDay =
    NDay


{-| Specify nice scaling with an expression that evaluates to a valid nice property
(e.g. a number or time interval)
-}
niExpr : String -> ScaleNice
niExpr =
    NExpr


{-| Disable nice scaling.
-}
niFalse : ScaleNice
niFalse =
    NFalse


{-| Nice time intervals that try to align with whole or rounded hours.
-}
niHour : ScaleNice
niHour =
    NHour


{-| 'Nice' temporal interval values when scaling.
-}
niInterval : TimeUnit -> Int -> ScaleNice
niInterval =
    NInterval


{-| Nice time intervals that try to align with rounded milliseconds.
-}
niMillisecond : ScaleNice
niMillisecond =
    NMillisecond


{-| Nice time intervals that try to align with whole or rounded minutes.
-}
niMinute : ScaleNice
niMinute =
    NMinute


{-| Nice time intervals that try to align with whole or rounded months.
-}
niMonth : ScaleNice
niMonth =
    NMonth


{-| Nice time intervals that try to align with whole or rounded seconds.
-}
niSecond : ScaleNice
niSecond =
    NSecond


{-| Desired number of tick marks in a 'nice' scaling.
-}
niTickCount : Int -> ScaleNice
niTickCount =
    NTickCount


{-| Enable nice scaling.
-}
niTrue : ScaleNice
niTrue =
    NTrue


{-| Nice time intervals that try to align with whole or rounded weeks.
-}
niWeek : ScaleNice
niWeek =
    NWeek


{-| Nice time intervals that try to align with whole or rounded years.
-}
niYear : ScaleNice
niYear =
    NYear


{-| Indicate no clipping to be applied.
-}
noClip : ClipRect
noClip =
    NoClip


{-| Ignore the data of a specification's parent when used in a composed spec.
-}
noData : Data
noData =
    ( VLData, JE.null )


{-| Apply a negation Boolean operation as part of a logical composition. Boolean
operations can be nested to any level.

    not (and (expr "datum.IMDB_Rating === null") (expr "datum.Rotten_Tomatoes_Rating === null"))

-}
not : BooleanOp -> BooleanOp
not =
    Not


{-| An unspecified data value. Can be useful when explicitly recoding a value as
undefined.

    data =
        dataFromRows []
            << dataRow [ ( "x", num 1 ), ( "y", num 10 ) ]
            << dataRow [ ( "x", num 2 ), ( "y", nullValue ) ]
            << dataRow [ ( "x", num 3 ), ( "y", num 30 ) ]

For more complex data sources that contain lists of defined and unspecified values,
consider using [dataFromJson](#dataFromJson) instead.

-}
nullValue : DataValue
nullValue =
    NullValue


{-| A numeric data value.
-}
num : Float -> DataValue
num =
    Number


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to
a mark property function requiring a boolean value. This can be used to provide an
interactive parameterisation of a mark property by providing an expression bound
to an input element. For example,

    ps =
        params
            << param "asp"
                [ paValue (boo True)
                , paBind (ipCheckbox [ inName "maintain aspect ratio" ])
                ]

    mk =
        image [ maBooExpr "asp" maAspect ]

-}
maBooExpr : String -> (Bool -> MarkProperty) -> MarkProperty
maBooExpr ex fn =
    case fn True of
        MClip _ ->
            MClip (BooExpr ex)

        MFilled _ ->
            MFilled (BooExpr ex)

        MOrder _ ->
            MOrder (BooExpr ex)

        MRemoveInvalid _ ->
            MRemoveInvalid (BooExpr ex)

        MShortTimeLabels _ ->
            MShortTimeLabels (BooExpr ex)

        MAspect _ ->
            MAspect (BooExpr ex)

        _ ->
            fn False


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to a
mark property function requiring a numeric value. This can be used for interactive
parameterisation when an expression is bound to an input element. For example,

    ps =
        params
            << param "r"
                [ paValue (num 0)
                , paBind (ipRange [ inMax 100 ])
                ]

    mk =
        arc [ maNumExpr "r" maInnerRadius ]

-}
maNumExpr : String -> (number -> MarkProperty) -> MarkProperty
maNumExpr ex fn =
    case fn 0 of
        MWidth _ ->
            MWidth (NumExpr ex)

        MHeight _ ->
            MHeight (NumExpr ex)

        MX _ ->
            MX (NumExpr ex)

        MY _ ->
            MY (NumExpr ex)

        MX2 _ ->
            MX2 (NumExpr ex)

        MY2 _ ->
            MY2 (NumExpr ex)

        MXOffset _ ->
            MXOffset (NumExpr ex)

        MYOffset _ ->
            MYOffset (NumExpr ex)

        MX2Offset _ ->
            MX2Offset (NumExpr ex)

        MY2Offset _ ->
            MY2Offset (NumExpr ex)

        MOpacity _ ->
            MOpacity (NumExpr ex)

        MFillOpacity _ ->
            MFillOpacity (NumExpr ex)

        MStrokeOpacity _ ->
            MStrokeOpacity (NumExpr ex)

        MStrokeMiterLimit _ ->
            MStrokeMiterLimit (NumExpr ex)

        MStrokeWidth _ ->
            MStrokeWidth (NumExpr ex)

        MStrokeDashOffset _ ->
            MStrokeDashOffset (NumExpr ex)

        MRadius _ ->
            MRadius (NumExpr ex)

        MInnerRadius _ ->
            MInnerRadius (NumExpr ex)

        MOuterRadius _ ->
            MOuterRadius (NumExpr ex)

        MTheta _ ->
            MTheta (NumExpr ex)

        MTheta2 _ ->
            MTheta2 (NumExpr ex)

        MThetaOffset _ ->
            MThetaOffset (NumExpr ex)

        MTheta2Offset _ ->
            MTheta2Offset (NumExpr ex)

        MRadiusOffset _ ->
            MRadiusOffset (NumExpr ex)

        MRadius2Offset _ ->
            MRadius2Offset (NumExpr ex)

        MCornerRadius _ ->
            MCornerRadius (NumExpr ex)

        MPadAngle _ ->
            MPadAngle (NumExpr ex)

        MTension _ ->
            MTension (NumExpr ex)

        MCornerRadiusEnd _ ->
            MCornerRadiusEnd (NumExpr ex)

        MCornerRadiusTL _ ->
            MCornerRadiusTL (NumExpr ex)

        MCornerRadiusTR _ ->
            MCornerRadiusTR (NumExpr ex)

        MCornerRadiusBL _ ->
            MCornerRadiusBL (NumExpr ex)

        MCornerRadiusBR _ ->
            MCornerRadiusBR (NumExpr ex)

        MSize _ ->
            MSize (NumExpr ex)

        MAngle _ ->
            MAngle (NumExpr ex)

        MdX _ ->
            MdX (NumExpr ex)

        MdY _ ->
            MdY (NumExpr ex)

        MFontSize _ ->
            MFontSize (NumExpr ex)

        MLimit _ ->
            MLimit (NumExpr ex)

        MLineHeight _ ->
            MLineHeight (NumExpr ex)

        _ ->
            fn 0


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to
a mark property function requiring a string value. This can be used to provide an
interactive parameterisation of a mark property by providing an expression bound
to an input element. For example,

    ps =
        params
            << param "clr"
                [ paValue (str "red")
                , paBind (ipColor [])
                ]

    mk =
        circle [ maStrExpr "clr" maFill ]

-}
maStrExpr : String -> (String -> MarkProperty) -> MarkProperty
maStrExpr ex fn =
    case fn "" of
        MFont _ ->
            MFont (StrExpr ex)

        MFontStyle _ ->
            MFontStyle (StrExpr ex)

        MColor _ ->
            MColor (StrExpr ex)

        MFill _ ->
            MFill (StrExpr ex)

        MStroke _ ->
            MStroke (StrExpr ex)

        MHRef _ ->
            MHRef (StrExpr ex)

        MEllipsis _ ->
            MEllipsis (StrExpr ex)

        MText _ ->
            MText (StrExpr ex)

        _ ->
            fn ""


{-| Minimum-maximum number range to be used in data filtering.
-}
numRange : Float -> Float -> FilterRange
numRange =
    NumberRange


{-| List of numeric data values. Used when declaring inline data with
[dataColumn](#dataColumn), filtering ([fiOneOf](#fiOneOf)), imputation
([imKeyVals](#imKeyVals)) and customised sorting ([soCustom](#soCustom)).
-}
nums : List Float -> DataValues
nums =
    Numbers


{-| Compute some aggregate summary statistics for a field to be encoded with an
order channel. The type of aggregation is determined by the given operation
parameter.
-}
oAggregate : Operation -> OrderChannel
oAggregate =
    OAggregate


{-| Discretize numeric values into bins when encoding with an order channel.
-}
oBin : List BinProperty -> OrderChannel
oBin =
    OBin


{-| Make an order channel encoding conditional on a predicate expression. A predicate
might be the result of evaluating a parameter ([prParam](#prParam)) or an expression
([prTest](#prTest)). The first parameter is the predicate that evaluates to true
or false; the second the encoding if true, the third the encoding if false.

For example, to bring marks of an interactively selected colour to the front:

    ps =
        params
            << param "sel" [ paSelect sePoint [ seEncodings [ chColor ] ] ]

    enc =
        encoding
            << order [ oCondition (prParam "sel") [ oNum 1 ] [ oNum 0 ] ]

-}
oCondition : Predicate -> List OrderChannel -> List OrderChannel -> OrderChannel
oCondition =
    OCondition


{-| Make an order channel conditional on a sequence of predicate values. This can
be used when several predicates need to be tested in sequence each with their
own encoding outcomes ('if-else'). For example to control mark z-order for three
category values:

    order
        [ oConditions
            [ ( prTest (expr "datum.Origin == 'Europe'"), [ oNum 3 ] )
            , ( prTest (expr "datum.Origin == 'Japan'"), [ oNum 2 ] )
            ]
            [ oNum 1 ]
        ]

-}
oConditions : List ( Predicate, List OrderChannel ) -> List OrderChannel -> OrderChannel
oConditions =
    OConditions


{-| Deprecated in favour of [oCondition](#oCondition). Instead of

    oDataCondition [ ( expr "datum.Origin == 'Europe'", [ oNum 1 ] ) ] [ oNum 0 ]

use

    oCondition (prTest (expr "datum.Origin == 'Europe'")) [ oNum 1 ] [ oNum 0 ]

-}
oDataCondition : List ( BooleanOp, List OrderChannel ) -> List OrderChannel -> OrderChannel
oDataCondition =
    ODataCondition False


{-| Indicate a data field encoded with an order channel is a geo feature. Equivalent
to `oMType GeoFeature`.
-}
oGeo : OrderChannel
oGeo =
    OmType GeoFeature


{-| Level of measurement when encoding with an order channel. See also
[oNominal](#oNominal), oOrdinal](#oOrdinal), [oQuant](#oQuant),
[oTemporal](#oTemporal) and [oGeo](#oGeo) for shorthand equivalents.
-}
oMType : Measurement -> OrderChannel
oMType =
    OmType


{-| Name of field used for encoding with an order channel.
-}
oName : String -> OrderChannel
oName =
    OName


{-| Indicate a data field encoded with an order channel is nominal. Equivalent to
`oMType Nominal`.
-}
oNominal : OrderChannel
oNominal =
    OmType Nominal


{-| Specify a literal numeric value for an order channel. Useful for setting a
conditional z-order with interaction to bring selected feature to 'front'.
-}
oNum : Float -> OrderChannel
oNum =
    ONumber


{-| Indicate a data field encoded with an order channel is ordinal. Equivalent to
`oMType Ordinal`.
-}
oOrdinal : OrderChannel
oOrdinal =
    OmType Ordinal


{-| Encode an opacity channel.
-}
opacity : List MarkChannel -> List LabelledSpec -> List LabelledSpec
opacity markProps =
    (::) ( "opacity", List.concatMap markChannelProperties markProps |> JE.object )


{-| An input data object containing the minimum field value to be used in an
aggregation operation. If supplied as part of an encoding aggregation, the parameter
should be `Just` the name of the field to maximise. For example, the following would
find the production budget for the maximum US grossing film in each genre:

    encoding
        << position X
            [ pName "Production_Budget"
            , pQuant
            , pAggregate (opArgMax (Just "US_Gross"))
            ]
        << position Y [ pName "Major_Genre", pNominal ]

If supplied as part of a transform, the parameter should be `Nothing` as the field
is specified in the [aggregate](#aggregate) parameter.

    trans =
        transform
            << aggregate
                [ opAs (opArgMax Nothing) "US_Gross" "amUSGross" ]
                [ "Major_Genre" ]

-}
opArgMax : Maybe String -> Operation
opArgMax =
    ArgMax


{-| An input data object containing the minimum field value to be used in an
aggregation operation.
-}
opArgMin : Maybe String -> Operation
opArgMin =
    ArgMin


{-| Aggregation operation. The first parameter is the operation to use; the second
the name of the field in which to apply it and the third the name to be given to
this transformation.

    trans =
        transform
            << aggregate
                [ opAs opMin "people" "lowerBound"
                , opAs opMax "people" "upperBound"
                ]
                [ "age" ]

If the operation is `Count`, it does not apply to any specific field, so the second
parameter can be an empty string.

-}
opAs : Operation -> String -> String -> Spec
opAs op field label =
    JE.object
        [ ( "op", operationSpec op )
        , ( "field", JE.string field )
        , ( "as", JE.string label )
        ]


{-| Lower 95% confidence interval to be used in an aggregation operation.
-}
opCI0 : Operation
opCI0 =
    CI0


{-| Upper 95% confidence interval to be used in an aggregation operation.
-}
opCI1 : Operation
opCI1 =
    CI1


{-| Total count of data objects to be used in an aggregation operation.
-}
opCount : Operation
opCount =
    Count


{-| Count of distinct data objects to be used in an aggregation operation.
-}
opDistinct : Operation
opDistinct =
    Distinct


{-| Maximum field value to be used in an aggregation operation.
-}
opMax : Operation
opMax =
    Max


{-| Mean value to be used in an aggregation operation.
-}
opMean : Operation
opMean =
    Mean


{-| Median field value to be used in an aggregation operation.
-}
opMedian : Operation
opMedian =
    Median


{-| Minimum field value to be used in an aggregation operation.
-}
opMin : Operation
opMin =
    Min


{-| Count of null or undefined field value to be used in an aggregation operation.
-}
opMissing : Operation
opMissing =
    Missing


{-| Product of field values to be used in an aggregation operation.
-}
opProduct : Operation
opProduct =
    Product


{-| Lower quartile boundary of field values to be used in an aggregation operation.
-}
opQ1 : Operation
opQ1 =
    Q1


{-| Upper quartile boundary of field values to be used in an aggregation operation.
-}
opQ3 : Operation
opQ3 =
    Q3


{-| Standard error of field values to be used in an aggregation operation.
-}
opStderr : Operation
opStderr =
    Stderr


{-| Sample standard deviation of field values to be used in an aggregation operation.
-}
opStdev : Operation
opStdev =
    Stdev


{-| Population standard deviation of field values to be used in an aggregation operation.
-}
opStdevP : Operation
opStdevP =
    StdevP


{-| Sum of field values to be used in an aggregation operation.
-}
opSum : Operation
opSum =
    Sum


{-| Count of values that are not `null`, `undefined` or `NaN` to be used in an
aggregation operation.
-}
opValid : Operation
opValid =
    Valid


{-| Sample variance of field value to be used in an aggregation operation.
-}
opVariance : Operation
opVariance =
    Variance


{-| Population variance of field value to be used in an aggregation operation.
-}
opVarianceP : Operation
opVarianceP =
    VarianceP


{-| Apply an 'or' Boolean operation as part of a logical composition.
-}
or : BooleanOp -> BooleanOp -> BooleanOp
or op1 op2 =
    Or op1 op2


{-| Indicate a data field encoded with an order channel is quantitative. Equivalent
to `oMType Quantitative`.
-}
oQuant : OrderChannel
oQuant =
    OmType Quantitative


{-| Encode an order channel. The first parameter is a list of order encoding
options such as the data to encode, sort direction etc.

    enc =
        encoding
            << order [ oName "yield", oOrdinal, oSort [ soDescending ] ]

-}
order : List OrderChannel -> List LabelledSpec -> List LabelledSpec
order oDefs =
    (::) ( "order", List.concatMap orderChannelProperties oDefs |> JE.object )


{-| Reference in a order channel to a field name generated by [repeatFlow](#repeatFlow)
or [repeat](#repeat). The parameter identifies whether reference is being made to
fields that are to be arranged in columns, in rows or a with a flow layout.
-}
oRepeat : Arrangement -> OrderChannel
oRepeat =
    ORepeat


{-| An orthographic map projection.
-}
orthographic : Projection
orthographic =
    Orthographic


{-| Specify an overlap strategy with an expression that should evaluate to one
of True, False, "parity" or "greedy". If using an input element such as [ipSelect](#ipSelect)
to allow all options, the mixed option types should be defined with [inDatumOptions](#inDatumOptions),
for example:

    ipSelect
        [ inName "Label overlap"
        , inDatumOptions [ boo False, str "parity", str "greedy" ]
        ]

-}
osExpr : String -> OverlapStrategy
osExpr =
    OverlapExpr


{-| Greedy overlap strategy to be applied when there is not space to show all items on an axis.
-}
osGreedy : OverlapStrategy
osGreedy =
    OGreedy


{-| No overlap strategy to be applied when there is not space to show all items on an axis.
-}
osNone : OverlapStrategy
osNone =
    ONone


{-| Give all items equal weight in overlap strategy to be applied when there is
not space to show them all on an axis.
-}
osParity : OverlapStrategy
osParity =
    OParity


{-| Deprecated in favour of [oCondition](#oCondition). Instead of

    oSelectionCondition (selectionName "mySelection") [ mNum 0 ] [ mNum 1 ]

use

    oCondition (prParam "mySelection") [ oNum 0 ] [ oNum 1 ]

-}
oSelectionCondition : BooleanOp -> List OrderChannel -> List OrderChannel -> OrderChannel
oSelectionCondition bo tOcs =
    ODataCondition True [ ( bo, tOcs ) ]


{-| Sort order to be used by an order channel.
-}
oSort : List SortProperty -> OrderChannel
oSort =
    OSort


{-| Indicate a data field encoded with an order channel is temporal. Equivalent to
`oMType Temporal`.
-}
oTemporal : OrderChannel
oTemporal =
    OmType Temporal


{-| Time unit aggregation of field values when encoding with an order channel.
-}
oTimeUnit : TimeUnit -> OrderChannel
oTimeUnit =
    OTimeUnit


{-| The dynamic binding associated with a parameter. Can be used to create a parameter
value that varies as an interactive input control (e.g. slider) is updated.

    param "mySlider"
        [ paSelect sePoint []
        , paBind (ipRange [ inMin 1, inMax 10 ])
        ]

-}
paBind : PBinding -> ParamProperty
paBind =
    PBind


{-| One or more named dynamic bindings associated with a parameter.
Unlike [paBind](#paBind), this allows multiple input elements to be bound to the
same field. For example, to bind a selection to the 'And' selection of two sliders:

    param "CylYr"
        [ paSelect sePoint [ seFields [ "Cylinders", "Year" ] ]
        , paBindings
            [ ( "Cylinders", ipRange [ inMin 3, inMax 8, inStep 1 ] )
            , ( "Year", ipRange [ inMin 1969, inMax 1981, inStep 1 ] )
            ]
        ]

-}
paBindings : List ( String, PBinding ) -> ParamProperty
paBindings =
    PBindings


{-| Bind a named parameter selection to a legend for interactive selection of
field values from a legend. Can be bound to a field or channel. For example the
following will bind a color legend to a point selection allowing filtering or
highlighting by the selected value that has been encoded with color.

    ps =
        params
            << param "legSel"
                [ paSelect sePoint [ seEncodings [ chColor ] ]
                , paBindLegend ""
                ]

To customise which events should trigger legend interaction, provide a
[Vega event stream string](https://vega.github.io/vega/docs/event-streams/). If an
empty string is provided, the default single-click interaction is used.

For example, to allow legend selection with a double click:

    paBindLegend "dblClick"

or with shift-click:

    paBindLegend "click[event.shiftKey]"

-}
paBindLegend : String -> ParamProperty
paBindLegend =
    PBindLegend


{-| Bind a named parameter selection to the scales of a view to allow interactive
zooming and panning. For example,

    ps =
        params
            << param "zoomer" [ paSelect seInterval [], paBindScales ]

-}
paBindScales : ParamProperty
paBindScales =
    PBindScales


{-| Padding around the visualization in pixel units. The way padding is interpreted
will depend on the `autosize` properties.
-}
padding : Padding -> ( VLProperty, Spec )
padding pad =
    ( VLPadding, paddingSpec pad )


{-| Padding around a visualization in pixel units. The four parameters
refer to _left_, _top_, _right_, and _bottom_ edges respectively.
-}
paEdges : Float -> Float -> Float -> Float -> Padding
paEdges =
    PEdges


{-| Expressions that each evaluate to a numeric values indicating padding around
a visualization in pixel units. The four parameters refer to _left_, _top_, _right_
and _bottom_ edges respectively. Can be useful when padding is to be determined
interactively through input elements.
-}
paEdgesExpr : String -> String -> String -> String -> Padding
paEdgesExpr =
    PEdgesExpr


{-| Initial value of a parameter specified as a
[Vega expression](https://vega.github.io/vega/docs/expressions).
-}
paExpr : String -> ParamProperty
paExpr =
    PExpr


{-| Compute some aggregate summary statistics for a field to be encoded with a
position channel. The type of aggregation is determined by the given operation
parameter.

    enc =
        encoding
            << position X [ pName "role", pOrdinal ]
            << position Y [ pName "salary", pQuant, pAggregate opMean ]

-}
pAggregate : Operation -> PositionChannel
pAggregate =
    PAggregate


{-| Add a named parameter to a list of parameters. A parameter should have a name
and a list of parameter details. For example,

    param "mySelection" [ paSelect seInterval [] ]

-}
param : String -> List ParamProperty -> List LabelledSpec -> List LabelledSpec
param nme pps =
    (::) ( nme, List.map paramProperty pps |> JE.object )


{-| Specify top-level parameters to be used within a specification. While literals
may be specified as parameters, these are better handled directly in Elm. More
useful expression parameters are those that use the
[vega-lite built-in parameters](https://vega.github.io/vega-lite/docs/parameter.html#built-in-variable-parameters)
`width`, `height`, `padding`, `autosize`, `background` and `cursor`. For example
to keep text size a fixed proportion of the plot height:

    ps =
        params
            << param "textSize" [ paExpr "height/20" ]

Also useful is the ability to bind parameters to input elements such as range
sliders that may be updated at runtime. For example the value of the `radius` parameter
is determined by the slider position and then used as a mark property to alter
circle size dynamically:

    let
        ps =
            params
                << param "radius"
                    [ paValue (num 0)
                    , paBind (ipRange [ inMax 100 ])
                    ]

        enc =
            encoding
                << position Theta [ pName "value", pQuant ]
                << color [ mName "category" ]
    in
    toVegaLite
        [ ps []
        , data []
        , enc []
        , arc [ maNumExpr "radius" maInnerRadius ]
        ]

-}
params : List LabelledSpec -> ( VLProperty, Spec )
params prms =
    let
        toLabelledSpecs obj =
            JD.decodeValue (JD.keyValuePairs JD.value) obj
                |> Result.withDefault []

        extract ( nme, obj ) =
            JE.object (( "name", JE.string nme ) :: toLabelledSpecs obj)
    in
    ( VLParams, JE.list extract prms )


{-| Parsing rules when processing some data text, specified as a list of tuples
in the form (_fieldName_, _dataType_). Useful when automatic type inference needs
to be overridden, for example when converting integers representing years into dates
and strings into numbers:

    data =
        dataFromUrl "myDataFile.csv"
            [ parse [ ( "year", foDate "%Y" ), ( "y", foNum ) ] ]

-}
parse : List ( String, DataType ) -> Format
parse =
    Parse


{-| Specify a selection parameter to be used for interaction. For example, to create
an interval selection:

    param "mySelection" [ paSelect seInterval [] ]

To project a point selection across the field encoded with colour:

    param "mySelection" [ paSelect sePoint [ seEncodings [ chColor ] ] ]

-}
paSelect : Selection -> List SelectionProperty -> ParamProperty
paSelect =
    PSelect


{-| Indicate uniform padding around a visualization in pixel units.
-}
paSize : Float -> Padding
paSize =
    PSize


{-| Expression that evaluates to a numeric value indicating padding around a visualization
in pixel units. Can be useful when padding is to be determined interactively through
an input element.
-}
paSizeExpr : String -> Padding
paSizeExpr =
    PSizeExpr


{-| Initial value of a parameter.
-}
paValue : DataValue -> ParamProperty
paValue =
    PValue


{-| Initial set of values of a parameter. Useful for passing to functions that require a
list of values.
-}
paValues : DataValues -> ParamProperty
paValues =
    PValues


{-| Axis properties used when encoding with a position channel. For no axis,
provide an empty list.
-}
pAxis : List AxisProperty -> PositionChannel
pAxis =
    PAxis


{-| Deprecated in favour of [pBandPosition](#pBandPosition).
-}
pBand : Float -> PositionChannel
pBand =
    PBandPosition


{-| Specify mark position or size relative to band size. For non-rect marks,
the relative position on a band of a stacked, binned, time unit or band scale is
used. A value of 0, positions the mark at the beginning of the band; 0.5, in the
middle etc.

For rect-based marks (rect, bar, and image), if set to 1, the mark size is set
to the band width or the time unit interval. If set to 0.5, the mark size is half
of the bandwidth or the time unit interval. etc.

-}
pBandPosition : Float -> PositionChannel
pBandPosition =
    PBandPosition


{-| Discretize numeric values into bins when encoding with a position channel.
For non-default binning, bin-widths, extent etc. can be specified in the first
parameter. For example, to encode a frequency histogram with bins every 5 units:

    enc =
        encoding
            << position X [ pName "x", pOrdinal, pBin [ biStep 5 ] ]
            << position Y [ pQuant, pAggregate opCount ]

-}
pBin : List BinProperty -> PositionChannel
pBin =
    PBin


{-| Indicate that data encoded with position are already binned.
-}
pBinned : PositionChannel
pBinned =
    PBinned


{-| Set a position to an arbitrary data value. Useful for placing items at the
specific points in the data space. To place in data screen space, use [pNum](#pNum).
-}
pDatum : DataValue -> PositionChannel
pDatum =
    PDatum


{-| Set the position to the height of the enclosing data space. Useful for placing
a mark relative to the bottom edge of a view.
-}
pHeight : PositionChannel
pHeight =
    PHeight


{-| Imputation rules for a position channel. See the
[Vega-Lite impute documentation](https://vega.github.io/vega-lite/docs/impute.html)
For example, to impute the missing value of `b` with the mean of existing `b` values,
when `a` is 30 and its color group (`c`) is 1:

    let
        data =
            dataFromColumns []
                << dataColumn "a" (nums [ 0, 0, 10, 10, 20, 20, 30 ])
                << dataColumn "b" (nums [ 28, 91, 43, 55, 81, 53, 19 ])
                << dataColumn "c" (nums [ 0, 1, 0, 1, 0, 1, 0 ])

        enc =
            encoding
                << position X [ pName "a", pQuant ]
                << position Y [ pName "b", pQuant, pImpute [ imMethod imMean ] ]
                << color [ mName "c", mNominal ]
    in
    toVegaLite [ data [], enc [], line [] ]

-}
pImpute : List ImputeProperty -> PositionChannel
pImpute =
    PImpute


{-| The data fields to group by when pivoting. If not specified, a single group
containing all data objects will be used.
-}
piGroupBy : List String -> PivotProperty
piGroupBy =
    PiGroupBy


{-| Maximum number of fields to generate when pivoting. If 0 or unspecified, all
fields are pivoted. The pivot names are sorted in ascending order before any limit
is applied.
-}
piLimit : Int -> PivotProperty
piLimit =
    PiLimit


{-| The aggregation to apply to grouped fields during a pivot.
-}
piOp : Operation -> PivotProperty
piOp =
    PiOp


{-| Perform a _pivot_ operation on a table. Spreads a key-value pair of fields across
multiple fields according to the data in the _key_ field. The first two parameters
are the key and value fields respectively. The third is a set of customisation options.
This performs the same function as
['spread' in the Tidy Elm package](https://package.elm-lang.org/packages/gicentre/tidy/latest/Tidy#spread)
and the [pivot_wider](https://tidyr.tidyverse.org/dev/articles/pivot.html) /
[spread](https://tidyr.tidyverse.org/reference/spread.html) operation in the R
tidyverse. It is the inverse of [fold](#fold).

    data =
        dataFromColumns []
            << dataColumn "city" (strs [ "Bristol", "Bristol", "Sheffield", "Sheffield", "Glasgow", "Glasgow" ])
            << dataColumn "temperature" (nums [ 12, 14, 11, 13, 7, 10 ])
            << dataColumn "year" (nums [ 2017, 2018, 2017, 2018, 2017, 2018 ])

    trans =
        transform
            << pivot "year" "temperature" [ piGroupBy [ "city" ] ]

    enc =
        encoding
            -- 2017 temperatures for the Bristol, Sheffield and Glasgow
            << position X [ pName "2017", pQuant ]
            << position Y [ pName "city", pNominal ]

-}
pivot : String -> String -> List PivotProperty -> List LabelledSpec -> List LabelledSpec
pivot field valField pProps =
    (::)
        ( "multiSpecs"
        , JE.object
            ([ ( "pivot", JE.string field ), ( "value", JE.string valField ) ]
                ++ List.map pivotProperty pProps
            )
        )


{-| No point marker to be shown on a line or area mark.
-}
pmNone : PointMarker
pmNone =
    PMNone


{-| Properties of a point marker that is overlaid on a line or area mark. Used
when specifying an [maPoint](#maPoint).
-}
pmMarker : List MarkProperty -> PointMarker
pmMarker =
    PMMarker


{-| Transparent point marker to be placed on area or line mark. Useful for
interactive selections.
-}
pmTransparent : PointMarker
pmTransparent =
    PMTransparent


{-| Level of measurement when encoding with a position channel. See also
[pNominal](#pNominal), [pOrdinal](#pOrdinal), [pQuant](#pQuant), [pTemporal](#pTemporal)
and [pGeo](#pGeo) for shorthand equivalents.
-}
pMType : Measurement -> PositionChannel
pMType =
    PmType


{-| Indicate a data field encoded as a position is a geo feature. Equivalent to
`pMType GeoFeature`.
-}
pGeo : PositionChannel
pGeo =
    pMType GeoFeature


{-| Name of field used for encoding with a position channel.
-}
pName : String -> PositionChannel
pName =
    PName


{-| Indicate a data field encoded as a position is nominal. Equivalent to
`pMType Nominal`. This is the default data type.
-}
pNominal : PositionChannel
pNominal =
    PmType Nominal


{-| Set a position to an arbitrary value. Useful for placing items at the top of
a plot area (`pNum 0`) or a fixed number of pixels from the top. To place in data
space rather than screen space, use [pDatum](#pDatum).
-}
pNum : Float -> PositionChannel
pNum =
    PNumber


{-| [Point mark](https://vega.github.io/vega-lite/docs/point.html) for
symbolising a data point with a symbol.
-}
point : List MarkProperty -> ( VLProperty, Spec )
point =
    mark Point


{-| Indicate a data field encoded as a position is ordinal. Equivalent to
`pMType Ordinal`.
-}
pOrdinal : PositionChannel
pOrdinal =
    PmType Ordinal


{-| Indicate a data field encoded as a position is quantitative. Equivalent to
`pMType Quantitative`. This is not necessary when field is aggregated by a numeric
operator (e.g. [opSum](#opSum)), scaled with a numeric operator (e.g. [scLog](#scLog)),
a position field is longitude/latitude or it is binned numerically.
-}
pQuant : PositionChannel
pQuant =
    PmType Quantitative


{-| Encode a position channel. The first parameter identifies the channel, the
second a list of position encoding options.

    enc =
        encoding
            << position X [ pName "month", pTemporal ]
            << position Y [ pName "numHires", pQuant ]

-}
position : Position -> List PositionChannel -> List LabelledSpec -> List LabelledSpec
position pos pDefs =
    (::) ( positionLabel pos, List.map positionChannelProperty pDefs |> JE.object )


{-| Projection’s center as longitude and latitude in degrees.
-}
prCenter : Float -> Float -> ProjectionProperty
prCenter lng lat =
    PrCenter (Num lng) (Num lat)


{-| Specity a projection’s centre with two expressions that should evaluate to
a longitude and latitude respectively.
-}
prCenterExpr : String -> String -> ProjectionProperty
prCenterExpr lng lat =
    PrCenter (NumExpr lng) (NumExpr lat)


{-| Projection’s clipping circle radius to the specified angle in degrees.
A value of 0 will switch to antimeridian cutting rather than small-circle
clipping.
-}
prClipAngle : Float -> ProjectionProperty
prClipAngle n =
    PrClipAngle (Num n)


{-| Projection’s viewport clip extent to the specified bounds in pixels.
-}
prClipExtent : ClipRect -> ProjectionProperty
prClipExtent =
    PrClipExtent


{-| 'Hammer' map projection coefficient.
-}
prCoefficient : Float -> ProjectionProperty
prCoefficient x =
    PrCoefficient (Num x)


{-| 'Satellite' map projection distance.
-}
prDistance : Float -> ProjectionProperty
prDistance x =
    PrDistance (Num x)


{-| Reference in a position channel to a field name generated by [repeatFlow](#repeatFlow)
or [repeat](#repeat). The parameter identifies whether reference is being made to
fields that are to be encoded in layers, or in columns / rows with a flow layout.

    enc =
        encoding
            << position X [ pRepeat arFlow, pQuant ]

    spec =
          asSpec [ data [], tick [], enc [] ]

    toVegaLite
        [ repeatFlow [ "Horsepower", "Miles_per_Gallon", "Acceleration"]
        , specification spec
        ]

-}
pRepeat : Arrangement -> PositionChannel
pRepeat =
    PRepeat


{-| Specify a map projection with an expression that evaluates to a valid projection
name.
-}
prExpr : String -> Projection
prExpr =
    ProjectionExpr


{-| `Bottomley` map projection fraction.
-}
prFraction : Float -> ProjectionProperty
prFraction x =
    PrFraction (Num x)


{-| Number of lobes in lobed map projections such as the 'Berghaus star'.
-}
prLobes : Int -> ProjectionProperty
prLobes n =
    PrLobes (Num (toFloat n))


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to
a map projection property function requiring a numeric value. This can be used for
interactive parameterisation when an expression is bound to an input element.
For example,

    ps =
        params
            << param "angle"
                [ paValue (num 0)
                , paBind (ipRange [ inMax 180 ])
                ]

    proj =
        projection [ prNumExpr "angle" prClipAngle ]

-}
prNumExpr : String -> (number -> ProjectionProperty) -> ProjectionProperty
prNumExpr ex fn =
    case fn 0 of
        PrClipAngle _ ->
            PrClipAngle (NumExpr ex)

        PrPointRadius _ ->
            PrPointRadius (NumExpr ex)

        PrScale _ ->
            PrScale (NumExpr ex)

        PrPrecision _ ->
            PrPrecision (NumExpr ex)

        PrCoefficient _ ->
            PrCoefficient (NumExpr ex)

        PrDistance _ ->
            PrDistance (NumExpr ex)

        PrFraction _ ->
            PrFraction (NumExpr ex)

        PrLobes _ ->
            PrLobes (NumExpr ex)

        PrParallel _ ->
            PrParallel (NumExpr ex)

        PrRadius _ ->
            PrRadius (NumExpr ex)

        PrRatio _ ->
            PrRatio (NumExpr ex)

        PrSpacing _ ->
            PrSpacing (NumExpr ex)

        PrTilt _ ->
            PrTilt (NumExpr ex)

        _ ->
            fn 0


{-| Map projection used for geospatial coordinates.

    proj =
        projection [ prType equirectangular, prRotate -156 0 0 ]

-}
projection : List ProjectionProperty -> ( VLProperty, Spec )
projection pProps =
    ( VLProjection, JE.object (List.concatMap projectionProperty pProps) )


{-| Standard parallel for map projections such as the 'Armadillo'.
-}
prParallel : Float -> ProjectionProperty
prParallel x =
    PrParallel (Num x)


{-| A conic projection’s two standard parallels.
-}
prParallels : Float -> Float -> ProjectionProperty
prParallels lat1 lat2 =
    PrParallels (Num lat1) (Num lat2)


{-| Specify a conic projection’s two standard parallels with two expressions.
-}
prParallelsExpr : String -> String -> ProjectionProperty
prParallelsExpr lat1 lat2 =
    PrParallels (NumExpr lat1) (NumExpr lat2)


{-| Parameter name that should evaluate to either true or false for use in functions
that use predicates, such as [mCondition](#mCondition).
-}
prParam : String -> Predicate
prParam =
    Param


{-| Parameter name that should evaluate to either true or false for use in selections
for conditional encoding. Same as [prParam](#prParam) except that an empty selection
is assumed to be false.
-}
prParamEmpty : String -> Predicate
prParamEmpty =
    ParamEmpty


{-| Radius in pixels when drawing geo point features in a GeoFeature.
-}
prPointRadius : Float -> ProjectionProperty
prPointRadius x =
    PrPointRadius (Num x)


{-| Threshold for the projection’s adaptive resampling in pixels.
Corresponds to the Douglas–Peucker distance. If precision is not specified, the
projection’s current resampling precision of 0.707 is used.
-}
prPrecision : Float -> ProjectionProperty
prPrecision x =
    PrPrecision (Num x)


{-| Radius value for map projections such as the 'Gingery'.
-}
prRadius : Float -> ProjectionProperty
prRadius x =
    PrRadius (Num x)


{-| Ratio value for map projections such as the 'Hill'.
-}
prRatio : Float -> ProjectionProperty
prRatio x =
    PrRatio (Num x)


{-| Reflect the x-coordinates after performing an identity projection. This
creates a left-right mirror image of the geoshape marks when subject to an
[identityProjection](#identityProjection).
-}
prReflectX : Bool -> ProjectionProperty
prReflectX b =
    PrReflectX (Boo b)


{-| Reflect the y-coordinates after performing an identity projection. This
creates a top-bottom mirror image of the geoshape marks when subject to an
[identityProjection](#identityProjection).
-}
prReflectY : Bool -> ProjectionProperty
prReflectY b =
    PrReflectY (Boo b)


{-| A projection’s three-axis rotation angle. This should be in order _lambda phi
gamma_ specifying the rotation angles in degrees about each spherical axis.
-}
prRotate : Float -> Float -> Float -> ProjectionProperty
prRotate lambda phi gamma =
    PrRotate (Num lambda) (Num phi) (Num gamma)


{-| Specity a projection’s three-axis rotation angle with three expressions that
should evaluate to angular rotations (degrees) in _lambda phi gamma_ order.
-}
prRotateExpr : String -> String -> String -> ProjectionProperty
prRotateExpr sl sp sg =
    PrRotate (NumExpr sl) (NumExpr sp) (NumExpr sg)


{-| A projection’s zoom scale, which if set, overrides automatic scaling of a
geo feature to fit within the viewing area.
-}
prScale : Float -> ProjectionProperty
prScale x =
    PrScale (Num x)


{-| Spacing value for map projections such as the 'Lagrange'.
-}
prSpacing : Float -> ProjectionProperty
prSpacing x =
    PrSpacing (Num x)


{-| Test that should evaluate to either true or false for use in functions
that use predicates, such as [mCondition](#mCondition)
-}
prTest : BooleanOp -> Predicate
prTest =
    Test


{-| 'Satellite' map projection tilt.
-}
prTilt : Float -> ProjectionProperty
prTilt x =
    PrTilt (Num x)


{-| A projection’s panning translation in pixel units, which if set, override
automatic positioning of a geo feature to fit within the viewing area. Parameters
should be provided in x y order.
-}
prTranslate : Float -> Float -> ProjectionProperty
prTranslate tx ty =
    PrTranslate (Num tx) (Num ty)


{-| Specity a projection’s panning translation in pixel units, with two expressions
that should evaluate to x and y translations respectively.
-}
prTranslateExpr : String -> String -> ProjectionProperty
prTranslateExpr tx ty =
    PrTranslate (NumExpr tx) (NumExpr ty)


{-| Type of global map projection.
-}
prType : Projection -> ProjectionProperty
prType =
    PrType


{-| Scaling applied to a field when encoding with a position channel.
The scale will transform a field's value into a position along one axis.

For example, the following will scale the bars positioned along a horizontal axis
to have an inner spacing of 50% (0.5) of the total space allocated to each bar:

    enc =
        encoding
            << position X [ pName "ageGroup", pNominal, pScale [ scPaddingInner 0.5 ] ]

-}
pScale : List ScaleProperty -> PositionChannel
pScale =
    PScale


{-| Sort order for field when encoding with a position channel.
-}
pSort : List SortProperty -> PositionChannel
pSort =
    PSort


{-| Type of stacking offset for field when encoding with a position channel. For
example, stacking areas away from a centre-line can be used to create a
[streamgraph](https://vega.github.io/vega-lite/examples/stacked_area_stream.html):

    enc =
        encoding
            << position X [ pName "week", pOrdinal ]
            << position Y [ pName "takings", pQuant, pStack stCenter ]
            << color [ mName "shop", mNominal ]

-}
pStack : StackOffset -> PositionChannel
pStack =
    PStack


{-| Indicate a data field encoded as a position is temporal. Equivalent to
`pMType Temporal`. This is not necessary if the field is aggregated with a time unit
(e.g. [pTimeUnit](#pTimeUnit)) or scaled with [scTime](#scTime) or [scUtc](#scUtc).
-}
pTemporal : PositionChannel
pTemporal =
    PmType Temporal


{-| Form of time unit aggregation of field values when encoding with a position channel.
-}
pTimeUnit : TimeUnit -> PositionChannel
pTimeUnit =
    PTimeUnit


{-| Title of a field when encoding with a position channel. For multi-line titles,
insert `\n` at each line break or use a `"""` multi-line string.
-}
pTitle : String -> PositionChannel
pTitle =
    PTitle


{-| Set the position to the width of the enclosing data space. Useful for justifying
a mark to the right hand edge of a view. e.g. to position a mark at the right of
the data rectangle:

    enc =
        encoding
            << position X [ pWidth ]

-}
pWidth : PositionChannel
pWidth =
    PWidth


{-| Calculate quantile values from an input data stream. Useful for examining
distributional properties of a data stream and for creating
[Q-Q plots](https://en.wikipedia.org/wiki/Q–Q_plot).
-}
quantile : String -> List QuantileProperty -> List LabelledSpec -> List LabelledSpec
quantile field qProps =
    (::)
        ( "multiSpecs"
        , JE.object (( "quantile", JE.string field ) :: List.map quantileProperty qProps)
        )


{-| The data fields to group by when performing a quantile transformation. If not
specified, a single group containing all data objects will be used.
-}
qtGroupBy : List String -> QuantileProperty
qtGroupBy =
    QtGroupBy


{-| A list of probabilities in the range [0,1] for which to compute quantile values.
If not specified, the default step size of 0.01 or the value specified via [qtStep](#qtStep)
will be used.
-}
qtProbs : List Float -> QuantileProperty
qtProbs =
    QtProbs


{-| The interval between probabilities to use when performing a quantile transformation.
All values from half the given step size to 1 will be sampled. Only used if [qtProbs](#qtProbs)
is not specified.
-}
qtStep : Float -> QuantileProperty
qtStep =
    QtStep


{-| The field names to give the probability and associated quantile values generated
by a quantile transformation. If not specified, `prob` and `value` are used.
-}
qtAs : String -> String -> QuantileProperty
qtAs =
    QtAs


{-| Year quarter time unit used for discretizing temporal data.
-}
quarter : TimeUnit
quarter =
    Quarter


{-| Year quarter and month time unit used for discretizing temporal data.
-}
quarterMonth : TimeUnit
quarterMonth =
    QuarterMonth


{-| Default color scheme for categorical ranges.
-}
racoCategory : String -> RangeConfig
racoCategory =
    RCategory


{-| Default diverging color scheme.
-}
racoDiverging : String -> RangeConfig
racoDiverging =
    RDiverging


{-| Default 'heatmap' color scheme.
-}
racoHeatmap : String -> RangeConfig
racoHeatmap =
    RHeatmap


{-| Default ordinal color scheme.
-}
racoOrdinal : String -> RangeConfig
racoOrdinal =
    ROrdinal


{-| Default ramp (continuous) color scheme.
-}
racoRamp : String -> RangeConfig
racoRamp =
    RRamp


{-| Default color scheme symbols.
-}
racoSymbol : String -> RangeConfig
racoSymbol =
    RSymbol


{-| A list of expressions that each evaluate to an element of a scale range. For
example to set a positional range based on two sliders:

    ps =
        params
            << param "xMin"
                [ paValue (num 0)
                , paBind (ipRange [ inMin 0, inMax 400 ])
                ]
            << param "xMax"
                [ paValue (num 400)
                , paBind (ipRange [ inMin 0, inMax 400 ])
                ]

    enc =
        encoding
            << position X
                [ pName "x"
                , pScale [ scRange (raExprs [ "xMin", "xMax" ]) ]
                ]

-}
raExprs : List String -> ScaleRange
raExprs ss =
    RExprs ss


{-| Specify the field that contains explicit range values. This should be a one-to-one
match with the field of domain values. Can be used, for example, to set color values
explicitly from a data source.
-}
raField : String -> ScaleRange
raField =
    RField


{-| Set the maximum value of a continuous numeric range. To set both the min and
max values use [raNums](#raNums).
-}
raMax : Float -> ScaleRange
raMax n =
    RMaxNumber (Num n)



-- TODO: Pending confirmation of https://github.com/vega/vega-lite/issues/6758
--{ - | Set the maximum value of a range comprising ordered text values. To set all
--values use [raStrs](#raStrs).
---}
-- raMaxStr : String -> ScaleRange
-- raMaxStr =
--     RMaxString


{-| Set the minimum value of a continuous numeric range. To set both the min and
max values use [raNums](#raNums).
-}
raMin : Float -> ScaleRange
raMin n =
    RMinNumber (Num n)



-- TODO: Pending confirmation of https://github.com/vega/vega-lite/issues/6758
--{ - | Set the minimum value of a range comprising ordered text values. To set all
--values use [raStrs](#raStrs).
---}
-- raMinStr : String -> ScaleRange
-- raMinStr =
--     RMinString


{-| Name of a pre-defined scale range (e.g. `symbol` or `diverging`).
-}
raName : String -> ScaleRange
raName =
    RName


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to
a range scale property function requiring a numeric value. This can be used for
interactive parameterisation when an expression is bound to an input element.
For example,

    ps =
        params
            << param "right"
                [ paValue (num 0)
                , paBind (ipRange [ inMax 500 ])
                ]

    enc =
        encoding
            << position X
                [ pName "x"
                , pScale [ scRange (raNumExpr "right" raMax) ]
                ]

-}
raNumExpr : String -> (number -> ScaleRange) -> ScaleRange
raNumExpr ex fn =
    case fn 0 of
        RMaxNumber _ ->
            RMaxNumber (NumExpr ex)

        RMinNumber _ ->
            RMinNumber (NumExpr ex)

        _ ->
            fn 0


{-| Scale range comprising numeric lists. Useful, for example, when defining custom
dash styles for a [strokeDash](#strokeDash) channel encoding.
-}
raNumLists : List (List Float) -> ScaleRange
raNumLists =
    RNumberLists


{-| Numeric scale range. Depending on the scaling this may be a [min, max]
pair, or a list of explicit numerical values.
-}
raNums : List Float -> ScaleRange
raNums ns =
    RNumbers (Nums ns)


{-| Text scale range for discrete scales.
-}
raStrs : List String -> ScaleRange
raStrs ss =
    RStrings (Strs ss)


{-| Indicate how a channel's axes should be resolved when defined in more than
one view in a composite visualization.
-}
reAxis : List ( Channel, Resolution ) -> Resolve
reAxis =
    RAxis


{-| [Rectangle mark](https://vega.github.io/vega-lite/docs/rect.html).
-}
rect : List MarkProperty -> ( VLProperty, Spec )
rect =
    mark Rect


{-| Generate a 2d regression model for smoothing and predicting data. The first
parameter is the name of the field representing the dependent variable (commonly
mapped to the y-axis), the second is the name of the field representing the
independent variable (commonly mapped to the x-axis). The third parameter is a
list of optional regression customisation options.
-}
regression : String -> String -> List RegressionProperty -> List LabelledSpec -> List LabelledSpec
regression fDep fInd rgProps =
    (::)
        ( "multiSpecs"
        , JE.object
            ([ ( "regression", JE.string fDep ), ( "on", JE.string fInd ) ]
                ++ List.map regressionProperty rgProps
            )
        )


{-| Channel should be independent of others in a composite visualization.
-}
reIndependent : Resolution
reIndependent =
    RIndependent


{-| Indicate how a channel's legends should be resolved when defined in more
than one view in a composite visualization.
-}
reLegend : List ( Channel, Resolution ) -> Resolve
reLegend =
    RLegend


{-| Define the fields that will be used to compose rows and columns of a set of
small multiples. Similar to [repeatFlow](#repeatFlow) except that the fields for
repetition by rows or by columns are set explicitly.

Unlike _faceting_, which creates multiple charts based on different values of a
single field, _repeating_ uses a different field for each chart.

    spec = asSpec [...]
    toVegaLite
        [ repeat [ columnFields [ "Cat", "Dog", "Fish" ] ]
        , specification spec
        ]

-}
repeat : List RepeatFields -> ( VLProperty, Spec )
repeat fields =
    ( VLRepeat, JE.object (List.map repeatFieldsProperty fields) )


{-| Define the fields that will be used to compose a flow layout of a set of
small multiples. Used when the encoding is largely identical, but the data field
used in each might vary. When a list of fields is identified with `repeat` you also
need to define a full specification to apply to each of those fields using `asSpec`.

Small multiples will be laid out from left to right, moving on to new rows only
if the number of plots exceeds an optional column limit (specified via
[columns](#columns)).

    spec = asSpec [...]
    toVegaLite
        [ repeatFlow [ "Cat", "Dog", "Fish" ]
        , specification spec
        ]

-}
repeatFlow : List String -> ( VLProperty, Spec )
repeatFlow fields =
    ( VLRepeat, JE.list JE.string fields )


{-| Indicate how a channel's scales should be resolved when defined in more
than one view in a composite visualization.
-}
reScale : List ( Channel, Resolution ) -> Resolve
reScale =
    RScale


{-| Channel should be shared with others in a composite visualization.
-}
reShared : Resolution
reShared =
    RShared


{-| Define a resolution option to be applied when scales, axes or legends in composite
views share channel encodings. For example, it allows different color scales to be
used in a layered view, or different axis scales to be used in a faceted view. Each
resolution rule should be in a tuple pairing the channel to which it applies and
the rule type. The first parameter identifies the type of resolution.

    resolve
        << resolution (reScale [ ( chY, reIndependent ) ])
        << resolution (reScale [ ( chColor, reIndependent ) ])
        << resolution (reLegend [ ( chShape, reShared ) ])

-}
resolution : Resolve -> List LabelledSpec -> List LabelledSpec
resolution res =
    (::) (resolveProperty res)


{-| Determine whether or not scales, axes or legends in composite views should
share channel encodings.

    let
        data =
            dataFromColumns []
                << dataColumn "x" (nums [ 1, 2, 3, 4, 5 ])
                << dataColumn "a" (nums [ 28, 91, 43, 55, 81 ])
                << dataColumn "b" (nums [ 17, 22, 28, 30, 40 ])

        encBar =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y [ pName "a", pQuant ]

        specBar =
            asSpec [ bar [], encBar [] ]

        encLine =
            encoding
                << position X [ pName "x", pQuant ]
                << position Y [ pName "b", pQuant ]

        specLine =
            asSpec [ line [ maColor "firebrick" ], encLine [] ]

        res =
            resolve
                << resolution (reScale [ ( chY, reIndependent ) ])
    in
    toVegaLite [ data [], res [], layer [ specBar, specLine ] ]

-}
resolve : List LabelledSpec -> ( VLProperty, Spec )
resolve res =
    ( VLResolve, JE.object res )


{-| Name the outputs of a regression transform. The first parameter is the name to
give the field containing the independent variable, the second the name to
give the field containing dependent variable. If not specified, the
original input independent and dependent field names are used.
-}
rgAs : String -> String -> RegressionProperty
rgAs =
    RgAs


{-| RGB color interpolation for continuous color scales using the given gamma
value (anchored at 1).
-}
rgb : Float -> CInterpolate
rgb =
    Rgb


{-| Indicate an exponential regression method.
-}
rgExp : RegressionMethod
rgExp =
    RgExp


{-| The min (first parameter) - max (second parameter) domain over which to estimate
the dependent variable in a regression. If unspecified, the full extent of input
values will be used.
-}
rgExtent : Float -> Float -> RegressionProperty
rgExtent =
    RgExtent


{-| The data fields to group by when generating a regression model. If not
specified, a single group containing all data objects will be used.
-}
rgGroupBy : List String -> RegressionProperty
rgGroupBy =
    RgGroupBy


{-| Indicate a linear regression method.
-}
rgLinear : RegressionMethod
rgLinear =
    RgLinear


{-| Indicate a log regression method.
-}
rgLog : RegressionMethod
rgLog =
    RgLog


{-| The type of regression model to use when generating a 2d regression.
-}
rgMethod : RegressionMethod -> RegressionProperty
rgMethod =
    RgMethod


{-| The order of a polynomial model to use when generating a 2d regression. Only
applies if [rgMethod](#rgMethod) is set to [rgPoly](#rgPoly).
-}
rgOrder : Int -> RegressionProperty
rgOrder =
    RgOrder


{-| Whether or not the regression transform should return just the parameters
of the regression function (one object per group) instead of trend line points.
If `True`, objects include a `coef` array of fitted coefficient values, starting
with the intercept term and then terms of increasing order and an `rSquared` value,
indicating the total variance explained by the model.
-}
rgParams : Bool -> RegressionProperty
rgParams =
    RgParams


{-| Indicate a polynomial regression method. The order of the polynomial can be
set with [rgOrder](#rgOrder) (defaulting to cubic if not provided).
-}
rgPoly : RegressionMethod
rgPoly =
    RgPoly


{-| Indicate a power regression method.
-}
rgPow : RegressionMethod
rgPow =
    RgPow


{-| Indicate a quadratic regression method.
-}
rgQuad : RegressionMethod
rgQuad =
    RgQuad


{-| Encode a new facet to be arranged in rows. The first parameter is a list of
facet properties that define the faceting channel. See the
[Vega-Lite row documentation](https://vega.github.io/vega-lite/docs/facet.html#row--column-encoding-channels).

Note that when faceting, dimensions specified with [width](#width) and [height](#height)
refer to the individual faceted plots, not the assemblage as a whole.

    let
        data =
            dataFromUrl "crimeData.csv"

        enc =
            encoding
                << position X [ pName "month", pTemporal ]
                << position Y
                    [ pName "reportedCrimes"
                    , pQuant
                    , pAggregate opSum
                    , pTitle ""
                    ]
                << row [ fName "crimeType", fNominal ]
    in
    toVegaLite [ height 80, data [], bar [], enc [] ]

-}
row : List FacetChannel -> List LabelledSpec -> List LabelledSpec
row fFields =
    (::) ( "row", JE.object (List.map facetChannelProperty fFields) )


{-| The mapping between a row and its field definitions in a set of faceted
small multiples. This is used when specifying a more flexible [facet](#facet)
rather than the compact, but simplified, [row](#row).
-}
rowBy : List FacetChannel -> FacetMapping
rowBy =
    RowBy


{-| Create a list of fields to use in set of repeated small multiples arranged in
rows. The list of fields named here can be referenced in an encoding with
`pRepeat row`, `mRepeat row` etc.
-}
rowFields : List String -> RepeatFields
rowFields =
    RowFields


{-| [Rule line](https://vega.github.io/vega-lite/docs/rule.html) connecting
two vertices.
-}
rule : List MarkProperty -> ( VLProperty, Spec )
rule =
    mark Rule


{-| Default inner padding for x and y band-ordinal scales.
-}
sacoBandPaddingInner : Float -> ScaleConfig
sacoBandPaddingInner =
    SCBandPaddingInner


{-| Default outer padding for x and y band-ordinal scales.
-}
sacoBandPaddingOuter : Float -> ScaleConfig
sacoBandPaddingOuter =
    SCBandPaddingOuter


{-| Default inner padding for x and y band-ordinal scales of `bar` marks.
-}
sacoBarBandPaddingInner : Float -> ScaleConfig
sacoBarBandPaddingInner =
    SCBarBandPaddingInner


{-| Default outer padding for x and y band-ordinal scales of `bar` marks.
-}
sacoBarBandPaddingOuter : Float -> ScaleConfig
sacoBarBandPaddingOuter =
    SCBarBandPaddingOuter


{-| Default inner padding for x and y band-ordinal scales of `rect` marks.
-}
sacoRectBandPaddingInner : Float -> ScaleConfig
sacoRectBandPaddingInner =
    SCRectBandPaddingInner


{-| Default outer padding for x and y band-ordinal scales of `rect` marks.
-}
sacoRectBandPaddingOuter : Float -> ScaleConfig
sacoRectBandPaddingOuter =
    SCRectBandPaddingOuter


{-| Whether or not by default values that exceed the data domain are clamped to
the min/max range value.
-}
sacoClamp : Bool -> ScaleConfig
sacoClamp =
    SCClamp


{-| Default maximum value for mapping quantitative fields to a bar's
size/bandSize.
-}
sacoMaxBandSize : Float -> ScaleConfig
sacoMaxBandSize =
    SCMaxBandSize


{-| Default maximum value for mapping a quantitative field to a text
mark's size.
-}
sacoMaxFontSize : Float -> ScaleConfig
sacoMaxFontSize =
    SCMaxFontSize


{-| Default maximum opacity (in the range [0, 1]) for mapping a field
to opacity.
-}
sacoMaxOpacity : Float -> ScaleConfig
sacoMaxOpacity =
    SCMaxOpacity


{-| Default maximum size for point-based scales.
-}
sacoMaxSize : Float -> ScaleConfig
sacoMaxSize =
    SCMaxSize


{-| Default maximum stroke width for rule, line and trail marks.
-}
sacoMaxStrokeWidth : Float -> ScaleConfig
sacoMaxStrokeWidth =
    SCMaxStrokeWidth


{-| Default minimum value for mapping quantitative fields to a bar's size/bandSize.
-}
sacoMinBandSize : Float -> ScaleConfig
sacoMinBandSize =
    SCMinBandSize


{-| Default minimum value for mapping a quantitative field to a text mark's size.
-}
sacoMinFontSize : Float -> ScaleConfig
sacoMinFontSize =
    SCMinFontSize


{-| Default minimum opacity (0 to 1) for mapping a field to opacity.
-}
sacoMinOpacity : Float -> ScaleConfig
sacoMinOpacity =
    SCMinOpacity


{-| Default minimum size for point-based scales (when not forced to start at zero).
-}
sacoMinSize : Float -> ScaleConfig
sacoMinSize =
    SCMinSize


{-| Default minimum stroke width for rule, line and trail marks.
-}
sacoMinStrokeWidth : Float -> ScaleConfig
sacoMinStrokeWidth =
    SCMinStrokeWidth


{-| Default padding for point-ordinal scales.
-}
sacoPointPadding : Float -> ScaleConfig
sacoPointPadding =
    SCPointPadding


{-| Whether or not numeric values are rounded to integers when scaling. Useful
for snapping to the pixel grid.
-}
sacoRound : Bool -> ScaleConfig
sacoRound =
    SCRound


{-| Whether or not to use the source data range before aggregation.
-}
sacoUseUnaggregatedDomain : Bool -> ScaleConfig
sacoUseUnaggregatedDomain =
    SCUseUnaggregatedDomain


{-| Whether or not to reverse the x-scaling by default (useful for right to left
charts).
-}
sacoXReverse : Bool -> ScaleConfig
sacoXReverse =
    SCXReverse


{-| Randomly sample rows from a data source up to a given maximum. For example,
to randomly sample 50 values from a sine curve:

    data =
        dataSequenceAs 0 13 0.001 "x"

    trans =
        transform
            << calculateAs "sin(datum.x)" "y"
            << sample 50

-}
sample : Float -> List LabelledSpec -> List LabelledSpec
sample maxSize =
    (::) ( "sample", JE.float maxSize )


{-| Alignment of the steps within the scale range. Parameter is capped between 0
and 1 where 0.5 indicates steps are centred within range, 0 shifts bands to an
axis, 1 away from axis.
-}
scAlign : Float -> ScaleProperty
scAlign x =
    SAlign (max 0 (min 1 x))


{-| A band scale.
-}
scBand : Scale
scBand =
    ScBand


{-| The base to use for log scaling.
-}
scBase : Float -> ScaleProperty
scBase =
    SBase


{-| An ordinal band scale.
-}
scBinOrdinal : Scale
scBinOrdinal =
    ScBinOrdinal


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to
a scale property function requiring a Boolean value. This can be used to provide an
interactive parameterisation of a mark property by providing an expression bound
to an input element. For example,

    ps =
        params
            << param "rev"
                [ paValue (boo False)
                , paBind (ipCheckbox [ inName "reverse colours" ])
                ]

    enc =
        encoding
            << color [ mName "val" mScale [ scBooExpr "rev" scReverse ] ]

-}
scBooExpr : String -> (Bool -> ScaleProperty) -> ScaleProperty
scBooExpr ex fn =
    case fn True of
        SClamp _ ->
            SClamp (BooExpr ex)

        SReverse _ ->
            SReverse (BooExpr ex)

        SRound _ ->
            SRound (BooExpr ex)

        SZero _ ->
            SZero (BooExpr ex)

        _ ->
            fn False


{-| Whether or not values outside the data domain are clamped to the minimum or
maximum value.
-}
scClamp : Bool -> ScaleProperty
scClamp b =
    SClamp (Boo b)


{-| The desired desired slope of the [scSymLog](#scSymLog) function at zero. If
unspecified, the default is 1.
-}
scConstant : Float -> ScaleProperty
scConstant =
    SConstant


{-| Custom scaling domain.
-}
scDomain : ScaleDomain -> ScaleProperty
scDomain =
    SDomain


{-| Expression that defines a scaling domain.
-}
scDomainExpr : String -> ScaleProperty
scDomainExpr =
    SDomainExpr


{-| Deprecated in favour of `scDomain doMid`
-}
scDomainMid : Float -> ScaleProperty
scDomainMid =
    SDomainMid


{-| The exponent to use for power scaling.
-}
scExponent : Float -> ScaleProperty
scExponent =
    SExponent


{-| Interpolation method for scaling range values.
-}
scInterpolate : CInterpolate -> ScaleProperty
scInterpolate =
    SInterpolate


{-| A linear scale.
-}
scLinear : Scale
scLinear =
    ScLinear


{-| A log scale. Defaults to log of base 10, but can be customised by setting
[scBase](#scBase) to some other value. If data to be scaled contain zeros or negative
values, consider [scSymLog](#scSymLog) instead.
-}
scLog : Scale
scLog =
    ScLog


{-| 'Nice' minimum and maximum values in a scaling (e.g. multiples of 10).
-}
scNice : ScaleNice -> ScaleProperty
scNice =
    SNice


{-| An ordinal scale.
-}
scOrdinal : Scale
scOrdinal =
    ScOrdinal


{-| Padding in pixels to apply to a scaling.
-}
scPadding : Float -> ScaleProperty
scPadding =
    SPadding


{-| Inner padding to apply to a band scaling.
-}
scPaddingInner : Float -> ScaleProperty
scPaddingInner =
    SPaddingInner


{-| Outer padding to apply to a band scaling.
-}
scPaddingOuter : Float -> ScaleProperty
scPaddingOuter =
    SPaddingOuter


{-| A point scale.
-}
scPoint : Scale
scPoint =
    ScPoint


{-| A power scale. The exponent to use for scaling is specified with
[scExponent](#scExponent).
-}
scPow : Scale
scPow =
    ScPow


{-| A [symmetrical log](https://www.researchgate.net/profile/John_Webber4/publication/233967063_A_bi-symmetric_log_transformation_for_wide-range_data/links/0fcfd50d791c85082e000000.pdf)
scale. Similar to a log scale but supports zero and negative values. The slope
of the function at zero can be set with [scConstant](#scConstant).
-}
scSymLog : Scale
scSymLog =
    ScSymLog


{-| A quantile scale.
-}
scQuantile : Scale
scQuantile =
    ScQuantile


{-| A quantizing scale.
-}
scQuantize : Scale
scQuantize =
    ScQuantize


{-| Range of a scaling. The type of range depends on the encoding channel.
-}
scRange : ScaleRange -> ScaleProperty
scRange =
    SRange


{-| Whether or not to reverse sorting order of a scaling.
-}
scReverse : Bool -> ScaleProperty
scReverse b =
    SReverse (Boo b)


{-| Whether or not numeric values in a scaling are rounded to integers.
-}
scRound : Bool -> ScaleProperty
scRound b =
    SRound (Boo b)


{-| Color scheme used by a color scaling with [mScale](#mScale). The first parameter
is the name of the scheme (e.g. "viridis") and the second an optional specification
of the number of colors to use (list of one number), or the extent of the color
range to use (list of two numbers between 0 and 1).

    color
        [ mName "value"
        , mOrdinal
        , mScale [ scScheme "redblue" [ 0, 0.8 ] ]
        ]

-}
scScheme : String -> List Float -> ScaleProperty
scScheme =
    SScheme


{-| Expression that evaluates to a color scheme for color scaling. The first parameter
is the expression and the second as for [scScheme](#scScheme). For example, to
choose from a pair of preset schemes:

    ps =
        params
            << param "clrs"
                [ paValue (str "plasma")
                , paBind (ipSelect [ inOptions [ "plasma", "oranges" ] ])
                ]

    enc =
        encoding
            << color [ mName "val", mScale [ scSchemeExpr "clrs" [] ] ]

-}
scSchemeExpr : String -> List Float -> ScaleProperty
scSchemeExpr =
    SSchemeExpr


{-| A square root scale.
-}
scSqrt : Scale
scSqrt =
    ScSqrt


{-| A threshold scale.
-}
scThreshold : Scale
scThreshold =
    ScThreshold


{-| A temporal scale.
-}
scTime : Scale
scTime =
    ScTime


{-| Type of scaling to apply.
-}
scType : Scale -> ScaleProperty
scType =
    SType


{-| A UTC temporal scale.
-}
scUtc : Scale
scUtc =
    ScUtc


{-| Whether or not a numeric scaling should be forced to include a zero value.
-}
scZero : Bool -> ScaleProperty
scZero b =
    SZero (Boo b)


{-| Deprecated in favour of [paBind](#paBind).
-}
seBind : List Binding -> SelectionProperty
seBind =
    Bind


{-| Deprecated in favour of [paBindLegend](#paBindLegend). Where previously you
might have specified a legend binding as

    sel =
        selection
            << select "legSel"
                seSingle
                [ seBindLegend
                    [ blField "crimeType"
                    , blEvent "dblclick"
                    ]
                ]

It should now be specified as

    ps =
        params
            << param "legSel"
                [ paSelect sePoint [ seFields [ "crimeType" ] ]
                , paBindLegend "dblclick"
                ]

-}
seBindLegend : List BindLegendProperty -> SelectionProperty
seBindLegend =
    BindLegend


{-| Deprecated in favour of [paBindScales](#paBindScales). Where previously you
might have specified a scale binding as:

    sel =
        selection
            << select "zoomer" seInterval [ seBindScales ]

It should now be specified as:

    ps =
        params
            << param "zoomer" [ paSelect seInterval [], paBindScales ]

-}
seBindScales : SelectionProperty
seBindScales =
    BindScales


{-| [Vega event stream selector](https://vega.github.io/vega/docs/event-streams/#selector)
that can clear a selection. For example, to allow a zoomed/panned view to be reset
on shift-click:

    ps =
        params
            << param "myZoomPan"
                [ paSelect seInterval [ seClear "click[event.shiftKey]" ]
                , paBindScales
                ]

To remove the default clearing behaviour of a selection, provide an empty string
rather than an event stream selector.

-}
seClear : String -> SelectionProperty
seClear =
    Clear


{-| Second of a minute time unit used for discretizing temporal data.
-}
seconds : TimeUnit
seconds =
    Seconds


{-| Seconds and milliseconds time unit used for discretizing temporal data.
-}
secondsMilliseconds : TimeUnit
secondsMilliseconds =
    SecondsMilliseconds


{-| Deprecated in favour of [prParamEmpty](#prParamEmpty) and
[fiSelectionEmpty](#fiSelectionEmpty).
-}
seEmpty : SelectionProperty
seEmpty =
    Empty


{-| Encoding channels that form a named selection. For example, to _project_ a
selection across all items that share the same value in the color channel:

    ps =
        params
            << param "sel" [ paSelect sePoint [ seEncodings [ chColor ] ] ]

-}
seEncodings : List Channel -> SelectionProperty
seEncodings =
    Encodings


{-| Field names for projecting a selection over multiple fields.
-}
seFields : List String -> SelectionProperty
seFields =
    Fields


{-| One selection available across all subviews (default).
-}
seGlobal : SelectionResolution
seGlobal =
    SeGlobal


{-| Deprecated in favour of [paValue](#paValue) for initialising the value of a
selection parameter.
-}
seInit : List ( String, DataValue ) -> SelectionProperty
seInit =
    SInit


{-| Deprecated in favour of [paValue](#paValue) for initialising the value of a
selection parameter.
-}
seInitInterval : Maybe ( DataValue, DataValue ) -> Maybe ( DataValue, DataValue ) -> SelectionProperty
seInitInterval =
    SInitInterval


{-| Each subview contains its own brush and marks are selected if they lie
within _all_ of these individual selections.
-}
seIntersection : SelectionResolution
seIntersection =
    SeIntersection


{-| Indicate a draggable bounding rectangle can be made for selecting all items
that intersect with it.
-}
seInterval : Selection
seInterval =
    SeInterval


{-| Deprecated in favour of creating a [param](#param) containing a [paSelect](#paSelect) property.
-}
select : String -> Selection -> List SelectionProperty -> List LabelledSpec -> List LabelledSpec
select selName sType options =
    let
        selProps =
            ( "type", JE.string (selectionLabel sType) )
                :: List.concatMap selectionProperties options
                |> List.filter (Tuple.second >> (/=) JE.null)
    in
    (::) ( selName, JE.object selProps )


{-| Deprecated in favour of [bParam](#bParam) to treat a selection parameter as a
Boolean expression.
-}
selected : String -> BooleanOp
selected =
    Selection


{-| Deprecated in favour of [params](#params).
-}
selection : List LabelledSpec -> ( VLProperty, Spec )
selection sels =
    ( VLSelection, JE.object sels )


{-| Deprecated in favour of [prParam](#prParam).
-}
selectionName : String -> BooleanOp
selectionName =
    SelectionName


{-| Deprecated in favour of [sePoint](#sePoint).
-}
seMulti : Selection
seMulti =
    SeMulti


{-| Whether or not a selection should capture nearest marks to a pointer
rather than an exact position match.
-}
seNearest : Bool -> SelectionProperty
seNearest =
    Nearest


{-| [Vega event stream selector](https://vega.github.io/vega/docs/event-streams/#selector)
that triggers a selection. For example, to create a paintbrush effect under the
pointer:

    ps =
        params
            << params "paint" [ paSelect sePoint [ seOn "mouseover" ] ]

-}
seOn : String -> SelectionProperty
seOn =
    On


{-| Specify a point selection type.
-}
sePoint : Selection
sePoint =
    SePoint


{-| Strategy that determines how selections’ data queries are resolved when applied
in a filter transform, conditional encoding rule, or scale domain.
-}
seResolve : SelectionResolution -> SelectionProperty
seResolve =
    ResolveSelections


{-| Appearance of an interval selection mark (dragged rectangle).
-}
seSelectionMark : List SelectionMarkProperty -> SelectionProperty
seSelectionMark =
    SelectionMark


{-| Deprecated in favour of [sePoint](#sePoint) with [seToggle](#seToggle) set to
[tpFalse](#tpFalse).
-}
seSingle : Selection
seSingle =
    SeSingle


{-| Predicate expression that determines a toggled selection. See the
[Vega-Lite toggle documentation](https://vega.github.io/vega-lite/docs/selection.html#toggle)

For example, to create a paintbrush type effect that leaves a trail of selections
under the pointer while the shift key is pressed down:

    ps =
        params
            << param "paint"
                [ paSelect sePoint [ seOn "mouseover", seToggle tpShiftKey ] ]

-}
seToggle : TogglePredicate -> SelectionProperty
seToggle =
    Toggle


{-| Translation selection transformation used for panning a view. See the
[Vega-Lite translate documentation](https://vega.github.io/vega-lite/docs/translate.html)
-}
seTranslate : String -> SelectionProperty
seTranslate =
    Translate


{-| Each subview contains its own brush and marks are selected if they lie
within _any_ of these individual selections.
-}
seUnion : SelectionResolution
seUnion =
    SeUnion


{-| Zooming selection transformation used for zooming a view. See the
[Vega-Lite zoom documentation](https://vega.github.io/vega-lite/docs/zoom.html)
-}
seZoom : String -> SelectionProperty
seZoom =
    Zoom


{-| Encode a shape channel. The first parameter is a list of shape encoding options
such as the data to encode, custom shape encodings etc.

    enc =
        encoding
            << shape [ mName "company", mNominal ]

-}
shape : List MarkChannel -> List LabelledSpec -> List LabelledSpec
shape markProps =
    (::) ( "shape", List.concatMap markChannelProperties markProps |> JE.object )


{-| Bottom side, used, for example, to specify an axis position.
-}
siBottom : Side
siBottom =
    SBottom


{-| Specify a side position with an interactive expression.
-}
siExpr : String -> Side
siExpr =
    SExpr


{-| Left side, used, for example, to specify an axis position.
-}
siLeft : Side
siLeft =
    SLeft


{-| Right side, used, for example, to specify an axis position.
-}
siRight : Side
siRight =
    SRight


{-| Top side, used, for example, to specify an axis position.
-}
siTop : Side
siTop =
    STop


{-| Encode a size channel. The first parameter is a list of size encoding options
such as the data to encode, size scaling etc.

    enc =
        encoding
            << size [ mName "population", mQuant ]

-}
size : List MarkChannel -> List LabelledSpec -> List LabelledSpec
size markProps =
    (::) ( "size", List.concatMap markChannelProperties markProps |> JE.object )


{-| Cursor type to appear when pointer is over an interval selection mark
(dragged rectangular area).
-}
smCursor : Cursor -> SelectionMarkProperty
smCursor =
    SMCursor


{-| Fill color of an interval selection mark (dragged rectangular area).
-}
smFill : String -> SelectionMarkProperty
smFill =
    SMFill


{-| Fill opacity of an interval selection mark in the range 0 to 1.
-}
smFillOpacity : Float -> SelectionMarkProperty
smFillOpacity =
    SMFillOpacity


{-| Stroke color of an interval selection mark.
-}
smStroke : String -> SelectionMarkProperty
smStroke =
    SMStroke


{-| Stroke opacity of an interval selection mark in the range 0 to 1.
-}
smStrokeOpacity : Float -> SelectionMarkProperty
smStrokeOpacity =
    SMStrokeOpacity


{-| Stroke width of an interval selection mark.
-}
smStrokeWidth : Float -> SelectionMarkProperty
smStrokeWidth =
    SMStrokeWidth


{-| Stroke dash style of an interval selection mark.
-}
smStrokeDash : List Float -> SelectionMarkProperty
smStrokeDash =
    SMStrokeDash


{-| Stroke dash offset of an interval selection mark.
-}
smStrokeDashOffset : Float -> SelectionMarkProperty
smStrokeDashOffset =
    SMStrokeDashOffset


{-| Indicate sorting is to be applied from low to high.
-}
soAscending : SortProperty
soAscending =
    Ascending


{-| Sort by another channel.

    position Y [ pName "age", pOrdinal, pSort [ soByChannel chX ] ]

-}
soByChannel : Channel -> SortProperty
soByChannel =
    ByChannel


{-| Sort by the aggregated summary of a given field using a given aggregation
operation. e.g., sort the categorical data field `variety` by the mean age of
the data in each variety category:

    position Y
        [ pName "variety"
        , pOrdinal
        , pSort [ soByField "age" opMean, soDescending ]
        ]

-}
soByField : String -> Operation -> SortProperty
soByField =
    ByFieldOp


{-| Sort by the aggregated summaries of the given fields (referenced by a repeat
iterator) using a given aggregation operation.
-}
soByRepeat : Arrangement -> Operation -> SortProperty
soByRepeat =
    ByRepeatOp


{-| Custom sort order listing data values explicitly.
-}
soCustom : DataValues -> SortProperty
soCustom =
    CustomSort


{-| Indicate sorting is to be applied from high to low.
-}
soDescending : SortProperty
soDescending =
    Descending


{-| Spacing between sub-views in a composition operator.
-}
spacing : Float -> ( VLProperty, Spec )
spacing sp =
    ( VLSpacing, JE.float sp )


{-| Similar to [spacing](#spacing) but with independent spacing for rows (first
parameter) and columns (second parameter).
-}
spacingRC : Float -> Float -> ( VLProperty, Spec )
spacingRC spRow spCol =
    ( VLSpacing, JE.object [ ( "row", JE.float spRow ), ( "column", JE.float spCol ) ] )


{-| Define a specification object for use with faceted and repeated small multiples.

    spec = ...
    toVegaLite
        [ facet [ rowBy [ fName "Origin", fNominal ] ]
        , specification spec
        ]

-}
specification : Spec -> ( VLProperty, Spec )
specification spec =
    ( VLSpec, spec )


{-| Generate a data source that is a sphere for bounding global geographic data.
The sphere will be subject to whatever projection is specified for the view.

    toVegaLite
        [ sphere
        , projection [ prType orthographic ]
        , geoshape [ maFill "aliceblue" ]
        ]

-}
sphere : Data
sphere =
    ( VLData, JE.object [ ( "sphere", JE.bool True ) ] )


{-| [Square mark](https://vega.github.io/vega-lite/docs/square.html) for symbolising
points.
-}
square : List MarkProperty -> ( VLProperty, Spec )
square =
    mark Square


{-| Apply a stack transform for positioning multiple values. This is an alternative
to specifying stacking directly when encoding position. First parameter is the field
to be stacked; the second the fields to group by; the third and fourth are the names
to give the output field names; the fifth lists the optional offset and sort properties.
-}
stack : String -> List String -> String -> String -> List StackProperty -> List LabelledSpec -> List LabelledSpec
stack f grp start end sProps =
    (::)
        ( "multiSpecs"
        , JE.object
            ([ ( "stack", JE.string f )
             , ( "groupby", JE.list JE.string grp )
             , ( "as", JE.list JE.string [ start, end ] )
             ]
                ++ List.map stackProperty sProps
            )
        )


{-| Indicate that the given field should be sorted in ascending order.
-}
stAscending : String -> SortField
stAscending =
    WAscending


{-| Offset a stacked layout using a central stack baseline.
-}
stCenter : StackOffset
stCenter =
    OfCenter


{-| Indicate that the given field should be sorted in descending order.
-}
stDescending : String -> SortField
stDescending =
    WDescending


{-| A stereographic map projection.
-}
stereographic : Projection
stereographic =
    Stereographic


{-| Do not stack marks (produces a layered plot).
-}
stNone : StackOffset
stNone =
    OfNone


{-| Rescale a stacked layout to use a common height while preserving relative size
of stacked quantities.
-}
stNormalize : StackOffset
stNormalize =
    OfNormalize


{-| Stack offset when applying a stack transformation.
-}
stOffset : StackOffset -> StackProperty
stOffset =
    StOffset


{-| Ordering within a stack when applying a stack transformation.
-}
stSort : List SortField -> StackProperty
stSort =
    StSort


{-| A string data value.
-}
str : String -> DataValue
str =
    DStr


{-| Encode a stroke channel. This acts in a similar way to encoding by `color` but
only affects the exterior boundary of marks.
-}
stroke : List MarkChannel -> List LabelledSpec -> List LabelledSpec
stroke markProps =
    (::) ( "stroke", List.concatMap markChannelProperties markProps |> JE.object )


{-| Encode a stroke dash channel.

    enc =
        encoding
            << position X [ pName "date", pTemporal ]
            << position Y [ pName "price", pQuant ]
            << strokeDash [ mName "company" ]

-}
strokeDash : List MarkChannel -> List LabelledSpec -> List LabelledSpec
strokeDash markProps =
    (::) ( "strokeDash", List.concatMap markChannelProperties markProps |> JE.object )


{-| Encode a stroke opacity channel. This acts in a similar way to encoding by
`opacity` but only affects the exterior boundary of marks. If both `opacity` and
`strokeOpacity` are specified, `strokeOpacity` takes precedence for stroke encoding.
-}
strokeOpacity : List MarkChannel -> List LabelledSpec -> List LabelledSpec
strokeOpacity markProps =
    (::) ( "strokeOpacity", List.concatMap markChannelProperties markProps |> JE.object )


{-| Encode a stroke width channel.
-}
strokeWidth : List MarkChannel -> List LabelledSpec -> List LabelledSpec
strokeWidth markProps =
    (::) ( "strokeWidth", List.concatMap markChannelProperties markProps |> JE.object )


{-| A list of string data values. Used when declaring inline data with
[dataColumn](#dataColumn), filtering ([fiOneOf](#fiOneOf)), imputation
([imKeyVals](#imKeyVals)) and customised sorting ([soCustom](#soCustom)).
-}
strs : List String -> DataValues
strs =
    Strings


{-| Offset a stacked layout using a baseline at the foot of a stack.
-}
stZero : StackOffset
stZero =
    OfZero


{-| Specify a centred arrow symbol for a shape mark. Useful for vector plots.
-}
symArrow : Symbol
symArrow =
    SymArrow


{-| Specify a circular symbol for a shape mark.
-}
symCircle : Symbol
symCircle =
    SymCircle


{-| Specify a cross symbol for a shape mark.
-}
symCross : Symbol
symCross =
    SymCross


{-| Specify a diamond symbol for a shape mark.
-}
symDiamond : Symbol
symDiamond =
    SymDiamond


{-| Expression that evaluates to some symbol such as "diamond", "cross" or "circle".
-}
symExpr : String -> Symbol
symExpr =
    SymExpr


{-| A custom symbol shape as an
[SVG path description](https://developer.mozilla.org/en-US/docs/Web/SVG/Tutorial/Paths).
-}
symPath : String -> Symbol
symPath =
    SymPath


{-| Specify a square symbol for a shape mark.
-}
symSquare : Symbol
symSquare =
    SymSquare


{-| Specify a centred triangle symbol for a shape mark. Useful for vector plots.
-}
symTriangle : Symbol
symTriangle =
    SymTriangle


{-| Specify a downward triangular symbol for a shape mark.
-}
symTriangleDown : Symbol
symTriangleDown =
    SymTriangleDown


{-| Specify a leftward facing triangular symbol for a shape mark.
-}
symTriangleLeft : Symbol
symTriangleLeft =
    SymTriangleLeft


{-| Specify a rightward facing triangular symbol for a shape mark.
-}
symTriangleRight : Symbol
symTriangleRight =
    SymTriangleRight


{-| Specify a linear symbol for a shape mark. Note that this will only be visible
if the symbol has a stroke setting (unlike all the other areal symbols filling it
has no effect).
-}
symStroke : Symbol
symStroke =
    SymStroke


{-| Specify an upward triangular symbol for a shape mark.
-}
symTriangleUp : Symbol
symTriangleUp =
    SymTriangleUp


{-| Specify a centred wedge (thin triangle) symbol for a shape mark. Useful for
vector plots.
-}
symWedge : Symbol
symWedge =
    SymWedge


{-| Compute some aggregate summary statistics for a field to be encoded with a
text channel. The type of aggregation is determined by the given operation
parameter.
-}
tAggregate : Operation -> TextChannel
tAggregate =
    TAggregate


{-| Align to centre of tick band.
-}
tbCenter : TickBand
tbCenter =
    TBCenter


{-| Specify a tick band alignment with an expression that should evaluate to "center"
or "extent".
-}
tbExpr : String -> TickBand
tbExpr =
    TBExpr


{-| Align to extent (edges) of tick band.
-}
tbExtent : TickBand
tbExtent =
    TBExtent


{-| Discretize numeric values into bins when encoding with a text channel.
-}
tBin : List BinProperty -> TextChannel
tBin =
    TBin


{-| Indicate that data encoded with a text channel are already binned.
-}
tBinned : TextChannel
tBinned =
    TBinned


{-| Make a text channel encoding conditional on a predicate expression. A predicate
might be the result of evaluating a parameter ([prParam](#prParam)) or an expression
([prTest](#prTest)). The first parameter is the predicate that evaluates to true
or false; the second the encoding if true, the third the encoding if false.
-}
tCondition : Predicate -> List TextChannel -> List TextChannel -> TextChannel
tCondition =
    TCondition


{-| Make an text channel conditional on a sequence of predicate values. This can
be used when several predicates need to be tested in sequence each with their own
encoding outcomes ('if-else').
-}
tConditions : List ( Predicate, List TextChannel ) -> List TextChannel -> TextChannel
tConditions =
    TConditions


{-| Deprecated in favour of [tCondition](#tCondition). Instead of

    tDataCondition [ ( expr "datum.Origin == 'Europe'", [ tStr "EU" ] ) ] [ tStr "" ]

use

    tCondition (prTest (expr "datum.Origin == 'Europe'")) [ tStr "EU" ] [ tStr "" ]

-}
tDataCondition : List ( BooleanOp, List TextChannel ) -> List TextChannel -> TextChannel
tDataCondition =
    TDataCondition False


{-| Name of a literal data item used for encoding with a text channel. Unlike
[tStr](#tStr) datum literals represent values in data space.
-}
tDatum : DataValue -> TextChannel
tDatum =
    TDatum


{-| Expression that evaluates to a text direction "ltr" (left-to-right) or
'rtl' (right-to-left) .
-}
tdExpr : String -> TextDirection
tdExpr =
    TDExpr


{-| Indicate a left-to-right text direction.
-}
tdLeftToRight : TextDirection
tdLeftToRight =
    LeftToRight


{-| Indicate a right-to-left text direction.
-}
tdRightToLeft : TextDirection
tdRightToLeft =
    RightToLeft


{-| Encode a text channel. The first parameter is a list of text encoding options
such as the data to encode, number formatting etc.

    enc =
        encoding
            << text [ tName "keyword", tNominal ]

-}
text : List TextChannel -> List LabelledSpec -> List LabelledSpec
text tDefs =
    (::) ( "text", List.concatMap textChannelProperties tDefs |> JE.object )


{-| [Text mark](https://vega.github.io/vega-lite/docs/text.html) to be
displayed at some point location.
-}
textMark : List MarkProperty -> ( VLProperty, Spec )
textMark =
    mark Text


{-| Specify a title anchor position relative to the full bounding box.
-}
tfBounds : TitleFrame
tfBounds =
    FrBounds


{-| Specify a title anchor position as an expression that should evaluate to one
of "bounds" or "frame".
-}
tfExpr : String -> TitleFrame
tfExpr =
    FrExpr


{-| Specify a title anchor position relative to the group width / height.
-}
tfGroup : TitleFrame
tfGroup =
    FrGroup


{-| [Formatting pattern](https://vega.github.io/vega-lite/docs/format.html)
for text marks. To distinguish between formatting as numeric values and data/time
values, additionally use [tFormatAsNum](#tFormatAsNum), [tFormatAsTemporal](#tFormatAsTemporal)
or [tFormatAsCustom](#tFormatAsCustom).
-}
tFormat : String -> TextChannel
tFormat =
    TFormat


{-| Indicate that values encoded with a text channel should be formatted with a
registered custom formatter with the given name. See
[how to register a Vega-Lite custom formatter](https://vega.github.io/vega-lite/usage/compile.html#format-type).
-}
tFormatAsCustom : String -> TextChannel
tFormatAsCustom =
    TFormatAsCustom


{-| Indicate that values encoded with a text channel should be formatted as numbers.
To control the precise numeric format, additionally use [tFormat](#tFormat) providing
a [d3 numeric format string](https://github.com/d3/d3-format#locale_format).
-}
tFormatAsNum : TextChannel
tFormatAsNum =
    TFormatAsNum


{-| Indicate that values encoded with a text channel should be formatted as dates/times.
To control the precise temporal format, additionally use [tFormat](#tFormat) providing
a [d3 date/time format string](https://github.com/d3/d3-time-format#locale_format).
-}
tFormatAsTemporal : TextChannel
tFormatAsTemporal =
    TFormatAsTemporal


{-| Indicate a data field encoded as a text property is a geo feature. Equivalent
to `tMType GeoFeature`.
-}
tGeo : TextChannel
tGeo =
    TmType GeoFeature


{-| Anchor position when placing a title.
-}
tiAnchor : Anchor -> TitleProperty
tiAnchor =
    TAnchor


{-| Angle of title text (degrees from horizontal).
-}
tiAngle : Float -> TitleProperty
tiAngle n =
    TAngle (Num (positiveAngle n))


{-| Vertical alignment of a title.
-}
tiBaseline : VAlign -> TitleProperty
tiBaseline =
    TBaseline


{-| Text colour of a title.
-}
tiColor : String -> TitleProperty
tiColor s =
    TColor (Str s)


{-| Delta offset of title and subtitle x-position.
-}
tiDx : Float -> TitleProperty
tiDx n =
    TDx (Num n)


{-| Delta offset of title and subtitle y-position.
-}
tiDy : Float -> TitleProperty
tiDy n =
    TDy (Num n)


{-| Title font.
-}
tiFont : String -> TitleProperty
tiFont s =
    TFont (Str s)


{-| Title font size.
-}
tiFontSize : Float -> TitleProperty
tiFontSize n =
    TFontSize (Num n)


{-| Title font style (italic etc.).
-}
tiFontStyle : String -> TitleProperty
tiFontStyle s =
    TFontStyle (Str s)


{-| Title font weight.
-}
tiFontWeight : FontWeight -> TitleProperty
tiFontWeight =
    TFontWeight


{-| Title position anchor. Can be relative to the full bounding box
([frBounds](#frBounds)) or the group in which the titled visualization belongs
([frGroup](#frGroup)).
-}
tiFrame : TitleFrame -> TitleProperty
tiFrame =
    TFrame


{-| Maximum length of the title display in pixel units.
-}
tiLimit : Float -> TitleProperty
tiLimit n =
    TLimit (Num n)


{-| Line height (vertical spacing) for title text.
-}
tiLineHeight : Float -> TitleProperty
tiLineHeight n =
    TLineHeight (Num n)


{-| Offset in pixel units of the title relative to the chart body.
-}
tiOffset : Float -> TitleProperty
tiOffset n =
    TOffset (Num n)


{-| Placement of title relative to the chart body.
-}
tiOrient : Side -> TitleProperty
tiOrient =
    TOrient


{-| A list of named styles to apply to title. A named style can be specified via
[coMarkStyles](#coMarkStyles) if more than one style is required. Later styles
in the list will override earlier styles if there is a conflict in any of the mark
properties specified.

While this is provided for compatibility with Vega-Lite style specification, for
greater type safety in elm-vegalite, instead create functions that generate
[TitleProperties](#TitleProperty).

-}
tiStyle : List String -> TitleProperty
tiStyle =
    TStyle


{-| Subtitle text, placed beneath the primary title. For multi-line subtitles,
insert `\n` at each line break or use a `"""` multi-line string.
-}
tiSubtitle : String -> TitleProperty
tiSubtitle s =
    TSubtitle (Str s)


{-| Color of a subtitle.
-}
tiSubtitleColor : String -> TitleProperty
tiSubtitleColor s =
    TSubtitleColor (Str s)


{-| Font name of a subtitle.
-}
tiSubtitleFont : String -> TitleProperty
tiSubtitleFont s =
    TSubtitleFont (Str s)


{-| Font size of a subtitle.
-}
tiSubtitleFontSize : Float -> TitleProperty
tiSubtitleFontSize n =
    TSubtitleFontSize (Num n)


{-| Font style of a subtitle such as `"normal"` or `"italic"`.
-}
tiSubtitleFontStyle : String -> TitleProperty
tiSubtitleFontStyle s =
    TSubtitleFontStyle (Str s)


{-| Font weight of a subtitle.
-}
tiSubtitleFontWeight : FontWeight -> TitleProperty
tiSubtitleFontWeight =
    TSubtitleFontWeight


{-| Line height in pixels of each line of text in a multi-line subtitle.
-}
tiSubtitleLineHeight : Float -> TitleProperty
tiSubtitleLineHeight n =
    TSubtitleLineHeight (Num n)


{-| Padding in pixels between title and subtitle text.
-}
tiSubtitlePadding : Float -> TitleProperty
tiSubtitlePadding n =
    TSubtitlePadding (Num n)


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to a
title property function requiring a numeric value. This can be used for interactive
parameterisation when an expression is bound to an input element. For example,

    ps =
        params
            << param "fs"
                [ paValue (num 0)
                , paBind (ipRange [ inMax 32 ])
                ]

    ttl =
        title "My title" [ tiNumExpr "fs" tiFontSize ]

-}
tiNumExpr : String -> (number -> TitleProperty) -> TitleProperty
tiNumExpr ex fn =
    case fn 0 of
        TAngle _ ->
            TAngle (NumExpr ex)

        TDx _ ->
            TDx (NumExpr ex)

        TDy _ ->
            TDy (NumExpr ex)

        TFontSize _ ->
            TFontSize (NumExpr ex)

        TLineHeight _ ->
            TLineHeight (NumExpr ex)

        TLimit _ ->
            TLimit (NumExpr ex)

        TOffset _ ->
            TOffset (NumExpr ex)

        TSubtitleFontSize _ ->
            TSubtitleFontSize (NumExpr ex)

        TSubtitleLineHeight _ ->
            TSubtitleLineHeight (NumExpr ex)

        TSubtitlePadding _ ->
            TSubtitlePadding (NumExpr ex)

        TZIndex _ ->
            TZIndex (NumExpr ex)

        _ ->
            fn 0


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to
a title property function requiring a string value. This can be used to provide an
interactive parameterisation of a title property when an expression is bound to an
input element. For example,

    ps =
        params
            << params "clr"
                [ paValue (str "black")
                , paBind (ipColor [])
                ]

    ttl =
        title "My title" [ tiStrExpr "clr" tiColor ]

-}
tiStrExpr : String -> (String -> TitleProperty) -> TitleProperty
tiStrExpr ex fn =
    case fn "" of
        TColor _ ->
            TColor (StrExpr ex)

        TFont _ ->
            TFont (StrExpr ex)

        TFontStyle _ ->
            TFontStyle (StrExpr ex)

        TSubtitle _ ->
            TSubtitle (StrExpr ex)

        TSubtitleColor _ ->
            TSubtitleColor (StrExpr ex)

        TSubtitleFont _ ->
            TSubtitleFont (StrExpr ex)

        TSubtitleFontStyle _ ->
            TSubtitleFontStyle (StrExpr ex)

        _ ->
            fn ""


{-| Drawing order of a title relative to the other chart elements. 1 indicates
title is drawn in front of chart marks, 0 indicates it is drawn behind them.
-}
tiZIndex : Int -> TitleProperty
tiZIndex n =
    TZIndex (Num (toFloat n))


{-| Short line ([tick](https://vega.github.io/vega-lite/docs/tick.html))
mark for symbolising point locations.
-}
tick : List MarkProperty -> ( VLProperty, Spec )
tick =
    mark Tick


{-| Default anchor position when placing titles.
-}
ticoAnchor : Anchor -> TitleConfig
ticoAnchor =
    TAnchor


{-| Default angle when orientating titles (degrees from horizontal).
-}
ticoAngle : Float -> TitleConfig
ticoAngle n =
    TAngle (Num (positiveAngle n))


{-| Default vertical alignment when placing titles.
-}
ticoBaseline : VAlign -> TitleConfig
ticoBaseline =
    TBaseline


{-| Default color when showing titles.
-}
ticoColor : String -> TitleConfig
ticoColor s =
    TColor (Str s)


{-| Default delta offset of title and subtitle x-position.
-}
ticoDx : Float -> TitleProperty
ticoDx n =
    TDx (Num n)


{-| Default delta offset of title and subtitle y-position.
-}
ticoDy : Float -> TitleProperty
ticoDy n =
    TDy (Num n)


{-| Default font when showing titles.
-}
ticoFont : String -> TitleConfig
ticoFont s =
    TFont (Str s)


{-| Default font size when showing titles.
-}
ticoFontSize : Float -> TitleConfig
ticoFontSize n =
    TFontSize (Num n)


{-| Default font style (italic etc.) when showing titles.
-}
ticoFontStyle : String -> TitleConfig
ticoFontStyle s =
    TFontStyle (Str s)


{-| Default font weight when showing titles.
-}
ticoFontWeight : FontWeight -> TitleConfig
ticoFontWeight =
    TFontWeight


{-| Title position anchor. Can be relative to the full bounding box
([frBounds](#frBounds)) or the group in which the titled visualization belongs
([frGroup](#frGroup)).
-}
ticoFrame : TitleFrame -> TitleConfig
ticoFrame =
    TFrame


{-| Default maximum length in pixel units when showing titles.
-}
ticoLimit : Float -> TitleConfig
ticoLimit n =
    TLimit (Num n)


{-| Line height (vertical spacing) for title text.
-}
ticoLineHeight : Float -> TitleConfig
ticoLineHeight n =
    TLineHeight (Num n)


{-| Default offset in pixel units of titles relative to the chart body.
-}
ticoOffset : Float -> TitleConfig
ticoOffset n =
    TOffset (Num n)


{-| Default placement of titles relative to the chart body.
-}
ticoOrient : Side -> TitleConfig
ticoOrient =
    TOrient


{-| A list of named styles to apply to titles. A named style can be specified via
[coMarkStyles](#coMarkStyles) if more than one style is required. Later styles
in the list will override earlier styles if there is a conflict in any of the
mark properties specified.
-}
ticoStyle : List String -> TitleConfig
ticoStyle =
    TStyle


{-| Default color of a subtitle.
-}
ticoSubtitleColor : String -> TitleProperty
ticoSubtitleColor s =
    TSubtitleColor (Str s)


{-| Default font name of a subtitle.
-}
ticoSubtitleFont : String -> TitleProperty
ticoSubtitleFont s =
    TSubtitleFont (Str s)


{-| Default font size of a subtitle.
-}
ticoSubtitleFontSize : Float -> TitleProperty
ticoSubtitleFontSize n =
    TSubtitleFontSize (Num n)


{-| Default ont style of a subtitle such as `"normal"` or `"italic"`.
-}
ticoSubtitleFontStyle : String -> TitleProperty
ticoSubtitleFontStyle s =
    TSubtitleFontStyle (Str s)


{-| Default font weight of a subtitle.
-}
ticoSubtitleFontWeight : FontWeight -> TitleProperty
ticoSubtitleFontWeight =
    TSubtitleFontWeight


{-| Default line height in pixels of each line of text in a subtitle.
-}
ticoSubtitleLineHeight : Float -> TitleProperty
ticoSubtitleLineHeight n =
    TSubtitleLineHeight (Num n)


{-| Default padding in pixels between title and subtitle text.
-}
ticoSubtitlePadding : Float -> TitleProperty
ticoSubtitlePadding n =
    TSubtitlePadding (Num n)


{-| Default drawing order of titles relative to the other chart elements. 1 indicates
titles are drawn in front of chart marks, 0 indicates they are drawn behind them.
-}
ticoZIndex : Int -> TitleConfig
ticoZIndex n =
    TZIndex (Num (toFloat n))


{-| Create a new data field based on the given temporal binning. Unlike the
direct encoding binning, this transformation is named and so can be referred
to in multiple encodings. The first parameter is the width of each temporal bin,
the second is the field to bin and the third is name to give the newly binned
field.
-}
timeUnitAs : TimeUnit -> String -> String -> List LabelledSpec -> List LabelledSpec
timeUnitAs tu field label =
    (::)
        ( "multiSpecs"
        , JE.object
            [ ( "timeUnit", timeUnitSpec tu )
            , ( "field", JE.string field )
            , ( "as", JE.string label )
            ]
        )


{-| Title to be displayed for a plot. The first parameter is the text of the title,
the second a list of any title properties to configure its appearance. To display
a title over more than one line, insert `\n` at each line break or use a `"""`
multi-line string.

    title "First line\nSecond line" []

or

    title """First line
    Second line""" []

-}
title : String -> List TitleProperty -> ( VLProperty, Spec )
title txt tps =
    ( VLTitle
    , JE.object (( "text", multilineTextSpec txt ) :: List.concatMap titleConfigProperty tps)
    )


{-| Expression that evaluates to a title. Similar to [title](#title) except the
content of the title is the evaluated expression (first paramter). For example:

    let
        ps =
            params << param "ttl" [ paValue (num (2 * pi)) ]
    in
    toVegaLite [ titleExpr "ttl" [] ]

-}
titleExpr : String -> List TitleProperty -> ( VLProperty, Spec )
titleExpr s tps =
    ( VLTitle
    , JE.object (( "text", JE.object [ ( "expr", JE.string s ) ] ) :: List.concatMap titleConfigProperty tps)
    )


{-| Level of measurement when encoding with a text channel. See also [tNominal](#tNominal),
[tOrdinal](#tOrdinal), [tQuant](#tQuant), [tTemporal](#tTemporal) and [tGeo](#tGeo)
for shorthand equivalents.
-}
tMType : Measurement -> TextChannel
tMType =
    TmType


{-| Name of field used for encoding with a text channel.
-}
tName : String -> TextChannel
tName =
    TName


{-| Indicate a data field encoded as a text property is nominal. Equivalent to
`tMType Nominal`. This is the default data type.
-}
tNominal : TextChannel
tNominal =
    TmType Nominal


{-| Indicate a data field encoded as a text property is ordinal. Equivalent to
`tMType Ordinal`.
-}
tOrdinal : TextChannel
tOrdinal =
    TmType Ordinal


{-| Reference in a text channel to a field name generated by [repeatFlow](#repeatFlow)
or [repeat](#repeat). The parameter identifies whether reference is being made to
fields that are to be arranged in columns, in rows or a with a flow layout.
-}
tRepeat : Arrangement -> TextChannel
tRepeat =
    TRepeat


{-| Encode a tooltip channel using a single data field.

     tooltip [ tName "Month", tTemporal, tFormat "%B %Y" ]

To encode multiple tooltip values with a mark, use [tooltips](#tooltips).

-}
tooltip : List TextChannel -> List LabelledSpec -> List LabelledSpec
tooltip tDefs =
    (::) ( "tooltip", JE.object (List.concatMap textChannelProperties tDefs) )


{-| Encode a tooltip channel using multiple data fields. The first parameter is a
list of the multiple tooltips, each of which is a list of text channel properties
that define the channel.

    tooltips
        [ [ tName "month", tTemporal, tFormat "%B %Y" ]
        , [ tName "temperature", tQuant ]
        ]

-}
tooltips : List (List TextChannel) -> List LabelledSpec -> List LabelledSpec
tooltips tDefss =
    (::) ( "tooltip", JE.list (\tDefs -> JE.object (List.concatMap textChannelProperties tDefs)) tDefss )


{-| A topoJSON feature format containing an object with the given name. The name
of the object can be found by inspecting the topoJSON file and searching for the
value associated with the `objects` key.

    geodata =
        dataFromUrl "city.json" [ topojsonFeature "boroughs" ]

-}
topojsonFeature : String -> Format
topojsonFeature =
    TopojsonFeature


{-| A topoJSON mesh format containing an object with the given name. Unlike
`topojsonFeature`, the corresponding geo data are returned as a single unified mesh,
not as individual GeoJSON features.
-}
topojsonMesh : String -> Format
topojsonMesh =
    TopojsonMesh


{-| Convert a list of Vega-Lite specifications into a single JSON object that may be
passed to Vega-Lite for graphics generation. Commonly these will include at least
data, mark and encoding specifications.

While simple functions like `bar` may be provided directly, it is usually clearer
to label more complex functions such as encodings with separate expressions.

Specifications can be built up by chaining functions such as [dataColumn](#dataColumn)
or [position](#position). Functional composition using the `<<` operator allows
this to be done compactly:

    let
        data =
            dataFromColumns []
                << dataColumn "a" (strs [ "C", "C", "D", "E" ])
                << dataColumn "b" (nums [ 2, 7, 1, 2 ])

        enc =
            encoding
                << position X [ pName "a", pNominal ]
                << position Y [ pName "b", pQuant, pAggregate opMean ]
    in
    toVegaLite [ data [], enc [], bar [] ]

-}
toVegaLite : List ( VLProperty, Spec ) -> Spec
toVegaLite spec =
    ( "$schema", JE.string "https://vega.github.io/schema/vega-lite/v5.json" )
        :: List.map (\( s, v ) -> ( vlPropertyLabel s, v )) spec
        |> JE.object


{-| Specify that data values in a selection are toggled when interacted with on
multiple occasions while the alt key is held down.
-}
tpAltKey : TogglePredicate
tpAltKey =
    TpAltKey


{-| Specify that data values in a selection are toggled when interacted with on
multiple occasions while the control key is held down.
-}
tpCtrlKey : TogglePredicate
tpCtrlKey =
    TpCtrlKey


{-| Specify that repeated selections are toggled when the given
[expression](https://vega.github.io/vega/docs/expressions/) evaluates to true.
This allows, for example, multiple key modifiers to generate toggling:

    ps =
        params
            << param "paint"
                [ paSelect sePoint
                    [ seOn "mouseover"
                    , seToggle (tpExpr "event.shiftKey && event.ctrlKey")
                    ]
                ]

-}
tpExpr : String -> TogglePredicate
tpExpr =
    TpExpr


{-| Specify that data values in a selection are never unselected when interacted
with on multiple occasions. This allows a single selected item to be guaranteed.
-}
tpFalse : TogglePredicate
tpFalse =
    TpFalse


{-| Specify that data values in a selection are toggled when interacted with on
multiple occasions while the shift key is held down. This is the default behaviour
so should only be needed if moving back from some other specified behavior.
-}
tpShiftKey : TogglePredicate
tpShiftKey =
    TpShiftKey


{-| [Trail mark](https://vega.github.io/vega-lite/docs/trail.html) (line
with variable width along its length).
-}
trail : List MarkProperty -> ( VLProperty, Spec )
trail =
    mark Trail


{-| Create a single transform from a list of transformation specifications. The
order of transformations can be important, e.g. labels created with [calculateAs](#calculateAs),
[timeUnitAs](#timeUnitAs) and [binAs](#binAs) that are used in other transformations.
Using the functional composition pipeline idiom (as example below) allows you to
provide the transformations in the order intended in a clear manner.

    trans =
        transform
            << filter (fiExpr "datum.year == 2010")
            << calculateAs "datum.sex == 2 ? 'Female' : 'Male'" "gender"

-}
transform : List LabelledSpec -> ( VLProperty, Spec )
transform transforms =
    let
        assemble ( trName, val ) =
            case trName of
                "multiSpecs" ->
                    val

                _ ->
                    JE.object [ ( trName, val ) ]
    in
    if List.isEmpty transforms then
        ( VLTransform, JE.null )

    else
        ( VLTransform, JE.list assemble transforms )


{-| A transverse Mercator map projection.
-}
transverseMercator : Projection
transverseMercator =
    TransverseMercator


{-| A true value used for functions that can accept a Boolean literal or a reference
to something that generates a Boolean value. Convenience function equivalent to `boo True`
-}
true : DataValue
true =
    Boolean True


{-| Deprecated in favour of [tCondition](#tCondition). Instead of

    tSelectionCondition (selectionName "mySelection") [ tName "label" ] [ tStr "" ]

use

    tCondition (prParam "mySelection") [ tName "label" ] [ tStr "" ]

-}
tSelectionCondition : BooleanOp -> List TextChannel -> List TextChannel -> TextChannel
tSelectionCondition bo tTcs =
    TDataCondition True [ ( bo, tTcs ) ]


{-| Literal string value when encoding with a text channel. Can be useful for
quick text annotation. For multi-line text, insert `\n` at each line break or use
a `"""` multi-line string.

    encoding
        << position X [ pNum 300 ]
        << position Y [ pNum 300 ]
        << text [ tStr "Upper limit\nof range" ]

-}
tStr : String -> TextChannel
tStr =
    TString


{-| TSV data file format (only necessary if the file extension does not indicate the
type).
-}
tsv : Format
tsv =
    TSV


{-| Indicate tooltips are generated by all fields in the underlying data.

    circle [ maTooltip ttData ]

-}
ttData : TooltipContent
ttData =
    TTData



-- {- | Expression that evaluates to some tooltip property. For example an expression
-- bound to a checkbox can allow tooltips to be turned on or off.
-- -}
-- ttExpr : String -> TooltipContent
-- ttExpr =
--     TTExpr


{-| Indicate a data field encoded as a text property is temporal. Equivalent to
`tMType Temporal`.
-}
tTemporal : TextChannel
tTemporal =
    TmType Temporal


{-| Indicate tooltips should be enabled using the encoded data of the mark.

    circle [ maTooltip ttEncoding ]

-}
ttEncoding : TooltipContent
ttEncoding =
    TTEncoding


{-| Time unit aggregation of field values when encoding with a text channel.
-}
tTimeUnit : TimeUnit -> TextChannel
tTimeUnit =
    TTimeUnit


{-| Title of a field when encoding with a text or tooltip channel. For multi-line
titles, insert `\n` at each line break or use a `"""` multi-line string.
-}
tTitle : String -> TextChannel
tTitle =
    TTitle


{-| Indicate that tooltips should be disabled for the mark (default).

    circle [ maTooltip ttNone ]

-}
ttNone : TooltipContent
ttNone =
    TTNone


{-| Indicate a data field encoded as a text property is quantitative. Equivalent to
`tMType Quantitative`.
-}
tQuant : TextChannel
tQuant =
    TmType Quantitative


{-| Specify the maximum number of bins used when discretizing time units. Can be
useful as an alternative to explicitly providing a time unit to bin by as it will
be inferred from the temporal domain extent and the number of bins. For example,
when applied to a dataset of hourly readings for a full year, the following will
bin into days:

    tuMaxBins 366

-}
tuMaxBins : Int -> TimeUnit
tuMaxBins =
    TUMaxBins


{-| Specify the the number of steps between time unit bins, in terms of the least
significant unit provided. For example, the following will bin temporal data into
biweekly weekly groups:

    tuStep 14 yearMonthDate

-}
tuStep : Float -> TimeUnit -> TimeUnit
tuStep =
    TUStep


{-| Encode a url channel. The first parameter is a list of url channel
properties that characterise the hyperlink to encode with. This is used for
specifying data-driven image files for the [image](#image) mark.

    encData =
        encoding
            << url [ hName "url", hNominal ]

    encLiteral =
        encoding
            << url [ hStr "http://www.imdb.com" ]

-}
url : List HyperlinkChannel -> List LabelledSpec -> List LabelledSpec
url hyperProps =
    (::) ( "url", List.concatMap hyperlinkChannelProperties hyperProps |> JE.object )


{-| UTC version of a given a time (coordinated universal time, independent of local
time zones or daylight saving). To encode a time as UTC (coordinated universal time,
independent of local time zones or daylight saving), just use this function to convert
another `TimeUnit` generating function.

    encoding
        << position X
            [ pName "date"
            , pTemporal
            , pTimeUnit (utc yearMonthDateHours)
            ]

-}
utc : TimeUnit -> TimeUnit
utc tu =
    Utc tu


{-| Vertically align text marks by their baseline (e.g. bottom of an 'x').
-}
vaAlphabetic : VAlign
vaAlphabetic =
    VAlignAlphabetic


{-| Vertically align text marks by the bottom of descenders (e.g. bottom of a 'g').
-}
vaBottom : VAlign
vaBottom =
    VAlignBottom


{-| Expression that evaluates to some vertical text alignment such as "top", "bottom"
or "alphabetic".
-}
vaExpr : String -> VAlign
vaExpr =
    VAlignExpr


{-| Vertically align text marks by the bottom of the space defined by line height
([maLineHeight](#maLineHeight), [tiLineHeight](#tiLineHeight) etc.).
-}
vaLineBottom : VAlign
vaLineBottom =
    VAlignLineBottom


{-| Vertically align text marks by the top of the space defined by line height
([maLineHeight](#maLineHeight), [tiLineHeight](#tiLineHeight) etc.).
-}
vaLineTop : VAlign
vaLineTop =
    VAlignLineTop


{-| Vertically align text marks by their middle (e.g. middle of an 'x').
-}
vaMiddle : VAlign
vaMiddle =
    VAlignMiddle


{-| Vertically align text marks by the top of ascenders (e.g. top of an 'A').
-}
vaTop : VAlign
vaTop =
    VAlignTop


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to a
view background function requiring a numeric value. This can be used for interactive
parameterisation when an expression is bound to an input element. For example,

    ps =
        params
            << param "r"
                [ paValue (num 0)
                , paBind (ipRange [ inMax 20 ])
                ]

    bg =
        viewBackground [ vbNumExpr "r" viewCornerRadius ]

-}
vbNumExpr : String -> (number -> ViewBackground) -> ViewBackground
vbNumExpr ex fn =
    case fn 0 of
        VBCornerRadius _ ->
            VBCornerRadius (NumExpr ex)

        VBFillOpacity _ ->
            VBFillOpacity (NumExpr ex)

        VBOpacity _ ->
            VBOpacity (NumExpr ex)

        VBStrokeOpacity _ ->
            VBStrokeOpacity (NumExpr ex)

        VBStrokeWidth _ ->
            VBStrokeWidth (NumExpr ex)

        VBStrokeDashOffset _ ->
            VBStrokeDashOffset (NumExpr ex)

        VBStrokeMiterLimit _ ->
            VBStrokeMiterLimit (NumExpr ex)

        _ ->
            fn 0


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to
a a view background function requiring a list of numbers (for dash styles). This can
be used to provide an interactive parameterisation of a view background dash property
when an expression is bound to an input element. For example,

    ps =
        params
            << param "dashStyle"
                [ paValue (nums [ 2, 2 ])
                , paBind (ipSelect [ inDataOptions [ nums [ 2, 2 ], nums [ 8, 8 ] ] ])
                ]

    bg =
        viewBackground [ vbNumsExpr "dashStyle" viewStrokeDash ]

-}
vbNumsExpr : String -> (List number -> ViewBackground) -> ViewBackground
vbNumsExpr ex fn =
    case fn [] of
        VBStrokeDash _ ->
            VBStrokeDash (NumsExpr ex)

        _ ->
            fn []


{-| Provide an [expression](https://vega.github.io/vega/docs/expressions/) to
a view background function requiring a `Maybe String` value. This can be used to
provide an interactive parameterisation of a view background when an expression
is bound to an input element. For example,

    ps =
        params
            << param "clr"
                [ paValue (str "white")
                , paBind (ipColor [])
                ]

    bg =
        viewBackground [ vbStrExpr "clr" viewFill ]

-}
vbStrExpr : String -> (Maybe String -> ViewBackground) -> ViewBackground
vbStrExpr ex fn =
    case fn Nothing of
        VBFill _ ->
            VBFill (StrExpr ex)

        VBStroke _ ->
            VBStroke (StrExpr ex)

        _ ->
            fn Nothing


{-| Juxtapose some specifications vertically in a row layout of views.
-}
vConcat : List Spec -> ( VLProperty, Spec )
vConcat specs =
    ( VLVConcat, toList specs )


{-| Whether or not by default single views should be clipped.
-}
vicoClip : Bool -> ViewConfig
vicoClip =
    VClip


{-| Default height of single views when the plot has continuous y-field.
-}
vicoContinuousHeight : Float -> ViewConfig
vicoContinuousHeight =
    VContinuousHeight


{-| Default width of single views when the plot has continuous x-field.
-}
vicoContinuousWidth : Float -> ViewConfig
vicoContinuousWidth =
    VContinuousWidth


{-| The radius in pixels of rounded rectangle corners.
-}
vicoCornerRadius : Float -> ViewConfig
vicoCornerRadius =
    VCornerRadius


{-| Default cursor for single views.
-}
vicoCursor : Cursor -> ViewConfig
vicoCursor =
    VCursor


{-| Default height of single views when the plot has discrete y-field.
-}
vicoDiscreteHeight : Float -> ViewConfig
vicoDiscreteHeight =
    VDiscreteHeight


{-| Default width of single views when the plot has discrete x-field.
-}
vicoDiscreteWidth : Float -> ViewConfig
vicoDiscreteWidth =
    VDiscreteWidth


{-| Default fill color for single views.
-}
vicoFill : Maybe String -> ViewConfig
vicoFill =
    VFill


{-| Default fill opacity for single views.
-}
vicoFillOpacity : Float -> ViewConfig
vicoFillOpacity =
    VFillOpacity


{-| Default overall opacity for single views.
-}
vicoOpacity : Float -> ViewConfig
vicoOpacity =
    VOpacity


{-| Default step size for x/y discrete fields.
-}
vicoStep : Float -> ViewConfig
vicoStep =
    VStep


{-| Default stroke color for single views. If `Nothing` is provided,
no strokes are drawn around the view.
-}
vicoStroke : Maybe String -> ViewConfig
vicoStroke =
    VStroke


{-| Default stroke cap line-ending style for single views.
-}
vicoStrokeCap : StrokeCap -> ViewConfig
vicoStrokeCap =
    VStrokeCap


{-| Default stroke dash style for single views.
-}
vicoStrokeDash : List Float -> ViewConfig
vicoStrokeDash =
    VStrokeDash


{-| Default stroke dash offset for single views.
-}
vicoStrokeDashOffset : Float -> ViewConfig
vicoStrokeDashOffset =
    VStrokeDashOffset


{-| Default stroke line-joining style for single views.
-}
vicoStrokeJoin : StrokeJoin -> ViewConfig
vicoStrokeJoin =
    VStrokeJoin


{-| Default stroke mitre limit at which to bevel a line join in single views.
-}
vicoStrokeMiterLimit : Float -> ViewConfig
vicoStrokeMiterLimit =
    VStrokeMiterLimit


{-| Default stroke opacity for single views.
-}
vicoStrokeOpacity : Float -> ViewConfig
vicoStrokeOpacity =
    VStrokeOpacity


{-| Default stroke width of single views.
-}
vicoStrokeWidth : Float -> ViewConfig
vicoStrokeWidth =
    VStrokeWidth


{-| Configure the default single view style.
-}
vicoBackground : List ViewBackground -> ViewConfig
vicoBackground =
    VBackground


{-| The background style of a single view or layer in a view composition.
-}
viewBackground : List ViewBackground -> ( VLProperty, Spec )
viewBackground vbs =
    ( VLViewBackground, JE.object (List.concatMap viewBackgroundProperty vbs) )


{-| The radius in pixels of rounded corners in single view or layer background.
-}
viewCornerRadius : Float -> ViewBackground
viewCornerRadius n =
    VBCornerRadius (Num n)


{-| Fill color for a single view or layer background.
-}
viewFill : Maybe String -> ViewBackground
viewFill ms =
    case ms of
        Just s ->
            VBFill (Str s)

        Nothing ->
            VBFill NoStr


{-| Fill opacity for a single view or layer background.
-}
viewFillOpacity : Float -> ViewBackground
viewFillOpacity n =
    VBFillOpacity (Num n)


{-| Overall opacity for a single view or layer background.
-}
viewOpacity : Float -> ViewBackground
viewOpacity n =
    VBOpacity (Num n)


{-| Stroke color for line around a single view or layer background. If `Nothing`
is provided, no strokes are drawn around the view.
-}
viewStroke : Maybe String -> ViewBackground
viewStroke ms =
    case ms of
        Just s ->
            VBStroke (Str s)

        Nothing ->
            VBStroke NoStr


{-| Stroke cap line-ending around a single view or layer background.
-}
viewStrokeCap : StrokeCap -> ViewBackground
viewStrokeCap =
    VBStrokeCap


{-| Stroke dash style for a line around a single view or layer background.
-}
viewStrokeDash : List Float -> ViewBackground
viewStrokeDash ns =
    VBStrokeDash (Nums ns)


{-| Stroke dash offset for line around a single view or layer background.
-}
viewStrokeDashOffset : Float -> ViewBackground
viewStrokeDashOffset n =
    VBStrokeDashOffset (Num n)


{-| Stroke line-joining style around a single view or layer background.
-}
viewStrokeJoin : StrokeJoin -> ViewBackground
viewStrokeJoin =
    VBStrokeJoin


{-| Stroke mitre limit at which to bevel a line join around a single view or
layer background.
-}
viewStrokeMiterLimit : Float -> ViewBackground
viewStrokeMiterLimit n =
    VBStrokeMiterLimit (Num n)


{-| Stroke opacity around a single view or layer background.
-}
viewStrokeOpacity : Float -> ViewBackground
viewStrokeOpacity n =
    VBStrokeOpacity (Num n)


{-| Stroke around a single view or layer background.
-}
viewStrokeWidth : Float -> ViewBackground
viewStrokeWidth n =
    VBStrokeWidth (Num n)


{-| A list of named styles to apply to a single view background. A named style
can be specified via [coMarkStyles](#coMarkStyles) if more than one style is required.
Later styles in the list will override earlier styles if there is a conflict in
any of the mark properties specified.
-}
viewStyle : List String -> ViewBackground
viewStyle =
    VBStyle


{-| Indicate temporal binning by week of year, so a 10 year sequence would have
up to 53 bins. Weeks are Sunday-based and days before the first Sunday of the year
are considered to be in week 0, the first Sunday of the year is the start of week 1,
the second Sunday week 2, _etc._
-}
week : TimeUnit
week =
    Week


{-| Indicate temporal binning by day of week though the year, so a 10 year sequence
would have up to 53\*7 bins.
-}
weekDay : TimeUnit
weekDay =
    WeekDay


{-| Indicate temporal binning by hour of day though the year, so a 10 year sequence
would have up to 52\*7\*24 bins.
-}
weekDayHours : TimeUnit
weekDayHours =
    WeekDayHours


{-| Indicate temporal binning by minute though the year, so a 10 year sequence
would have up to 52\*7\*24\*60 bins.
-}
weekDayHoursMinutes : TimeUnit
weekDayHoursMinutes =
    WeekDayHoursMinutes


{-| Indicate temporal binning by the second though the year, so a 10 year sequence
would have up to 52\*7\*24\*60\*60 bins.
-}
weekDayHoursMinutesSeconds : TimeUnit
weekDayHoursMinutesSeconds =
    WeekDayHoursMinutesSeconds


{-| An aggregate operation to be used in a window transformation.

    transform
        << window [ ( [ wiAggregateOp opSum, wiField "Time" ], "TotalTime" ) ]
            [ wiFrame Nothing Nothing ]

-}
wiAggregateOp : Operation -> Window
wiAggregateOp =
    WAggregateOp


{-| Override the default width of the visualization in pixel units. If not
specified, the width will be calculated based on the content of the visualization.

    toVegaLite [ width 540, data [], enc [], bar [] ]

How the content is sized relative to this width specification can be customised
with [autosize](#autosize).

-}
width : Float -> ( VLProperty, Spec )
width w =
    ( VLWidth, JE.float w )


{-| Set the width of the view to be that of the surrounding container. Allows
responsive sizing to be specified.
-}
widthOfContainer : ( VLProperty, Spec )
widthOfContainer =
    ( VLWidth, JE.string "container" )


{-| Set the width of the discrete x-field (e.g. individual bars in a bar chart).
The total width is then calculated based on the number of discrete fields (e.g. bars).

    toVegaLite [ widthStep 17, data [], enc [], bar [] ]

-}
widthStep : Float -> ( VLProperty, Spec )
widthStep ws =
    ( VLWidthStep, JE.object [ ( "step", JE.float ws ) ] )


{-| Indicate that the given field should be sorted in ascending order when performing
a window transform.
-}
wiAscending : String -> SortField
wiAscending =
    WAscending


{-| Indicate that the given field should be sorted in descending order when performing
a window transform.
-}
wiDescending : String -> SortField
wiDescending =
    WDescending


{-| Field for which to compute a window operation. Not needed for
operations that do not apply to fields such as [opCount](#opCount), [woRank](#woRank)
and [woDenseRank](#woDenseRank).
-}
wiField : String -> Window
wiField =
    WField


{-| Moving window for use by a window transform. The two parameters should either
be [Just](https://package.elm-lang.org/packages/elm/core/latest/Maybe#Maybe) a number
indicating the offset from the current data object, or
[Nothing](https://package.elm-lang.org/packages/elm/core/latest/Maybe#Maybe) to
indicate unbounded rows preceding or following the current data object.
-}
wiFrame : Maybe Int -> Maybe Int -> WindowProperty
wiFrame =
    WFrame


{-| Fields for partitioning data objects in a window transform into separate windows.
If unspecified, all points will be in a single group.
-}
wiGroupBy : List String -> WindowProperty
wiGroupBy =
    WGroupBy


{-| Whether or not the sliding window frame in a window transform should ignore
peer values (those considered identical by the sort criteria).
-}
wiIgnorePeers : Bool -> WindowProperty
wiIgnorePeers =
    WIgnorePeers


{-| Window transform for performing calculations over sorted groups of
data objects such as ranking, lead/lag analysis, running sums and averages.

The first parameter is a list of tuples each comprising a window transform field
definition and an output name. The second is the window transform definition.

       trans =
           transform
               << window [ ( [ wiAggregateOp opSum, wiField "Time" ], "TotalTime" ) ]
                   [ wiFrame Nothing Nothing ]

-}
window : List ( List Window, String ) -> List WindowProperty -> List LabelledSpec -> List LabelledSpec
window wss wProps =
    let
        winFieldDef ws outName =
            JE.object (( "as", JE.string outName ) :: List.map windowFieldProperty ws)
    in
    (::)
        ( "multiSpecs"
        , JE.object
            (( "window", JE.list (\( ws, out ) -> winFieldDef ws out) wss )
                :: List.map windowProperty wProps
            )
        )


{-| Window-specific operation to be used in a window transformation.
-}
wiOp : WOperation -> Window
wiOp =
    WOp


{-| Numeric parameter for window-only operations that can be parameterised
(`woPercentile`, `woLag`, `woLead` and `woNthValue`).
-}
wiParam : Int -> Window
wiParam =
    WParam


{-| Comparator for sorting data objects within a window transform.
-}
wiSort : List SortField -> WindowProperty
wiSort =
    WSort


{-| Cumulative distribution function to be applied in a window transform.
-}
woCumeDist : WOperation
woCumeDist =
    CumeDist


{-| Dense rank function to be applied in a window transform.
-}
woDenseRank : WOperation
woDenseRank =
    DenseRank


{-| First value in a sliding window to be applied in a window transform.
-}
woFirstValue : WOperation
woFirstValue =
    FirstValue


{-| Value preceding the current object in a sliding window to be applied in a window transform.
-}
woLag : WOperation
woLag =
    Lag


{-| Last value in a sliding window to be applied in a window transform.
-}
woLastValue : WOperation
woLastValue =
    LastValue


{-| Value following the current object in a sliding window to be applied in a window transform.
-}
woLead : WOperation
woLead =
    Lead


{-| Nth value in a sliding window to be applied in a window transform.
-}
woNthValue : WOperation
woNthValue =
    NthValue


{-| Value preceding the current object in a sliding window to be applied in a window transform.
-}
woPercentile : WOperation
woPercentile =
    Ntile


{-| Percentile of values in a sliding window to be applied in a window transform.
-}
woPercentRank : WOperation
woPercentRank =
    PercentRank


{-| Rank function to be applied in a window transform.
-}
woRank : WOperation
woRank =
    Rank


{-| Assign consecutive row number to values in a data object to be applied in a
window transform.
-}
woRowNumber : WOperation
woRowNumber =
    RowNumber


{-| Indicate temporal binning into year categories.
-}
year : TimeUnit
year =
    Year


{-| Indicate temporal binning with a resolution of days so a ten year sequence
would have up to approximately 10\*365 bins.
-}
yearDayOfYear : TimeUnit
yearDayOfYear =
    YearDayOfYear


{-| Indicate temporal binning with a resolution of months so a ten year sequence
would have up to 10\*12 bins.
-}
yearMonth : TimeUnit
yearMonth =
    YearMonth


{-| Indicate temporal binning with a resolution of days so a ten year sequence
would have up to approximately 10\*12\*31 bins.
-}
yearMonthDate : TimeUnit
yearMonthDate =
    YearMonthDate


{-| Indicate temporal binning with a resolution of hours so a ten year sequence
would have up to approximately 10\*12\*31\*24 bins.
-}
yearMonthDateHours : TimeUnit
yearMonthDateHours =
    YearMonthDateHours


{-| Indicate temporal binning with a resolution of minutes so a ten year sequence
would have up to approximately 10\*12\*31\*24\*60 bins.
-}
yearMonthDateHoursMinutes : TimeUnit
yearMonthDateHoursMinutes =
    YearMonthDateHoursMinutes


{-| Indicate temporal binning with a resolution of seconds so a ten year sequence
would have up to approximately 10\*12\*31\*24\*60\*60 bins.
-}
yearMonthDateHoursMinutesSeconds : TimeUnit
yearMonthDateHoursMinutesSeconds =
    YearMonthDateHoursMinutesSeconds


{-| Indicate temporal binning with a resolution of quarters so a ten year sequence
would have up to 10\*4 bins.
-}
yearQuarter : TimeUnit
yearQuarter =
    YearQuarter


{-| Indicate temporal binning with a resolution of months so a ten year sequence
would have up to 10\*12 bins. Unlike [yearMonth](#yearMonth), this will also label
bins with quarters.
-}
yearQuarterMonth : TimeUnit
yearQuarterMonth =
    YearQuarterMonth


{-| Indicate temporal binning with a resolution of weeks so a ten year sequence
would have up to 10\*52 bins.
-}
yearWeek : TimeUnit
yearWeek =
    YearWeek


{-| Indicate temporal binning with a resolution of day of week so a ten year
sequence would have up to 10\*52\*7 bins.
-}
yearWeekDay : TimeUnit
yearWeekDay =
    YearWeekDay


{-| Indicate temporal binning with a resolution of hours so a ten year sequence
would have up to 10\*52\*7\*24 bins.
-}
yearWeekDayHours : TimeUnit
yearWeekDayHours =
    YearWeekDayHours


{-| Indicate temporal binning with a resolution of minutes so a ten year sequence
would have up to 10\*52\*7\*24\*60 bins.
-}
yearWeekDayHoursMinutes : TimeUnit
yearWeekDayHoursMinutes =
    YearWeekDayHoursMinutes


{-| Indicate temporal binning with a resolution of seconds so a ten year sequence
would have up to 10\*52\*7\*24\*60\*60 bins.
-}
yearWeekDayHoursMinutesSeconds : TimeUnit
yearWeekDayHoursMinutesSeconds =
    YearWeekDayHoursMinutesSeconds



-- ################################################# Private types and functions


type Boo
    = Boo Bool
    | BooExpr String


type Timestamp
    = Timestamp (List DateTime)
    | TimestampExpr String


type Num
    = Num Float
    | NoNum
    | NumExpr String


type Nums
    = Nums (List Float)
    | NumsExpr String


type MaybeNum
    = MaybeNum (Maybe Float)
    | MaybeNumExpr String


type Str
    = Str String
    | NoStr
    | StrExpr String


type Strs
    = Strs (List String)
    | StrsExpr String


transpose : List (List a) -> List (List a)
transpose xss =
    let
        numCols =
            List.head >> Maybe.withDefault [] >> List.length
    in
    List.foldr (List.map2 (::)) (List.repeat (numCols xss) []) xss



-- Functions to convert types into their string label, labelled spec or spec


anchorSpec : Anchor -> Spec
anchorSpec an =
    case an of
        AnStart ->
            JE.string "start"

        AnMiddle ->
            JE.string "middle"

        AnEnd ->
            JE.string "end"

        AnchorExpr s ->
            JE.object [ ( "expr", JE.string s ) ]


ariaProperty : Aria -> LabelledSpec
ariaProperty arProp =
    case arProp of
        ArAria b ->
            ( "aria", JE.bool b )

        ArDescription d ->
            ( "description", JE.string d )

        ArExpr s ->
            ( "aria", JE.object [ ( "expr", JE.string s ) ] )


arrangementLabel : Arrangement -> String
arrangementLabel arrng =
    case arrng of
        Row ->
            "row"

        Column ->
            "column"

        Flow ->
            "repeat"

        Layer ->
            "layer"


autosizeProperty : Autosize -> LabelledSpec
autosizeProperty asCfg =
    case asCfg of
        APad ->
            ( "type", JE.string "pad" )

        AFit ->
            ( "type", JE.string "fit" )

        AFitX ->
            ( "type", JE.string "fit-x" )

        AFitY ->
            ( "type", JE.string "fit-y" )

        ANone ->
            ( "type", JE.string "none" )

        AResize ->
            ( "resize", JE.bool True )

        AContent ->
            ( "contains", JE.string "content" )

        APadding ->
            ( "contains", JE.string "padding" )


axisConfigProperty : AxisConfig -> List LabelledSpec
axisConfigProperty axisCfg =
    case axisCfg of
        -- AStyle ss ->
        --     case ss of
        --         [ s ] ->
        --             ( "style", JE.string s )
        --
        --         _ ->
        --             ( "style", JE.list JE.string ss )
        AxisAria aps ->
            case aps of
                [] ->
                    [ ariaProperty (ArAria False) ]

                _ ->
                    List.map ariaProperty aps

        AxDisable b ->
            [ ( "disable", JE.bool b ) ]

        BandPosition x ->
            [ ( "bandPosition", JE.float x ) ]

        Domain b ->
            [ ( "domain", JE.bool b ) ]

        DomainCap c ->
            [ ( "domainCap", strokeCapSpec c ) ]

        DomainColor c ->
            [ ( "domainColor", JE.string c ) ]

        DomainDash ds ->
            [ ( "domainDash", JE.list JE.float ds ) ]

        DomainDashOffset x ->
            [ ( "domainDashOffset", JE.float x ) ]

        DomainOpacity n ->
            [ ( "domainOpacity", JE.float n ) ]

        DomainWidth w ->
            [ ( "domainWidth", JE.float w ) ]

        MaxExtent n ->
            [ ( "maxExtent", JE.float n ) ]

        MinExtent n ->
            [ ( "minExtent", JE.float n ) ]

        Grid b ->
            [ ( "grid", JE.bool b ) ]

        GridCap c ->
            [ ( "gridCap", strokeCapSpec c ) ]

        GridColor c ->
            [ ( "gridColor", JE.string c ) ]

        GridDash ds ->
            [ ( "gridDash", JE.list JE.float ds ) ]

        GridDashOffset x ->
            [ ( "gridDashOffset", JE.float x ) ]

        GridOpacity o ->
            [ ( "gridOpacity", JE.float o ) ]

        GridWidth x ->
            [ ( "gridWidth", JE.float x ) ]

        Labels b ->
            [ ( "labels", JE.bool b ) ]

        LabelAlign ha ->
            [ ( "labelAlign", hAlignSpec ha ) ]

        LabelAngle a ->
            [ ( "labelAngle", JE.float a ) ]

        LabelBaseline va ->
            [ ( "labelBaseline", vAlignSpec va ) ]

        LabelBound mn ->
            case mn of
                Just n ->
                    if n == 1 then
                        [ ( "labelBound", JE.bool True ) ]

                    else
                        [ ( "labelBound", JE.float n ) ]

                Nothing ->
                    [ ( "labelBound", JE.bool False ) ]

        LabelColor c ->
            [ ( "labelColor", JE.string c ) ]

        LabelExpr ex ->
            [ ( "labelExpr", JE.string ex ) ]

        LabelFlush mn ->
            case mn of
                Just n ->
                    if n == 0 then
                        [ ( "labelFlush", JE.bool True ) ]

                    else
                        [ ( "labelFlush", JE.float n ) ]

                Nothing ->
                    [ ( "labelFlush", JE.bool False ) ]

        LabelFlushOffset n ->
            [ ( "labelFlushOffset", JE.float n ) ]

        LabelFont f ->
            [ ( "labelFont", JE.string f ) ]

        LabelFontStyle s ->
            [ ( "labelFontStyle", JE.string s ) ]

        LabelFontSize x ->
            [ ( "labelFontSize", JE.float x ) ]

        LabelFontWeight fw ->
            [ ( "labelFontWeight", fontWeightSpec fw ) ]

        LabelLimit x ->
            [ ( "labelLimit", JE.float x ) ]

        LabelLineHeight x ->
            [ ( "labelLineHeight", JE.float x ) ]

        LabelOpacity n ->
            [ ( "labelOpacity", JE.float n ) ]

        LabelOverlap strat ->
            [ ( "labelOverlap", overlapStrategySpec strat ) ]

        LabelPadding pad ->
            [ ( "labelPadding", JE.float pad ) ]

        LabelSeparation x ->
            [ ( "labelSeparation", JE.float x ) ]

        Ticks b ->
            [ ( "ticks", JE.bool b ) ]

        TickBand tb ->
            [ ( "tickBand", tickBandSpec tb ) ]

        TickCap c ->
            [ ( "tickCap", strokeCapSpec c ) ]

        TickColor c ->
            [ ( "tickColor", JE.string c ) ]

        TickCount tc ->
            [ ( "tickCount", scaleNiceSpec tc ) ]

        TickDash ds ->
            [ ( "tickDash", JE.list JE.float ds ) ]

        TickDashOffset x ->
            [ ( "tickDashOffset", JE.float x ) ]

        TickExtra b ->
            [ ( "tickExtra", JE.bool b ) ]

        TickOffset n ->
            [ ( "tickOffset", JE.float n ) ]

        TickOpacity n ->
            [ ( "tickOpacity", JE.float n ) ]

        TickMinStep n ->
            [ ( "tickMinStep", JE.float n ) ]

        TickRound b ->
            [ ( "tickRound", JE.bool b ) ]

        TickSize x ->
            [ ( "tickSize", JE.float x ) ]

        TickWidth x ->
            [ ( "tickWidth", JE.float x ) ]

        TitleAlign al ->
            [ ( "titleAlign", hAlignSpec al ) ]

        TitleAngle a ->
            [ ( "titleAngle", JE.float a ) ]

        TitleAnchor an ->
            [ ( "titleAnchor", anchorSpec an ) ]

        TitleBaseline va ->
            [ ( "titleBaseline", vAlignSpec va ) ]

        TitleColor c ->
            [ ( "titleColor", JE.string c ) ]

        TitleFont f ->
            [ ( "titleFont", JE.string f ) ]

        TitleFontStyle s ->
            [ ( "titleFontStyle", JE.string s ) ]

        TitleFontWeight w ->
            [ ( "titleFontWeight", fontWeightSpec w ) ]

        TitleFontSize x ->
            [ ( "titleFontSize", JE.float x ) ]

        TitleLimit x ->
            [ ( "titleLimit", JE.float x ) ]

        TitleLineHeight x ->
            [ ( "titleLineHeight", JE.float x ) ]

        TitleOpacity n ->
            [ ( "titleOpacity", JE.float n ) ]

        TitlePadding x ->
            [ ( "titlePadding", JE.float x ) ]

        TitleX x ->
            [ ( "titleX", JE.float x ) ]

        TitleY y ->
            [ ( "titleY", JE.float y ) ]

        TranslateAxis x ->
            [ ( "translate", JE.float x ) ]


axisLabel : AxisChoice -> String
axisLabel axChoice =
    case axChoice of
        AxX ->
            "axisX"

        AxY ->
            "axisY"

        AxBoth ->
            "axis"


axisProperty : AxisProperty -> List LabelledSpec
axisProperty axisProp =
    case axisProp of
        AxAria aps ->
            case aps of
                [] ->
                    [ ariaProperty (ArAria False) ]

                _ ->
                    List.map ariaProperty aps

        AxBandPosition n ->
            numExpr "bandPosition" n

        AxDataCondition predicate cap ->
            let
                firstProp =
                    List.head >> Maybe.withDefault ( "", JE.null )

                ( ifProp, elseProp ) =
                    case cap of
                        CAxLabelAlign ha1 ha2 ->
                            ( axisProperty (AxLabelAlign ha1) |> firstProp, axisProperty (axLabelAlign ha2) |> firstProp )

                        CAxLabelBaseline va1 va2 ->
                            ( axisProperty (axLabelBaseline va1) |> firstProp, axisProperty (axLabelBaseline va2) |> firstProp )

                        CAxLabelColor c1 c2 ->
                            ( axisProperty (axLabelColor c1) |> firstProp, axisProperty (axLabelColor c2) |> firstProp )

                        CAxLabelFont f1 f2 ->
                            ( axisProperty (axLabelFont f1) |> firstProp, axisProperty (axLabelFont f2) |> firstProp )

                        CAxLabelFontSize s1 s2 ->
                            ( axisProperty (axLabelFontSize s1) |> firstProp, axisProperty (axLabelFontSize s2) |> firstProp )

                        CAxLabelFontStyle s1 s2 ->
                            ( axisProperty (axLabelFontStyle s1) |> firstProp, axisProperty (axLabelFontStyle s2) |> firstProp )

                        CAxLabelFontWeight w1 w2 ->
                            ( axisProperty (axLabelFontWeight w1) |> firstProp, axisProperty (axLabelFontWeight w2) |> firstProp )

                        CAxLabelOffset o1 o2 ->
                            ( axisProperty (axLabelOffset o1) |> firstProp, axisProperty (axLabelOffset o2) |> firstProp )

                        CAxLabelOpacity o1 o2 ->
                            ( axisProperty (axLabelOpacity o1) |> firstProp, axisProperty (axLabelOpacity o2) |> firstProp )

                        CAxLabelPadding p1 p2 ->
                            ( axisProperty (axLabelPadding p1) |> firstProp, axisProperty (axLabelPadding p2) |> firstProp )

                        CAxTickColor c1 c2 ->
                            ( axisProperty (axTickColor c1) |> firstProp, axisProperty (axTickColor c2) |> firstProp )

                        CAxTickDash d1 d2 ->
                            ( axisProperty (axTickDash d1) |> firstProp, axisProperty (axTickDash d2) |> firstProp )

                        CAxTickDashOffset o1 o2 ->
                            ( axisProperty (axTickDashOffset o1) |> firstProp, axisProperty (axTickDashOffset o2) |> firstProp )

                        CAxTickOpacity o1 o2 ->
                            ( axisProperty (axTickOpacity o1) |> firstProp, axisProperty (axTickOpacity o2) |> firstProp )

                        CAxTickSize s1 s2 ->
                            ( axisProperty (axTickSize s1) |> firstProp, axisProperty (axTickSize s2) |> firstProp )

                        CAxTickWidth w1 w2 ->
                            ( axisProperty (axTickWidth w1) |> firstProp, axisProperty (axTickWidth w2) |> firstProp )

                        CAxGridColor c1 c2 ->
                            ( axisProperty (axGridColor c1) |> firstProp, axisProperty (axGridColor c2) |> firstProp )

                        CAxGridDash d1 d2 ->
                            ( axisProperty (axGridDash d1) |> firstProp, axisProperty (axGridDash d2) |> firstProp )

                        CAxGridDashOffset o1 o2 ->
                            ( axisProperty (axGridDashOffset o1) |> firstProp, axisProperty (axGridDashOffset o2) |> firstProp )

                        CAxGridOpacity o1 o2 ->
                            ( axisProperty (axGridOpacity o1) |> firstProp, axisProperty (axGridOpacity o2) |> firstProp )

                        CAxGridWidth w1 w2 ->
                            ( axisProperty (axGridWidth w1) |> firstProp, axisProperty (axGridWidth w2) |> firstProp )
            in
            [ ( Tuple.first ifProp
              , JE.object
                    [ ( "condition"
                      , JE.object
                            [ ( "test", booleanOpSpec predicate )
                            , ( "value", Tuple.second ifProp )
                            ]
                      )
                    , ( "value", Tuple.second elseProp )
                    ]
              )
            ]

        AxFormat s ->
            strExpr "format" s

        AxFormatAsNum ->
            [ ( "formatType", JE.string "number" ) ]

        AxFormatAsTemporal ->
            [ ( "formatType", JE.string "time" ) ]

        AxFormatAsCustom s ->
            strExpr "formatType" s

        AxGridCap c ->
            [ ( "gridCap", strokeCapSpec c ) ]

        AxGridColor s ->
            strExpr "gridColor" s

        AxGridDash ns ->
            numsExpr "gridDash" ns

        AxGridDashOffset n ->
            numExpr "gridDashOffset" n

        AxGridOpacity n ->
            numExpr "gridOpacity" n

        AxGridWidth n ->
            numExpr "gridWidth" n

        AxLabels b ->
            booExpr "labels" b

        AxLabelAlign ha ->
            [ ( "labelAlign", hAlignSpec ha ) ]

        AxLabelBaseline va ->
            [ ( "labelBaseline", vAlignSpec va ) ]

        AxLabelBound mn ->
            maybeNumExpr "labelBound" mn

        AxLabelAngle n ->
            numExpr "labelAngle" n

        AxLabelColor s ->
            strExpr "labelColor" s

        AxLabelExpr s ->
            strExpr "labelExpr" s

        AxLabelFlush mn ->
            case mn of
                Just n ->
                    if n == 1 then
                        [ ( "labelFlush", JE.bool True ) ]

                    else
                        [ ( "labelFlush", JE.float n ) ]

                Nothing ->
                    [ ( "labelFlush", JE.bool False ) ]

        AxLabelFlushOffset n ->
            numExpr "labelFlushOffset" n

        AxLabelFont s ->
            strExpr "labelFont" s

        AxLabelFontSize n ->
            numExpr "labelFontSize" n

        AxLabelFontStyle s ->
            strExpr "labelFontStyle" s

        AxLabelFontWeight fw ->
            [ ( "labelFontWeight", fontWeightSpec fw ) ]

        AxLabelLimit n ->
            numExpr "labelLimit" n

        AxLabelLineHeight n ->
            numExpr "labelLineHeight" n

        AxLabelOffset n ->
            numExpr "labelOffset" n

        AxLabelOpacity n ->
            numExpr "labelOpacity" n

        AxLabelOverlap strat ->
            [ ( "labelOverlap", overlapStrategySpec strat ) ]

        AxLabelPadding n ->
            numExpr "labelPadding" n

        AxLabelSeparation n ->
            numExpr "labelSeparation" n

        AxDomain b ->
            booExpr "domain" b

        AxDomainCap c ->
            [ ( "domainCap", strokeCapSpec c ) ]

        AxDomainColor s ->
            strExpr "domainColor" s

        AxDomainDash ns ->
            numsExpr "domainDash" ns

        AxDomainDashOffset n ->
            numExpr "domainDashOffset" n

        AxDomainOpacity n ->
            numExpr "domainOpacity" n

        AxDomainWidth n ->
            numExpr "domainWidth" n

        AxGrid b ->
            booExpr "grid" b

        AxMaxExtent n ->
            numExpr "maxExtent" n

        AxMinExtent n ->
            numExpr "minExtent" n

        AxOrient side ->
            [ ( "orient", sideSpec side ) ]

        AxOffset n ->
            numExpr "offset" n

        AxPosition n ->
            numExpr "position" n

        AxTranslate n ->
            numExpr "translate" n

        AxStyle ss ->
            case ss of
                [ s ] ->
                    [ ( "style", JE.string s ) ]

                _ ->
                    [ ( "style", JE.list JE.string ss ) ]

        AxZIndex n ->
            numExpr "zindex" n

        AxTicks b ->
            booExpr "ticks" b

        AxTickBand tb ->
            [ ( "tickBand", tickBandSpec tb ) ]

        AxTickCap c ->
            [ ( "tickCap", strokeCapSpec c ) ]

        AxTickColor s ->
            strExpr "tickColor" s

        AxTickCount tc ->
            [ ( "tickCount", scaleNiceSpec tc ) ]

        AxTickDash ns ->
            numsExpr "tickDash" ns

        AxTickDashOffset n ->
            numExpr "tickDashOffset" n

        AxTickExtra b ->
            booExpr "tickExtra" b

        AxTickOffset n ->
            numExpr "tickOffset" n

        AxTickOpacity n ->
            numExpr "tickOpacity" n

        AxTickRound b ->
            booExpr "tickRound" b

        AxTickMinStep n ->
            numExpr "tickMinStep" n

        AxTickSize n ->
            numExpr "tickSize" n

        AxTickWidth n ->
            numExpr "tickWidth" n

        AxValues vals ->
            [ ( "values", dataValuesSpecs vals ) ]

        AxTitle s ->
            case s of
                Str ttl ->
                    [ ( "title", multilineTextSpec ttl ) ]

                _ ->
                    strExpr "title" s

        AxTitleAlign al ->
            [ ( "titleAlign", hAlignSpec al ) ]

        AxTitleAngle n ->
            numExpr "titleAngle" n

        AxTitleAnchor an ->
            [ ( "titleAnchor", anchorSpec an ) ]

        AxTitleBaseline va ->
            [ ( "titleBaseline", vAlignSpec va ) ]

        AxTitleColor s ->
            strExpr "titleColor" s

        AxTitleFont s ->
            strExpr "titleFont" s

        AxTitleFontSize n ->
            numExpr "titleFontSize" n

        AxTitleFontStyle s ->
            strExpr "titleFontStyle" s

        AxTitleFontWeight fw ->
            [ ( "titleFontWeight", fontWeightSpec fw ) ]

        AxTitleLimit n ->
            numExpr "titleLimit" n

        AxTitleLineHeight n ->
            numExpr "titleLineHeight" n

        AxTitleOpacity n ->
            numExpr "titleOpacity" n

        AxTitlePadding n ->
            numExpr "titlePadding" n

        AxTitleX n ->
            numExpr "titleX" n

        AxTitleY n ->
            numExpr "titleY" n


bin : List BinProperty -> LabelledSpec
bin bProps =
    if bProps == [] then
        ( "bin", JE.bool True )

    else
        ( "bin", bProps |> List.map binProperty |> JE.object )


bindingProperty : Binding -> LabelledSpec
bindingProperty bnd =
    case bnd of
        IRange label props ->
            ( label, JE.object (( "input", JE.string "range" ) :: List.map inputProperty props) )

        ICheckbox label props ->
            ( label, JE.object (( "input", JE.string "checkbox" ) :: List.map inputProperty props) )

        IRadio label props ->
            ( label, JE.object (( "input", JE.string "radio" ) :: List.map inputProperty props) )

        ISelect label props ->
            ( label, JE.object (( "input", JE.string "select" ) :: List.map inputProperty props) )

        IText label props ->
            ( label, JE.object (( "input", JE.string "text" ) :: List.map inputProperty props) )

        INumber label props ->
            ( label, JE.object (( "input", JE.string "number" ) :: List.map inputProperty props) )

        IDate label props ->
            ( label, JE.object (( "input", JE.string "date" ) :: List.map inputProperty props) )

        ITime label props ->
            ( label, JE.object (( "input", JE.string "time" ) :: List.map inputProperty props) )

        IMonth label props ->
            ( label, JE.object (( "input", JE.string "month" ) :: List.map inputProperty props) )

        IWeek label props ->
            ( label, JE.object (( "input", JE.string "week" ) :: List.map inputProperty props) )

        IDateTimeLocal label props ->
            ( label, JE.object (( "input", JE.string "datetimelocal" ) :: List.map inputProperty props) )

        ITel label props ->
            ( label, JE.object (( "input", JE.string "tel" ) :: List.map inputProperty props) )

        IColor label props ->
            ( label, JE.object (( "input", JE.string "color" ) :: List.map inputProperty props) )


bindLegendProperty : BindLegendProperty -> LabelledSpec
bindLegendProperty blProp =
    case blProp of
        BLChannel ch ->
            ( "encodings", JE.list JE.string [ channelLabel ch ] )

        BLField f ->
            ( "fields", JE.list JE.string [ f ] )

        BLEvent es ->
            ( "bind", JE.object [ ( "legend", JE.string es ) ] )


binProperty : BinProperty -> LabelledSpec
binProperty binProp =
    case binProp of
        MaxBins n ->
            ( "maxbins", JE.int n )

        BiAnchor x ->
            ( "anchor", JE.float x )

        Base x ->
            ( "base", JE.float x )

        Step x ->
            ( "step", JE.float x )

        Steps xs ->
            ( "steps", JE.list JE.float xs )

        MinStep x ->
            ( "minstep", JE.float x )

        Divides xs ->
            ( "divide", JE.list JE.float xs )

        Extent mn mx ->
            ( "extent", JE.list JE.float [ mn, mx ] )

        SelectionExtent s ->
            ( "extent", JE.object [ ( "param", JE.string s ) ] )

        Nice b ->
            ( "nice", JE.bool b )


blendModeSpec : BlendMode -> Spec
blendModeSpec bm =
    case bm of
        BMNormal ->
            JE.null

        BMMultiply ->
            JE.string "multiply"

        BMScreen ->
            JE.string "screen"

        BMOverlay ->
            JE.string "overlay"

        BMDarken ->
            JE.string "darken"

        BMLighten ->
            JE.string "lighten"

        BMColorDodge ->
            JE.string "color-dodge"

        BMColorBurn ->
            JE.string "color-burn"

        BMHardLight ->
            JE.string "hard-light"

        BMSoftLight ->
            JE.string "soft-light"

        BMDifference ->
            JE.string "difference"

        BMExclusion ->
            JE.string "exclusion"

        BMHue ->
            JE.string "hue"

        BMSaturation ->
            JE.string "saturation"

        BMColor ->
            JE.string "color"

        BMLuminosity ->
            JE.string "luminosity"

        BMExpr s ->
            JE.object [ ( "expr", JE.string s ) ]


booExpr : String -> Boo -> List ( String, Spec )
booExpr objName n =
    case n of
        Boo b ->
            [ ( objName, JE.bool b ) ]

        BooExpr s ->
            [ ( objName, JE.object [ ( "expr", JE.string s ) ] ) ]


booleanOpSpec : BooleanOp -> Spec
booleanOpSpec bo =
    case bo of
        Expr ex ->
            JE.string ex

        FilterOp f ->
            filterSpec f

        FilterOpTrans tr f ->
            trFilterSpec tr f

        And operand1 operand2 ->
            JE.object [ ( "and", JE.list booleanOpSpec [ operand1, operand2 ] ) ]

        Or operand1 operand2 ->
            JE.object [ ( "or", JE.list booleanOpSpec [ operand1, operand2 ] ) ]

        Not operand ->
            JE.object [ ( "not", booleanOpSpec operand ) ]

        BooleanParam p ->
            JE.object [ ( "param", JE.string p ) ]

        SelectionName selName ->
            JE.string selName

        Selection sel ->
            JE.object [ ( "selection", JE.string sel ) ]


boundsSpec : Bounds -> Spec
boundsSpec bnds =
    case bnds of
        Full ->
            JE.string "full"

        Flush ->
            JE.string "flush"


channelLabel : Channel -> String
channelLabel ch =
    case ch of
        ChX ->
            "x"

        ChY ->
            "y"

        ChX2 ->
            "x2"

        ChY2 ->
            "y2"

        ChColor ->
            "color"

        ChOpacity ->
            "opacity"

        ChShape ->
            "shape"

        ChSize ->
            "size"

        ChStrokeDash ->
            "strokeDash"


cInterpolateSpec : CInterpolate -> Spec
cInterpolateSpec iType =
    case iType of
        Rgb gamma ->
            JE.object [ ( "type", JE.string "rgb" ), ( "gamma", JE.float gamma ) ]

        Hsl ->
            JE.object [ ( "type", JE.string "hsl" ) ]

        HslLong ->
            JE.object [ ( "type", JE.string "hsl-long" ) ]

        Lab ->
            JE.object [ ( "type", JE.string "lab" ) ]

        Hcl ->
            JE.object [ ( "type", JE.string "hcl" ) ]

        HclLong ->
            JE.object [ ( "type", JE.string "hcl-long" ) ]

        CubeHelix gamma ->
            JE.object [ ( "type", JE.string "cubehelix" ), ( "gamma", JE.float gamma ) ]

        CubeHelixLong gamma ->
            JE.object [ ( "type", JE.string "cubehelix-long" ), ( "gamma", JE.float gamma ) ]


colorGradientLabel : ColorGradient -> String
colorGradientLabel gr =
    case gr of
        GrLinear ->
            "linear"

        GrRadial ->
            "radial"


compositionAlignmentLabel : CompositionAlignment -> String
compositionAlignmentLabel ca =
    case ca of
        CANone ->
            "none"

        CAEach ->
            "each"

        CAAll ->
            "all"


concatConfigProperty : ConcatConfig -> LabelledSpec
concatConfigProperty ccp =
    case ccp of
        CoColumns n ->
            ( "columns", JE.int n )

        CoSpacing x ->
            ( "spacing", JE.float x )


configProperty : ConfigurationProperty -> LabelledSpec
configProperty configProp =
    case configProp of
        Aria b ->
            ( "aria", JE.bool b )

        Autosize aus ->
            ( "autosize", JE.object (List.map autosizeProperty aus) )

        Background bg ->
            ( "background", JE.string bg )

        CountTitle s ->
            ( "countTitle", JE.string s )

        FieldTitle ftp ->
            ( "fieldTitle", JE.string (fieldTitleLabel ftp) )

        NumberFormat fmt ->
            ( "numberFormat", JE.string fmt )

        Padding pad ->
            ( "padding", paddingSpec pad )

        TimeFormat fmt ->
            ( "timeFormat", JE.string fmt )

        Axis axType acs ->
            ( axisLabel axType, JE.object (List.concatMap axisConfigProperty acs) )

        AxisLeft acs ->
            ( "axisLeft", JE.object (List.concatMap axisConfigProperty acs) )

        AxisRight acs ->
            ( "axisRight", JE.object (List.concatMap axisConfigProperty acs) )

        AxisTop acs ->
            ( "axisTop", JE.object (List.concatMap axisConfigProperty acs) )

        AxisBottom acs ->
            ( "axisBottom", JE.object (List.concatMap axisConfigProperty acs) )

        AxisBand axType acs ->
            ( axisLabel axType ++ "Band", JE.object (List.concatMap axisConfigProperty acs) )

        AxisDiscrete axType acs ->
            ( axisLabel axType ++ "Discrete", JE.object (List.concatMap axisConfigProperty acs) )

        AxisPoint axType acs ->
            ( axisLabel axType ++ "Point", JE.object (List.concatMap axisConfigProperty acs) )

        AxisQuant axType acs ->
            ( axisLabel axType ++ "Quantitative", JE.object (List.concatMap axisConfigProperty acs) )

        AxisTemporal axType acs ->
            ( axisLabel axType ++ "Temporal", JE.object (List.concatMap axisConfigProperty acs) )

        Legend lcs ->
            ( "legend", JE.object (List.concatMap legendConfigProperty lcs) )

        Font fnt ->
            ( "font", JE.string fnt )

        MarkStyle mps ->
            ( "mark", JE.object (List.concatMap markProperty mps) )

        Projection pps ->
            ( "projection", JE.object (List.concatMap projectionProperty pps) )

        AreaStyle mps ->
            ( "area", JE.object (List.concatMap markProperty mps) )

        BarStyle mps ->
            ( "bar", JE.object (List.concatMap markProperty mps) )

        CircleStyle mps ->
            ( "circle", JE.object (List.concatMap markProperty mps) )

        FacetStyle fps ->
            ( "facet", JE.object (List.map facetConfigProperty fps) )

        ConcatStyle cps ->
            ( "concat", JE.object (List.map concatConfigProperty cps) )

        CustomFormatTypes b ->
            ( "customFormatTypes", JE.bool b )

        GeoshapeStyle mps ->
            ( "geoshape", JE.object (List.concatMap markProperty mps) )

        HeaderStyle hps ->
            ( "header", JE.object (List.concatMap headerProperty hps) )

        LineStyle mps ->
            ( "line", JE.object (List.concatMap markProperty mps) )

        PointStyle mps ->
            ( "point", JE.object (List.concatMap markProperty mps) )

        RectStyle mps ->
            ( "rect", JE.object (List.concatMap markProperty mps) )

        RuleStyle mps ->
            ( "rule", JE.object (List.concatMap markProperty mps) )

        SquareStyle mps ->
            ( "square", JE.object (List.concatMap markProperty mps) )

        TextStyle mps ->
            ( "text", JE.object (List.concatMap markProperty mps) )

        TickStyle mps ->
            ( "tick", JE.object (List.concatMap markProperty mps) )

        TitleStyle tcs ->
            ( "title", JE.object (List.concatMap titleConfigProperty tcs) )

        MarkStyles styles ->
            ( "style"
            , JE.object
                (List.map
                    (\( sName, mps ) -> ( sName, JE.object (List.concatMap markProperty mps) ))
                    styles
                )
            )

        AxisStyles styles ->
            ( "style"
            , JE.object
                (List.map
                    (\( sName, mps ) -> ( sName, JE.object (List.concatMap axisProperty mps) ))
                    styles
                )
            )

        Scale scs ->
            ( "scale", JE.object (List.map scaleConfigProperty scs) )

        Range rcs ->
            ( "range", JE.object (List.map rangeConfigProperty rcs) )

        SelectionStyle selConfig ->
            let
                selProp ( sel, sps ) =
                    ( selectionLabel sel, JE.object (List.concatMap selectionProperties sps) )
            in
            ( "selection", JE.object (List.map selProp selConfig) )

        View vcs ->
            ( "view", JE.object (List.concatMap viewConfigProperties vcs) )

        TrailStyle mps ->
            ( "trail", JE.object (List.concatMap markProperty mps) )


cursorSpec : Cursor -> Spec
cursorSpec cur =
    case cur of
        CAuto ->
            JE.string "auto"

        CDefault ->
            JE.string "default"

        CNone ->
            JE.string "none"

        CContextMenu ->
            JE.string "context-menu"

        CHelp ->
            JE.string "help"

        CPointer ->
            JE.string "pointer"

        CProgress ->
            JE.string "progress"

        CWait ->
            JE.string "wait"

        CCell ->
            JE.string "cell"

        CCrosshair ->
            JE.string "crosshair"

        CText ->
            JE.string "text"

        CVerticalText ->
            JE.string "vertical-text"

        CAlias ->
            JE.string "alias"

        CCopy ->
            JE.string "copy"

        CMove ->
            JE.string "move"

        CNoDrop ->
            JE.string "no-drop"

        CNotAllowed ->
            JE.string "not-allowed"

        CAllScroll ->
            JE.string "all-scroll"

        CColResize ->
            JE.string "col-resize"

        CRowResize ->
            JE.string "row-resize"

        CNResize ->
            JE.string "n-resize"

        CEResize ->
            JE.string "e-resize"

        CSResize ->
            JE.string "s-resize"

        CWResize ->
            JE.string "w-resize"

        CNEResize ->
            JE.string "ne-resize"

        CNWResize ->
            JE.string "nw-resize"

        CSEResize ->
            JE.string "se-resize"

        CSWResize ->
            JE.string "sw-resize"

        CEWResize ->
            JE.string "ew-resize"

        CNSResize ->
            JE.string "ns-resize"

        CNESWResize ->
            JE.string "nesw-resize"

        CNWSEResize ->
            JE.string "nwse-resize"

        CZoomIn ->
            JE.string "zoom-in"

        CZoomOut ->
            JE.string "zoom-out"

        CGrab ->
            JE.string "grab"

        CGrabbing ->
            JE.string "grabbing"

        CursorExpr s ->
            JE.object [ ( "expr", JE.string s ) ]


dataTypeLabel : DataType -> String
dataTypeLabel dType =
    case dType of
        FoNum ->
            "number"

        FoBoo ->
            "boolean"

        FoDate dateFmt ->
            if dateFmt == "" then
                "date"

            else
                "date:'" ++ dateFmt ++ "'"

        FoUtc dateFmt ->
            if dateFmt == "" then
                "utc"

            else
                "utc:'" ++ dateFmt ++ "'"


dataValueSpec : DataValue -> Spec
dataValueSpec val =
    case val of
        Number x ->
            JE.float x

        DStr s ->
            JE.string s

        Boolean b ->
            JE.bool b

        DateTime d ->
            JE.object (List.map dateTimeProperty d)

        DExpr s ->
            JE.object [ ( "expr", JE.string s ) ]

        NullValue ->
            JE.null

        DConcat vals ->
            dataValuesSpecs vals

        DObject kvs ->
            kvs |> List.map (\( k, v ) -> ( k, dataValueSpec v )) |> JE.object

        DArray xs ->
            JE.list dataValueSpec xs


dataValuesSpecs : DataValues -> Spec
dataValuesSpecs dvs =
    case dvs of
        Numbers xs ->
            List.map JE.float xs |> toList

        Strings ss ->
            List.map JE.string ss |> toList

        DateTimes dtss ->
            List.map (List.map dateTimeProperty >> JE.object) dtss |> toList

        DExprs s ->
            JE.object [ ( "expr", JE.string s ) ]

        Booleans bs ->
            List.map JE.bool bs |> toList

        DObjects obs ->
            List.map (List.map (\( k, v ) -> ( k, dataValueSpec v )) >> JE.object) obs |> toList

        DArrays ds ->
            List.map dataValuesSpecs ds |> toList


dateTimeProperty : DateTime -> LabelledSpec
dateTimeProperty dtp =
    case dtp of
        DTYear y ->
            ( "year", JE.int y )

        DTQuarter q ->
            ( "quarter", JE.int q )

        DTMonth mon ->
            ( "month", JE.string (monthNameLabel mon) )

        DTMonthNum n ->
            ( "month", JE.int n )

        DTDate d ->
            ( "date", JE.int d )

        DTDay d ->
            ( "day", JE.string (dayLabel d) )

        DTHours h ->
            ( "hours", JE.int h )

        DTMinutes m ->
            ( "minutes", JE.int m )

        DTSeconds s ->
            ( "seconds", JE.int s )

        DTMilliseconds ms ->
            ( "milliseconds", JE.int ms )


dayLabel : DayName -> String
dayLabel dayName =
    case dayName of
        Mon ->
            "Mon"

        Tue ->
            "Tue"

        Wed ->
            "Wed"

        Thu ->
            "Thu"

        Fri ->
            "Fri"

        Sat ->
            "Sat"

        Sun ->
            "Sun"


densityProperty : DensityProperty -> LabelledSpec
densityProperty denProp =
    case denProp of
        DnGroupBy fields ->
            ( "groupby", JE.list JE.string fields )

        DnCumulative b ->
            ( "cumulative", JE.bool b )

        DnCounts b ->
            ( "counts", JE.bool b )

        DnBandwidth x ->
            ( "bandwidth", JE.float x )

        DnExtent mn mx ->
            ( "extent", JE.list JE.float [ mn, mx ] )

        DnMinSteps n ->
            ( "minsteps", JE.int n )

        DnMaxSteps n ->
            ( "maxsteps", JE.int n )

        DnSteps n ->
            ( "steps", JE.int n )

        DnAs vStr dStr ->
            ( "as", JE.list JE.string [ vStr, dStr ] )


detailChannelProperty : DetailChannel -> LabelledSpec
detailChannelProperty field =
    case field of
        DName s ->
            ( "field", JE.string s )

        DmType t ->
            ( "type", JE.string (measurementLabel t) )

        DBin bps ->
            bin bps

        DTimeUnit tu ->
            ( "timeUnit", timeUnitSpec tu )

        DAggregate op ->
            ( "aggregate", operationSpec op )



-- eventLabel : Event -> String
-- eventLabel e =
--     case e of
--         Click ->
--             "click"
--
--         DblClick ->
--             "dblclick"
--
--         DragEnter ->
--             "dragenter"
--
--         DragLeave ->
--             "dragleave"
--
--         DragOver ->
--             "dragover"
--
--         KeyDown ->
--             "keydown"
--
--         KeyPress ->
--             "keypress"
--
--         KeyUp ->
--             "keyup"
--
--         MouseDown ->
--             "mousedown"
--
--         MouseMove ->
--             "mousemove"
--
--         MouseOut ->
--             "mouseout"
--
--         MouseOver ->
--             "mouseover"
--
--         MouseUp ->
--             "mouseup"
--
--         MouseWheel ->
--             "mousewheel"
--
--         TouchEnd ->
--             "touchend"
--
--         TouchMove ->
--             "touchmove"
--
--         TouchStart ->
--             "touchstart"
--
--         Wheel ->
--             "touchwheel"


extentSpec : SummaryExtent -> Spec
extentSpec ext =
    case ext of
        ExCI ->
            JE.string "ci"

        ExStderr ->
            JE.string "stderr"

        ExStdev ->
            JE.string "stdev"

        ExIqr ->
            JE.string "iqr"

        ExRange ->
            JE.string "min-max"

        ExIqrScale sc ->
            JE.float sc


facetChannelProperty : FacetChannel -> LabelledSpec
facetChannelProperty fMap =
    case fMap of
        FName s ->
            ( "field", JE.string s )

        FmType measure ->
            ( "type", JE.string (measurementLabel measure) )

        FBin bps ->
            bin bps

        FSort sps ->
            case sps of
                [] ->
                    ( "sort", JE.null )

                [ Ascending ] ->
                    ( "sort", JE.string "ascending" )

                [ Descending ] ->
                    ( "sort", JE.string "descending" )

                [ CustomSort dvs ] ->
                    ( "sort", dataValuesSpecs dvs )

                _ ->
                    ( "sort", JE.object (List.concatMap sortProperties sps) )

        FAggregate op ->
            ( "aggregate", operationSpec op )

        FTimeUnit tu ->
            ( "timeUnit", timeUnitSpec tu )

        FHeader hProps ->
            ( "header", JE.object (List.concatMap headerProperty hProps) )

        FAlign al ->
            ( "align", JE.string (compositionAlignmentLabel al) )

        FCenter b ->
            ( "center", JE.bool b )

        FSpacing x ->
            ( "spacing", JE.float x )


facetMappingProperty : FacetMapping -> LabelledSpec
facetMappingProperty fMap =
    case fMap of
        RowBy fFields ->
            ( "row", JE.object (List.map facetChannelProperty fFields) )

        ColumnBy fFields ->
            ( "column", JE.object (List.map facetChannelProperty fFields) )


facetConfigProperty : FacetConfig -> LabelledSpec
facetConfigProperty fcp =
    case fcp of
        FCColumns n ->
            ( "columns", JE.int n )

        FCSpacing x ->
            ( "spacing", JE.float x )


fieldTitleLabel : FieldTitleProperty -> String
fieldTitleLabel ftp =
    case ftp of
        FTVerbal ->
            "verbal"

        FTFunction ->
            "functional"

        FTPlain ->
            "plain"


filterProperties : Filter -> List LabelledSpec
filterProperties f =
    case f of
        FEqual field val ->
            [ ( "field", JE.string field ), ( "equal", dataValueSpec val ) ]

        FLessThan field val ->
            [ ( "field", JE.string field ), ( "lt", dataValueSpec val ) ]

        FLessThanEq field val ->
            [ ( "field", JE.string field ), ( "lte", dataValueSpec val ) ]

        FGreaterThan field val ->
            [ ( "field", JE.string field ), ( "gt", dataValueSpec val ) ]

        FGreaterThanEq field val ->
            [ ( "field", JE.string field ), ( "gte", dataValueSpec val ) ]

        FSelection selName ->
            [ ( "param", JE.string selName ) ]

        FSelectionEmpty selName ->
            [ ( "param", JE.string selName ), ( "empty", JE.bool False ) ]

        FRange field vals ->
            let
                fromTs ts =
                    case ts of
                        TimestampExpr s ->
                            JE.object [ ( "expr", JE.string s ) ]

                        Timestamp [] ->
                            JE.null

                        Timestamp d ->
                            JE.object (List.map dateTimeProperty d)

                values =
                    case vals of
                        NumberRange mn mx ->
                            JE.list JE.float [ mn, mx ]

                        DateRange ts1 ts2 ->
                            toList [ fromTs ts1, fromTs ts2 ]
            in
            [ ( "field", JE.string field ), ( "range", values ) ]

        FOneOf field vals ->
            let
                values =
                    case vals of
                        Numbers xs ->
                            JE.list JE.float xs

                        DateTimes ds ->
                            JE.list (\d -> JE.object (List.map dateTimeProperty d)) ds

                        Strings ss ->
                            JE.list JE.string ss

                        DExprs s ->
                            JE.object [ ( "expr", JE.string s ) ]

                        Booleans bs ->
                            JE.list JE.bool bs

                        DObjects obs ->
                            -- TODO: Check this produces the correct result.
                            JE.list (List.map (\( k, v ) -> ( k, dataValueSpec v )) >> JE.object) obs

                        DArrays ds ->
                            -- TODO: Check this produces the correct result.
                            JE.list dataValuesSpecs ds
            in
            [ ( "field", JE.string field ), ( "oneOf", values ) ]

        FValid field ->
            [ ( "field", JE.string field ), ( "valid", JE.bool True ) ]

        _ ->
            []


filterSpec : Filter -> Spec
filterSpec f =
    case f of
        FExpr ex ->
            JE.string ex

        FCompose boolExpr ->
            booleanOpSpec boolExpr

        _ ->
            JE.object (filterProperties f)


fontWeightSpec : FontWeight -> Spec
fontWeightSpec w =
    case w of
        Normal ->
            JE.string "normal"

        Bold ->
            JE.string "bold"

        Bolder ->
            JE.string "bolder"

        Lighter ->
            JE.string "lighter"

        FWExpr s ->
            JE.object [ ( "expr", JE.string s ) ]

        W100 ->
            JE.float 100

        W200 ->
            JE.float 200

        W300 ->
            JE.float 300

        W400 ->
            JE.float 400

        W500 ->
            JE.float 500

        W600 ->
            JE.float 600

        W700 ->
            JE.float 700

        W800 ->
            JE.float 800

        W900 ->
            JE.float 900


formatProperties : Format -> List LabelledSpec
formatProperties fmt =
    case fmt of
        JSON propertyName ->
            if String.trim propertyName == "" then
                [ ( "type", JE.string "json" ) ]

            else
                [ ( "type", JE.string "json" ), ( "property", JE.string propertyName ) ]

        CSV ->
            [ ( "type", JE.string "csv" ) ]

        TSV ->
            [ ( "type", JE.string "tsv" ) ]

        DSV delim ->
            [ ( "type", JE.string "dsv" ), ( "delimiter", JE.string (String.fromChar delim) ) ]

        Arrow ->
            [ ( "type", JE.string "arrow" ) ]

        TopojsonFeature objectSet ->
            [ ( "type", JE.string "topojson" ), ( "feature", JE.string objectSet ) ]

        TopojsonMesh objectSet ->
            [ ( "type", JE.string "topojson" ), ( "mesh", JE.string objectSet ) ]

        Parse fmts ->
            if fmts == [] then
                [ ( "parse", JE.null ) ]

            else
                [ ( "parse"
                  , JE.object
                        (List.map
                            (\( field, fFormat ) ->
                                ( field, JE.string (dataTypeLabel fFormat) )
                            )
                            fmts
                        )
                  )
                ]


geometryTypeProperties : Geometry -> List LabelledSpec
geometryTypeProperties gType =
    let
        toCoords : List ( Float, Float ) -> Spec
        toCoords pairs =
            JE.list (\( x, y ) -> JE.list JE.float [ x, y ]) pairs
    in
    case gType of
        GeoPoint x y ->
            [ ( "type", JE.string "Point" )
            , ( "coordinates", JE.list JE.float [ x, y ] )
            ]

        GeoPoints coords ->
            [ ( "type", JE.string "MultiPoint" )
            , ( "coordinates", toCoords coords )
            ]

        GeoLine coords ->
            [ ( "type", JE.string "LineString" )
            , ( "coordinates", toCoords coords )
            ]

        GeoLines coords ->
            [ ( "type", JE.string "MultiLineString" )
            , ( "coordinates", JE.list toCoords coords )
            ]

        GeoPolygon coords ->
            [ ( "type", JE.string "Polygon" )
            , ( "coordinates", JE.list toCoords coords )
            ]

        GeoPolygons coords ->
            [ ( "type", JE.string "MultiPolygon" )
            , ( "coordinates", JE.list (\cs -> List.map toCoords cs |> toList) coords )
            ]


gradientProperty : GradientProperty -> LabelledSpec
gradientProperty gp =
    case gp of
        GrX1 x ->
            ( "x1", JE.float x )

        GrY1 x ->
            ( "y1", JE.float x )

        GrX2 x ->
            ( "x2", JE.float x )

        GrY2 x ->
            ( "y2", JE.float x )

        GrR1 x ->
            ( "r1", JE.float x )

        GrR2 x ->
            ( "r2", JE.float x )

        GrStops grs ->
            ( "stops", JE.list stopSpec grs )


graticuleProperty : GraticuleProperty -> LabelledSpec
graticuleProperty prop =
    case prop of
        GrExtent ( lng1, lat1 ) ( lng2, lat2 ) ->
            ( "extent", toList [ JE.list JE.float [ lng1, lat1 ], JE.list JE.float [ lng2, lat2 ] ] )

        GrExtentMajor ( lng1, lat1 ) ( lng2, lat2 ) ->
            ( "extentMajor", toList [ JE.list JE.float [ lng1, lat1 ], JE.list JE.float [ lng2, lat2 ] ] )

        GrExtentMinor ( lng1, lat1 ) ( lng2, lat2 ) ->
            ( "extentMinor", toList [ JE.list JE.float [ lng1, lat1 ], JE.list JE.float [ lng2, lat2 ] ] )

        GrStep ( lng, lat ) ->
            ( "step", JE.list JE.float [ lng, lat ] )

        GrStepMajor ( lng, lat ) ->
            ( "stepMajor", JE.list JE.float [ lng, lat ] )

        GrStepMinor ( lng, lat ) ->
            ( "stepMinor", JE.list JE.float [ lng, lat ] )

        GrPrecision x ->
            ( "precision", JE.float x )


hAlignSpec : HAlign -> Spec
hAlignSpec al =
    case al of
        HAlignLeft ->
            JE.string "left"

        HAlignCenter ->
            JE.string "center"

        HAlignRight ->
            JE.string "right"

        HAlignExpr s ->
            JE.object [ ( "expr", JE.string s ) ]


headerProperty : HeaderProperty -> List LabelledSpec
headerProperty hProp =
    case hProp of
        HFormat fmt ->
            [ ( "format", JE.string fmt ) ]

        HFormatAsNum ->
            [ ( "formatType", JE.string "number" ) ]

        HFormatAsTemporal ->
            [ ( "formatType", JE.string "time" ) ]

        HFormatAsCustom formatter ->
            [ ( "formatType", JE.string formatter ) ]

        HLabelAlign ha ->
            [ ( "labelAlign", hAlignSpec ha ) ]

        HLabelAnchor a ->
            [ ( "labelAnchor", anchorSpec a ) ]

        HLabelAngle x ->
            numExpr "labelAngle" x

        HLabelBaseline va ->
            [ ( "labelBaseline", vAlignSpec va ) ]

        HLabelColor s ->
            strExpr "labelColor" s

        HLabelExpr s ->
            [ ( "labelExpr", JE.string s ) ]

        HLabelFont s ->
            strExpr "labelFont" s

        HLabelFontSize x ->
            numExpr "labelFontSize" x

        HLabelFontStyle s ->
            strExpr "labelFontStyle" s

        HLabelFontWeight fw ->
            [ ( "labelFontWeight", fontWeightSpec fw ) ]

        HLabelLimit x ->
            numExpr "labelLimit" x

        HLabelLineHeight x ->
            numExpr "labelLineHeight" x

        HLabelOrient orient ->
            [ ( "labelOrient", sideSpec orient ) ]

        HLabelPadding x ->
            numExpr "labelPadding" x

        HLabels b ->
            [ ( "labels", JE.bool b ) ]

        HOrient orient ->
            [ ( "orient", sideSpec orient ) ]

        HTitle s ->
            case s of
                "" ->
                    [ ( "title", JE.null ) ]

                _ ->
                    [ ( "title", multilineTextSpec s ) ]

        HTitleAnchor a ->
            [ ( "titleAnchor", anchorSpec a ) ]

        HTitleAlign ha ->
            [ ( "titleAlign", hAlignSpec ha ) ]

        HTitleAngle x ->
            numExpr "titleAngle" x

        HTitleBaseline va ->
            [ ( "titleBaseline", vAlignSpec va ) ]

        HTitleColor s ->
            strExpr "titleColor" s

        HTitleFont s ->
            strExpr "titleFont" s

        HTitleFontWeight fw ->
            [ ( "titleFontWeight", fontWeightSpec fw ) ]

        HTitleFontSize x ->
            numExpr "titleFontSize" x

        HTitleFontStyle s ->
            strExpr "titleFontStyle" s

        HTitleLimit x ->
            numExpr "titleLimit" x

        HTitleLineHeight x ->
            numExpr "titleLineHeight" x

        HTitleOrient orient ->
            [ ( "titleOrient", sideSpec orient ) ]

        HTitlePadding x ->
            numExpr "titlePadding" x


hyperlinkChannelProperties : HyperlinkChannel -> List LabelledSpec
hyperlinkChannelProperties field =
    case field of
        HName s ->
            [ ( "field", JE.string s ) ]

        HRepeat arr ->
            [ ( "field", JE.object [ ( "repeat", JE.string (arrangementLabel arr) ) ] ) ]

        HmType t ->
            [ ( "type", JE.string (measurementLabel t) ) ]

        HBin bps ->
            [ bin bps ]

        HBinned ->
            [ ( "bin", JE.string "binned" ) ]

        HCondition predicate ifClause elseClause ->
            ( "condition", JE.object (predicateProperties predicate ++ List.concatMap hyperlinkChannelProperties ifClause) )
                :: List.concatMap hyperlinkChannelProperties elseClause

        HDataCondition isSelection predicate ifClause elseClause ->
            if isSelection then
                ( "condition", JE.object (( "selection", booleanOpSpec predicate ) :: List.concatMap hyperlinkChannelProperties ifClause) )
                    :: List.concatMap hyperlinkChannelProperties elseClause

            else
                ( "condition", JE.object (( "test", booleanOpSpec predicate ) :: List.concatMap hyperlinkChannelProperties ifClause) )
                    :: List.concatMap hyperlinkChannelProperties elseClause

        HTimeUnit tu ->
            [ ( "timeUnit", timeUnitSpec tu ) ]

        HAggregate op ->
            [ ( "aggregate", operationSpec op ) ]

        HString s ->
            [ ( "value", JE.string s ) ]


imMethodLabel : ImMethod -> String
imMethodLabel method =
    case method of
        ImValue ->
            "value"

        ImMean ->
            "mean"

        ImMedian ->
            "median"

        ImMax ->
            "max"

        ImMin ->
            "min"


inputProperty : InputProperty -> LabelledSpec
inputProperty prop =
    case prop of
        InMin x ->
            ( "min", JE.float x )

        InMax x ->
            ( "max", JE.float x )

        InStep x ->
            ( "step", JE.float x )

        Debounce x ->
            ( "debounce", JE.float x )

        InName s ->
            ( "name", JE.string s )

        InOptions opts ->
            ( "options", JE.list JE.string opts )

        InDatumOptions opts ->
            ( "options", JE.list dataValueSpec opts )

        InDataOptions opts ->
            ( "options", JE.list dataValuesSpecs opts )

        InPlaceholder el ->
            ( "placeholder", JE.string el )

        Element el ->
            ( "element", JE.string el )


keyChannelProperty : KeyChannel -> LabelledSpec
keyChannelProperty pDef =
    case pDef of
        KName s ->
            ( "field", JE.string s )

        KmType measure ->
            ( "type", JE.string (measurementLabel measure) )


legendConfigProperty : LegendConfig -> List LabelledSpec
legendConfigProperty legendConfig =
    case legendConfig of
        LeAria aps ->
            case aps of
                [] ->
                    [ ariaProperty (ArAria False) ]

                _ ->
                    List.map ariaProperty aps

        LeDisable b ->
            [ ( "disable", JE.bool b ) ]

        LeClipHeight h ->
            [ ( "clipHeight", JE.float h ) ]

        LeColumnPadding n ->
            [ ( "columnPadding", JE.float n ) ]

        LeRowPadding n ->
            [ ( "rowPadding", JE.float n ) ]

        LeColumns n ->
            [ ( "columns", JE.float n ) ]

        CornerRadius r ->
            [ ( "cornerRadius", JE.float r ) ]

        FillColor s ->
            [ ( "fillColor", JE.string s ) ]

        Orient orient ->
            [ ( "orient", legendOrientSpec orient ) ]

        Offset x ->
            [ ( "offset", JE.float x ) ]

        StrokeColor s ->
            [ ( "strokeColor", JE.string s ) ]

        LeStrokeDash xs ->
            [ ( "strokeDash", JE.list JE.float xs ) ]

        LeStrokeWidth x ->
            [ ( "strokeWidth", JE.float x ) ]

        LePadding x ->
            [ ( "padding", JE.float x ) ]

        GradientDirection d ->
            [ ( "gradientDirection", JE.string (markOrientationLabel d) ) ]

        GradientLabelBaseline va ->
            [ ( "gradientLabelBaseline", vAlignSpec va ) ]

        GradientLabelLimit x ->
            [ ( "gradientLabelLimit", JE.float x ) ]

        GradientLabelOffset x ->
            [ ( "gradientLabelOffset", JE.float x ) ]

        GradientOpacity x ->
            [ ( "gradientOpacity", JE.float x ) ]

        GradientStrokeColor s ->
            [ ( "gradientStrokeColor", JE.string s ) ]

        GradientStrokeWidth x ->
            [ ( "gradientStrokeWidth", JE.float x ) ]

        GradientHeight x ->
            [ ( "gradientHeight", JE.float x ) ]

        GradientWidth x ->
            [ ( "gradientWidth", JE.float x ) ]

        LeGridAlign ga ->
            [ ( "gridAlign", JE.string (compositionAlignmentLabel ga) ) ]

        LeLabelAlign ha ->
            [ ( "labelAlign", hAlignSpec ha ) ]

        LeLabelBaseline va ->
            [ ( "labelBaseline", vAlignSpec va ) ]

        LeLabelColor s ->
            [ ( "labelColor", JE.string s ) ]

        LeLabelFont s ->
            [ ( "labelFont", JE.string s ) ]

        LeLabelFontSize x ->
            [ ( "labelFontSize", JE.float x ) ]

        LeLabelFontStyle s ->
            [ ( "labelFontStyle", JE.string s ) ]

        LeLabelFontWeight fw ->
            [ ( "labelFontWeight", fontWeightSpec fw ) ]

        LeLabelLimit x ->
            [ ( "labelLimit", JE.float x ) ]

        LeLabelOffset x ->
            [ ( "labelOffset", JE.float x ) ]

        LeLabelOverlap lo ->
            [ ( "labelOverlap", overlapStrategySpec lo ) ]

        LeShortTimeLabels b ->
            [ ( "shortTimeLabels", JE.bool b ) ]

        EntryPadding x ->
            [ ( "entryPadding", JE.float x ) ]

        SymbolDirection d ->
            [ ( "symbolDirection", JE.string (markOrientationLabel d) ) ]

        SymbolLimit n ->
            [ ( "symbolLimit", JE.int n ) ]

        SymbolFillColor s ->
            [ ( "symbolFillColor", JE.string s ) ]

        SymbolBaseFillColor s ->
            [ ( "symbolBaseFillColor", JE.string s ) ]

        SymbolStrokeColor s ->
            [ ( "symbolStrokeColor", JE.string s ) ]

        SymbolBaseStrokeColor s ->
            [ ( "symbolBaseStrokeColor", JE.string s ) ]

        SymbolDash sd ->
            [ ( "symbolDash", JE.list JE.float sd ) ]

        SymbolDashOffset x ->
            [ ( "symbolDashOffset", JE.float x ) ]

        SymbolOffset x ->
            [ ( "symbolOffset", JE.float x ) ]

        SymbolOpacity x ->
            [ ( "symbolOpacity", JE.float x ) ]

        SymbolType s ->
            [ ( "symbolType", symbolSpec s ) ]

        SymbolSize x ->
            [ ( "symbolSize", JE.float x ) ]

        SymbolStrokeWidth x ->
            [ ( "symbolStrokeWidth", JE.float x ) ]

        LeTitleAlign ha ->
            [ ( "titleAlign", hAlignSpec ha ) ]

        LeTitleBaseline va ->
            [ ( "titleBaseline", vAlignSpec va ) ]

        LeTitleAnchor an ->
            [ ( "titleAnchor", anchorSpec an ) ]

        LeTitleColor s ->
            [ ( "titleColor", JE.string s ) ]

        LeTitleFont s ->
            [ ( "titleFont", JE.string s ) ]

        LeTitleFontSize x ->
            [ ( "titleFontSize", JE.float x ) ]

        LeTitleFontStyle s ->
            [ ( "titleFontStyle", JE.string s ) ]

        LeTitleFontWeight fw ->
            [ ( "titleFontWeight", fontWeightSpec fw ) ]

        LeTitleLimit x ->
            [ ( "titleLimit", JE.float x ) ]

        LeTitleLineHeight x ->
            [ ( "titleLineHeight", JE.float x ) ]

        LeTitleOpacity x ->
            [ ( "titleOpacity", JE.float x ) ]

        LeTitlePadding x ->
            [ ( "titlePadding", JE.float x ) ]

        LeUnselectedOpacity o ->
            [ ( "unselectedOpacity", JE.float o ) ]


legendOrientSpec : LegendOrientation -> Spec
legendOrientSpec orient =
    case orient of
        Left ->
            JE.string "left"

        TopLeft ->
            JE.string "top-left"

        Top ->
            JE.string "top"

        TopRight ->
            JE.string "top-right"

        Right ->
            JE.string "right"

        BottomRight ->
            JE.string "bottom-right"

        Bottom ->
            JE.string "bottom"

        BottomLeft ->
            JE.string "bottom-left"

        None ->
            JE.string "none"


legendProperty : LegendProperty -> List LabelledSpec
legendProperty legendProp =
    case legendProp of
        LAria aps ->
            case aps of
                [] ->
                    [ ariaProperty (ArAria False) ]

                _ ->
                    List.map ariaProperty aps

        LClipHeight n ->
            numExpr "clipHeight" n

        LColumnPadding n ->
            numExpr "columnPadding" n

        LRowPadding n ->
            numExpr "rowPadding" n

        LColumns n ->
            numExpr "columns" n

        LCornerRadius n ->
            numExpr "cornerRadius" n

        LFillColor s ->
            strExpr "fillColor" s

        LDirection d ->
            [ ( "direction", JE.string (markOrientationLabel d) ) ]

        LType lType ->
            case lType of
                Gradient ->
                    [ ( "type", JE.string "gradient" ) ]

                Symbol ->
                    [ ( "type", JE.string "symbol" ) ]

        LFormat s ->
            strExpr "format" s

        LFormatAsNum ->
            [ ( "formatType", JE.string "number" ) ]

        LFormatAsTemporal ->
            [ ( "formatType", JE.string "time" ) ]

        LFormatAsCustom s ->
            strExpr "formatType" s

        LGradientLength n ->
            numExpr "gradientLength" n

        LGradientOpacity n ->
            numExpr "gradientOpacity" n

        LGradientThickness n ->
            numExpr "gradientThickness" n

        LGradientStrokeColor s ->
            strExpr "gradientStrokeColor" s

        LGradientStrokeWidth n ->
            numExpr "gradientStrokeWidth" n

        LGridAlign ga ->
            [ ( "gridAlign", JE.string (compositionAlignmentLabel ga) ) ]

        LLabelAlign ha ->
            [ ( "labelAlign", hAlignSpec ha ) ]

        LLabelBaseline va ->
            [ ( "labelBaseline", vAlignSpec va ) ]

        LLabelColor s ->
            strExpr "labelColor" s

        LLabelFont s ->
            strExpr "labelFont" s

        LLabelFontSize n ->
            numExpr "labelFontSize" n

        LLabelFontStyle s ->
            strExpr "labelFontStyle" s

        LLabelFontWeight fw ->
            [ ( "labelFontWeight", fontWeightSpec fw ) ]

        LLabelLimit n ->
            numExpr "labelLimit" n

        LLabelOffset n ->
            numExpr "labelOffset" n

        LLabelOverlap lo ->
            [ ( "labelOverlap", overlapStrategySpec lo ) ]

        LOffset n ->
            numExpr "offset" n

        LOrient orient ->
            [ ( "orient", legendOrientSpec orient ) ]

        LPadding n ->
            numExpr "padding" n

        LStrokeColor s ->
            strExpr "strokeColor" s

        LStrokeWidth n ->
            numExpr "strokeWidth" n

        LSymbolDash sd ->
            numsExpr "symbolDash" sd

        LSymbolDashOffset n ->
            numExpr "symbolDashOffset" n

        LSymbolFillColor s ->
            strExpr "symbolFillColor" s

        LSymbolLimit n ->
            numExpr "symbolLimit" n

        LSymbolOffset n ->
            numExpr "symbolOffset" n

        LSymbolOpacity n ->
            numExpr "symbolOpacity" n

        LSymbolStrokeColor s ->
            strExpr "symbolStrokeColor" s

        LSymbolType s ->
            [ ( "symbolType", symbolSpec s ) ]

        LSymbolSize n ->
            numExpr "symbolSize" n

        LSymbolStrokeWidth n ->
            numExpr "symbolStrokeWidth" n

        LTickCount n ->
            numExpr "tickCount" n

        LTitle txt ->
            case txt of
                NoStr ->
                    [ ( "title", JE.null ) ]

                Str s ->
                    if s == "" then
                        [ ( "title", JE.null ) ]

                    else
                        [ ( "title", multilineTextSpec s ) ]

                _ ->
                    strExpr "title" txt

        LTitleAlign ha ->
            [ ( "titleAlign", hAlignSpec ha ) ]

        LTitleAnchor an ->
            [ ( "titleAnchor", anchorSpec an ) ]

        LTitleBaseline va ->
            [ ( "titleBaseline", vAlignSpec va ) ]

        LTitleColor s ->
            strExpr "titleColor" s

        LTitleFont s ->
            strExpr "titleFont" s

        LTitleFontSize n ->
            numExpr "titleFontSize" n

        LTitleFontStyle s ->
            strExpr "titleFontStyle" s

        LTitleFontWeight fw ->
            [ ( "titleFontWeight", fontWeightSpec fw ) ]

        LTitleLimit n ->
            numExpr "titleLimit" n

        LTitleLineHeight n ->
            numExpr "titleLineHeight" n

        LTitleOpacity n ->
            numExpr "titleOpacity" n

        LTitleOrient orient ->
            [ ( "titleOrient", legendOrientSpec orient ) ]

        LTitlePadding n ->
            numExpr "titlePadding" n

        LValues vals ->
            [ ( "values", dataValuesSpecs vals ) ]

        ---TODO: Pending fixing of https://github.com/vega/vega-lite/issues/5921
        -- LUnselectedOpacity o ->
        --     ( "unselectedOpacity", JE.float o )
        LeX n ->
            numExpr "legendX" n

        LeY n ->
            numExpr "legendY" n

        LZIndex n ->
            numExpr "zindex" n


lineMarkerSpec : LineMarker -> Spec
lineMarkerSpec pm =
    case pm of
        LMNone ->
            JE.bool False

        LMMarker mps ->
            JE.object (List.concatMap markProperty mps)


loessProperty : LoessProperty -> LabelledSpec
loessProperty denProp =
    case denProp of
        LsGroupBy fields ->
            ( "groupby", JE.list JE.string fields )

        LsBandwidth x ->
            ( "bandwidth", JE.float x )

        LsAs vStr dStr ->
            ( "as", JE.list JE.string [ vStr, dStr ] )


mark : Mark -> List MarkProperty -> ( VLProperty, Spec )
mark m mProps =
    case mProps of
        [] ->
            ( VLMark, JE.string (markLabel m) )

        _ ->
            ( VLMark
            , ( "type", JE.string (markLabel m) )
                :: List.concatMap markProperty mProps
                |> JE.object
            )


markChannelProperties : MarkChannel -> List LabelledSpec
markChannelProperties field =
    case field of
        MName s ->
            [ ( "field", JE.string s ) ]

        MDatum d ->
            [ ( "datum", dataValueSpec d ) ]

        MRepeat arr ->
            [ ( "field", JE.object [ ( "repeat", JE.string (arrangementLabel arr) ) ] ) ]

        MRepeatDatum arr ->
            [ ( "datum", JE.object [ ( "repeat", JE.string (arrangementLabel arr) ) ] ) ]

        MmType t ->
            [ ( "type", JE.string (measurementLabel t) ) ]

        MScale sps ->
            if sps == [] then
                [ ( "scale", JE.null ) ]

            else
                [ ( "scale", JE.object (List.concatMap scaleProperty sps) ) ]

        MLegend lps ->
            if lps == [] then
                [ ( "legend", JE.null ) ]

            else
                [ ( "legend", JE.object (List.concatMap legendProperty lps) ) ]

        MBin bps ->
            [ bin bps ]

        MBand x ->
            [ ( "band", JE.float x ) ]

        MSort sps ->
            case sps of
                [] ->
                    [ ( "sort", JE.null ) ]

                [ Ascending ] ->
                    [ ( "sort", JE.string "ascending" ) ]

                [ Descending ] ->
                    [ ( "sort", JE.string "descending" ) ]

                [ CustomSort dvs ] ->
                    [ ( "sort", dataValuesSpecs dvs ) ]

                _ ->
                    [ ( "sort", JE.object (List.concatMap sortProperties sps) ) ]

        MBinned ->
            [ ( "bin", JE.string "binned" ) ]

        MCondition predicate ifClause elseClause ->
            ( "condition"
            , JE.object (predicateProperties predicate ++ List.concatMap markChannelProperties ifClause)
            )
                :: List.concatMap markChannelProperties elseClause

        MConditions ifClauses elseClause ->
            ( "condition"
            , JE.list
                (\( predicate, ifClause ) ->
                    JE.object (predicateProperties predicate ++ List.concatMap markChannelProperties ifClause)
                )
                ifClauses
            )
                :: List.concatMap markChannelProperties elseClause

        MDataCondition isSelection tests elseClause ->
            let
                testClause ( predicate, ifClause ) =
                    if isSelection then
                        JE.object
                            (( "selection", booleanOpSpec predicate )
                                :: List.concatMap markChannelProperties ifClause
                            )

                    else
                        JE.object
                            (( "test", booleanOpSpec predicate )
                                :: List.concatMap markChannelProperties ifClause
                            )
            in
            ( "condition"
            , case tests of
                [ test ] ->
                    testClause test

                _ ->
                    JE.list testClause tests
            )
                :: List.concatMap markChannelProperties elseClause

        MTimeUnit tu ->
            [ ( "timeUnit", timeUnitSpec tu ) ]

        MTitle t ->
            [ ( "title", multilineTextSpec t ) ]

        MAggregate op ->
            [ ( "aggregate", operationSpec op ) ]

        MPath s ->
            [ ( "value", JE.string s ) ]

        MNumber x ->
            [ ( "value", JE.float x ) ]

        MString s ->
            [ ( "value", JE.string s ) ]

        MBoolean b ->
            [ ( "value", JE.bool b ) ]


markInterpolationSpec : MarkInterpolation -> Spec
markInterpolationSpec interp =
    case interp of
        Linear ->
            JE.string "linear"

        LinearClosed ->
            JE.string "linear-closed"

        Stepwise ->
            JE.string "step"

        StepBefore ->
            JE.string "step-before"

        StepAfter ->
            JE.string "step-after"

        Basis ->
            JE.string "basis"

        BasisOpen ->
            JE.string "basis-open"

        BasisClosed ->
            JE.string "basis-closed"

        Cardinal ->
            JE.string "cardinal"

        CardinalOpen ->
            JE.string "cardinal-open"

        CardinalClosed ->
            JE.string "cardinal-closed"

        Bundle ->
            JE.string "bundle"

        Monotone ->
            JE.string "monotone"

        InterpolateExpr s ->
            JE.object [ ( "expr", JE.string s ) ]


markLabel : Mark -> String
markLabel m =
    case m of
        Arc ->
            "arc"

        Area ->
            "area"

        Bar ->
            "bar"

        Boxplot ->
            "boxplot"

        Circle ->
            "circle"

        Errorband ->
            "errorband"

        Errorbar ->
            "errorbar"

        Image ->
            "image"

        Line ->
            "line"

        Geoshape ->
            "geoshape"

        Point ->
            "point"

        Rect ->
            "rect"

        Rule ->
            "rule"

        Square ->
            "square"

        Text ->
            "text"

        Tick ->
            "tick"

        Trail ->
            "trail"


markOrientationLabel : MarkOrientation -> String
markOrientationLabel orient =
    case orient of
        MOHorizontal ->
            "horizontal"

        MOVertical ->
            "vertical"


markProperty : MarkProperty -> List LabelledSpec
markProperty mProp =
    case mProp of
        MAria aps ->
            case aps of
                [] ->
                    [ ariaProperty (ArAria False) ]

                _ ->
                    List.map ariaProperty aps

        MFilled b ->
            booExpr "filled" b

        MBlend bm ->
            [ ( "blend", blendModeSpec bm ) ]

        MClip b ->
            booExpr "clip" b

        MColor s ->
            case s of
                NoStr ->
                    [ ( "color", JE.null ) ]

                Str clr ->
                    if String.trim clr == "" then
                        [ ( "color", JE.null ) ]

                    else
                        strExpr "color" s

                _ ->
                    strExpr "color" s

        MCornerRadius n ->
            numExpr "cornerRadius" n

        MCornerRadiusEnd n ->
            numExpr "cornerRadiusEnd" n

        MCornerRadiusBL n ->
            numExpr "cornerRadiusBottomLeft" n

        MCornerRadiusBR n ->
            numExpr "cornerRadiusBottomRight" n

        MCornerRadiusTL n ->
            numExpr "cornerRadiusTopLeft" n

        MCornerRadiusTR n ->
            numExpr "cornerRadiusTopRight" n

        MCursor cur ->
            [ ( "cursor", cursorSpec cur ) ]

        MExtent ext ->
            [ ( "extent", extentSpec ext ) ]

        MHRef s ->
            strExpr "href" s

        MRemoveInvalid bl ->
            case bl of
                Boo b ->
                    if b then
                        [ ( "invalid", JE.string "filter" ) ]

                    else
                        [ ( "invalid", JE.null ) ]

                _ ->
                    booExpr "invalid" bl

        MFill s ->
            case s of
                NoStr ->
                    [ ( "fill", JE.null ) ]

                Str clr ->
                    if String.trim clr == "" then
                        [ ( "fill", JE.null ) ]

                    else
                        strExpr "fill" s

                _ ->
                    strExpr "fill" s

        MFillGradient cGrad props ->
            [ ( "fill"
              , JE.object
                    (( "gradient", JE.string (colorGradientLabel cGrad) )
                        :: List.map gradientProperty props
                    )
              )
            ]

        MColorGradient cGrad props ->
            [ ( "color"
              , JE.object
                    (( "gradient", JE.string (colorGradientLabel cGrad) )
                        :: List.map gradientProperty props
                    )
              )
            ]

        MStrokeGradient cGrad props ->
            [ ( "stroke"
              , JE.object
                    (( "gradient", JE.string (colorGradientLabel cGrad) )
                        :: List.map gradientProperty props
                    )
              )
            ]

        MStroke s ->
            case s of
                NoStr ->
                    [ ( "stroke", JE.null ) ]

                Str clr ->
                    if String.trim clr == "" then
                        [ ( "stroke", JE.null ) ]

                    else
                        strExpr "stroke" s

                _ ->
                    strExpr "stroke" s

        MStrokeCap sc ->
            [ ( "strokeCap", strokeCapSpec sc ) ]

        MStrokeJoin sj ->
            [ ( "strokeJoin", strokeJoinSpec sj ) ]

        MStrokeMiterLimit n ->
            numExpr "strokeMiterLimit" n

        MOpacity n ->
            numExpr "opacity" n

        MFillOpacity n ->
            numExpr "fillOpacity" n

        MStrokeOpacity n ->
            numExpr "strokeOpacity" n

        MStrokeWidth n ->
            numExpr "strokeWidth" n

        MStrokeDash ns ->
            numsExpr "strokeDash" ns

        MStrokeDashOffset n ->
            numExpr "strokeDashOffset" n

        MStyle styles ->
            [ ( "style", JE.list JE.string styles ) ]

        MInterpolate interp ->
            [ ( "interpolate", markInterpolationSpec interp ) ]

        MTension n ->
            numExpr "tension" n

        MOrient orient ->
            [ ( "orient", JE.string (markOrientationLabel orient) ) ]

        MShape sym ->
            [ ( "shape", symbolSpec sym ) ]

        MSize n ->
            numExpr "size" n

        MAngle n ->
            numExpr "angle" n

        MAlign al ->
            [ ( "align", hAlignSpec al ) ]

        MBaseline va ->
            [ ( "baseline", vAlignSpec va ) ]

        MdX n ->
            numExpr "dx" n

        MdY n ->
            numExpr "dy" n

        MFont s ->
            strExpr "font" s

        MFontSize n ->
            numExpr "fontSize" n

        MFontStyle s ->
            strExpr "fontStyle" s

        MFontWeight w ->
            [ ( "fontWeight", fontWeightSpec w ) ]

        MRadius n ->
            numExpr "radius" n

        MInnerRadius n ->
            numExpr "innerRadius" n

        MOuterRadius n ->
            numExpr "outerRadius" n

        MPadAngle n ->
            numExpr "padAngle" n

        MText s ->
            strExprMultiline "text" s

        MLineHeight n ->
            numExpr "lineHeight" n

        MLimit n ->
            numExpr "limit" n

        MEllipsis s ->
            strExpr "ellipsis" s

        MDir td ->
            [ ( "dir", textDirectionSpec td ) ]

        MTheta n ->
            numExpr "theta" n

        MTheta2 n ->
            numExpr "theta2" n

        MThetaOffset n ->
            numExpr "thetaOffset" n

        MTheta2Offset n ->
            numExpr "theta2Offset" n

        MBinSpacing n ->
            numExpr "binSpacing" n

        MContinuousBandSize n ->
            numExpr "continuousBandSize" n

        MDiscreteBandSize n ->
            numExpr "discreteBandSize" n

        MShortTimeLabels b ->
            booExpr "shortTimeLabels" b

        MBandSize n ->
            numExpr "bandSize" n

        MThickness n ->
            numExpr "thickness" n

        MRule props ->
            case props of
                [] ->
                    [ ( "rule", JE.bool False ) ]

                _ ->
                    [ ( "rule", JE.object (List.concatMap markProperty props) ) ]

        MBorders props ->
            [ ( "borders", JE.object (List.concatMap markProperty props) ) ]

        MMedian props ->
            case props of
                [] ->
                    [ ( "median", JE.bool False ) ]

                _ ->
                    [ ( "median", JE.object (List.concatMap markProperty props) ) ]

        MBox props ->
            case props of
                [] ->
                    [ ( "box", JE.bool False ) ]

                _ ->
                    [ ( "box", JE.object (List.concatMap markProperty props) ) ]

        MOutliers props ->
            case props of
                [] ->
                    [ ( "outliers", JE.bool False ) ]

                _ ->
                    [ ( "outliers", JE.object (List.concatMap markProperty props) ) ]

        MTicks props ->
            [ ( "ticks", JE.object (List.concatMap markProperty props) ) ]

        MTooltip ttContent ->
            if ttContent == TTNone then
                [ ( "tooltip", JE.null ) ]

            else
                [ ( "tooltip", JE.object [ ( "content", ttContentSpec ttContent ) ] ) ]

        MPoint pm ->
            [ ( "point", pointMarkerSpec pm ) ]

        MLine lm ->
            [ ( "line", lineMarkerSpec lm ) ]

        MWidth n ->
            numExpr "width" n

        MHeight n ->
            numExpr "height" n

        MX n ->
            numExpr "x" n

        MY n ->
            numExpr "y" n

        MX2 n ->
            numExpr "x2" n

        MY2 n ->
            numExpr "y2" n

        MOrder b ->
            booExpr "order" b

        MXOffset n ->
            numExpr "xOffset" n

        MX2Offset n ->
            numExpr "x2Offset" n

        MYOffset n ->
            numExpr "yOffset" n

        MY2Offset n ->
            numExpr "y2Offset" n

        MRadiusOffset n ->
            numExpr "radiusOffset" n

        MRadius2Offset n ->
            numExpr "radius2Offset" n

        MAspect b ->
            booExpr "aspect" b


maybeNumExpr : String -> MaybeNum -> List ( String, Spec )
maybeNumExpr objName n =
    case n of
        MaybeNum maybeX ->
            case maybeX of
                Just x ->
                    if x == 1 then
                        [ ( objName, JE.bool True ) ]

                    else
                        [ ( objName, JE.float x ) ]

                Nothing ->
                    [ ( objName, JE.bool False ) ]

        MaybeNumExpr s ->
            [ ( objName, JE.object [ ( "expr", JE.string s ) ] ) ]


measurementLabel : Measurement -> String
measurementLabel mType =
    case mType of
        Nominal ->
            "nominal"

        Ordinal ->
            "ordinal"

        Quantitative ->
            "quantitative"

        Temporal ->
            "temporal"

        -- Vega-Lite has a 'geojson' type for geographically referenced shape
        -- features, which here is renamed to the more general `GeoFeature`.
        GeoFeature ->
            "geojson"


monthNameLabel : MonthName -> String
monthNameLabel mon =
    case mon of
        Jan ->
            "Jan"

        Feb ->
            "Feb"

        Mar ->
            "Mar"

        Apr ->
            "Apr"

        May ->
            "May"

        Jun ->
            "Jun"

        Jul ->
            "Jul"

        Aug ->
            "Aug"

        Sep ->
            "Sep"

        Oct ->
            "Oct"

        Nov ->
            "Nov"

        Dec ->
            "Dec"


multilineTextSpec : String -> Spec
multilineTextSpec tText =
    case String.split "\n" tText of
        [] ->
            JE.string ""

        [ s ] ->
            JE.string s

        ss ->
            JE.list JE.string ss


numExpr : String -> Num -> List ( String, Spec )
numExpr objName n =
    case n of
        Num x ->
            [ ( objName, JE.float x ) ]

        NoNum ->
            [ ( objName, JE.null ) ]

        NumExpr s ->
            [ ( objName, JE.object [ ( "expr", JE.string s ) ] ) ]


numsExpr : String -> Nums -> List ( String, Spec )
numsExpr objName ns =
    case ns of
        Nums xs ->
            [ ( objName, JE.list JE.float xs ) ]

        NumsExpr s ->
            [ ( objName, JE.object [ ( "expr", JE.string s ) ] ) ]


numStr : Num -> String
numStr n =
    case n of
        Num x ->
            String.fromFloat x

        NoNum ->
            "null"

        NumExpr s ->
            s


operationSpec : Operation -> Spec
operationSpec op =
    case op of
        ArgMax maybeField ->
            case maybeField of
                Nothing ->
                    JE.string "argmax"

                Just f ->
                    if String.length (String.trim f) == 0 then
                        JE.string "argmax"

                    else
                        JE.object [ ( "argmax", JE.string f ) ]

        ArgMin maybeField ->
            case maybeField of
                Nothing ->
                    JE.string "argmin"

                Just f ->
                    if String.length (String.trim f) == 0 then
                        JE.string "argmin"

                    else
                        JE.object [ ( "argmin", JE.string f ) ]

        Count ->
            JE.string "count"

        CI0 ->
            JE.string "ci0"

        CI1 ->
            JE.string "ci1"

        Distinct ->
            JE.string "distinct"

        Max ->
            JE.string "max"

        Mean ->
            JE.string "mean"

        Median ->
            JE.string "median"

        Min ->
            JE.string "min"

        Missing ->
            JE.string "missing"

        Product ->
            JE.string "product"

        Q1 ->
            JE.string "q1"

        Q3 ->
            JE.string "q3"

        Stdev ->
            JE.string "stdev"

        StdevP ->
            JE.string "stdevp"

        Sum ->
            JE.string "sum"

        Stderr ->
            JE.string "stderr"

        Valid ->
            JE.string "valid"

        Variance ->
            JE.string "variance"

        VarianceP ->
            JE.string "variancep"


orderChannelProperties : OrderChannel -> List LabelledSpec
orderChannelProperties oDef =
    case oDef of
        OName s ->
            [ ( "field", JE.string s ) ]

        ORepeat arr ->
            [ ( "field", JE.object [ ( "repeat", JE.string (arrangementLabel arr) ) ] ) ]

        OmType measure ->
            [ ( "type", JE.string (measurementLabel measure) ) ]

        OBin bps ->
            [ bin bps ]

        OAggregate op ->
            [ ( "aggregate", operationSpec op ) ]

        OTimeUnit tu ->
            [ ( "timeUnit", timeUnitSpec tu ) ]

        OSort sps ->
            case sps of
                [] ->
                    [ ( "sort", JE.null ) ]

                [ Ascending ] ->
                    [ ( "sort", JE.string "ascending" ) ]

                [ Descending ] ->
                    [ ( "sort", JE.string "descending" ) ]

                [ CustomSort dvs ] ->
                    [ ( "sort", dataValuesSpecs dvs ) ]

                _ ->
                    [ ( "sort", JE.object (List.concatMap sortProperties sps) ) ]

        ONumber n ->
            [ ( "value", JE.float n ) ]

        OCondition predicate ifClause elseClause ->
            ( "condition", JE.object (predicateProperties predicate ++ List.concatMap orderChannelProperties ifClause) )
                :: List.concatMap orderChannelProperties elseClause

        OConditions ifClauses elseClause ->
            ( "condition"
            , JE.list
                (\( predicate, ifClause ) ->
                    JE.object (predicateProperties predicate ++ List.concatMap orderChannelProperties ifClause)
                )
                ifClauses
            )
                :: List.concatMap orderChannelProperties elseClause

        ODataCondition isSelection tests elseClause ->
            let
                testClause ( predicate, ifClause ) =
                    if isSelection then
                        JE.object
                            (( "selection", booleanOpSpec predicate )
                                :: List.concatMap orderChannelProperties ifClause
                            )

                    else
                        JE.object
                            (( "test", booleanOpSpec predicate )
                                :: List.concatMap orderChannelProperties ifClause
                            )
            in
            ( "condition"
            , case tests of
                [ test ] ->
                    testClause test

                _ ->
                    JE.list testClause tests
            )
                :: List.concatMap orderChannelProperties elseClause


overlapStrategySpec : OverlapStrategy -> Spec
overlapStrategySpec strat =
    case strat of
        ONone ->
            JE.bool False

        OParity ->
            JE.string "parity"

        OGreedy ->
            JE.string "greedy"

        OverlapExpr s ->
            JE.object [ ( "expr", JE.string s ) ]


paddingSpec : Padding -> Spec
paddingSpec pad =
    case pad of
        PSize p ->
            JE.float p

        PEdges l t r b ->
            JE.object
                [ ( "left", JE.float l )
                , ( "top", JE.float t )
                , ( "right", JE.float r )
                , ( "bottom", JE.float b )
                ]

        PEdgesExpr l t r b ->
            JE.object [ ( "expr", "{'left':" ++ l ++ ",'top':" ++ t ++ ",'right':" ++ r ++ ",'bottom':" ++ b ++ "}" |> JE.string ) ]

        PSizeExpr s ->
            JE.object [ ( "expr", JE.string s ) ]


paramProperty : ParamProperty -> LabelledSpec
paramProperty pp =
    case pp of
        PBind bps ->
            ( "bind", JE.object (pBindingProperties bps) )

        PBindings binds ->
            ( "bind"
            , JE.object
                (List.map
                    (\( bName, bps ) ->
                        ( bName, JE.object (pBindingProperties bps) )
                    )
                    binds
                )
            )

        PBindScales ->
            ( "bind", JE.string "scales" )

        PBindLegend s ->
            if (String.trim s |> String.length) == 0 then
                ( "bind", JE.string "legend" )

            else
                ( "bind", JE.object [ ( "legend", JE.string s ) ] )

        PExpr s ->
            ( "expr", JE.string s )

        PValue d ->
            ( "value", dataValueSpec d )

        PValues ds ->
            ( "value", dataValuesSpecs ds )

        PSelect s sps ->
            case sps of
                [] ->
                    ( "select", JE.string (selectionLabel s) )

                _ ->
                    ( "select", JE.object (( "type", JE.string (selectionLabel s) ) :: List.concatMap selectionProperties sps) )


pBindingProperties : PBinding -> List LabelledSpec
pBindingProperties bnd =
    case bnd of
        IPRange props ->
            ( "input", JE.string "range" ) :: List.map inputProperty props

        IPCheckbox props ->
            ( "input", JE.string "checkbox" ) :: List.map inputProperty props

        IPRadio props ->
            ( "input", JE.string "radio" ) :: List.map inputProperty props

        IPSelect props ->
            ( "input", JE.string "select" ) :: List.map inputProperty props

        IPText props ->
            ( "input", JE.string "text" ) :: List.map inputProperty props

        IPNumber props ->
            ( "input", JE.string "number" ) :: List.map inputProperty props

        IPDate props ->
            ( "input", JE.string "date" ) :: List.map inputProperty props

        IPTime props ->
            ( "input", JE.string "time" ) :: List.map inputProperty props

        IPMonth props ->
            ( "input", JE.string "month" ) :: List.map inputProperty props

        IPWeek props ->
            ( "input", JE.string "week" ) :: List.map inputProperty props

        IPDateTimeLocal props ->
            ( "input", JE.string "datetimelocal" ) :: List.map inputProperty props

        IPTel props ->
            ( "input", JE.string "tel" ) :: List.map inputProperty props

        IPColor props ->
            ( "input", JE.string "color" ) :: List.map inputProperty props


pivotProperty : PivotProperty -> LabelledSpec
pivotProperty pp =
    case pp of
        PiGroupBy fields ->
            ( "groupby", JE.list JE.string fields )

        PiLimit n ->
            ( "limit", JE.int n )

        PiOp op ->
            ( "op", operationSpec op )


pointMarkerSpec : PointMarker -> Spec
pointMarkerSpec pm =
    case pm of
        PMTransparent ->
            JE.string "transparent"

        PMNone ->
            JE.bool False

        PMMarker mps ->
            if mps == [] then
                JE.bool True

            else
                JE.object (List.concatMap markProperty mps)


positiveAngle : Float -> Float
positiveAngle a =
    if a < 0 then
        a + 360

    else
        a


positionChannelProperty : PositionChannel -> LabelledSpec
positionChannelProperty pDef =
    case pDef of
        PName s ->
            ( "field", JE.string s )

        PDatum d ->
            ( "datum", dataValueSpec d )

        PmType measure ->
            ( "type", JE.string (measurementLabel measure) )

        PBin bps ->
            bin bps

        PBinned ->
            ( "bin", JE.string "binned" )

        PAggregate op ->
            ( "aggregate", operationSpec op )

        PTimeUnit tu ->
            ( "timeUnit", timeUnitSpec tu )

        PTitle t ->
            ( "title", multilineTextSpec t )

        PSort sps ->
            case sps of
                [] ->
                    ( "sort", JE.null )

                [ Ascending ] ->
                    ( "sort", JE.string "ascending" )

                [ Descending ] ->
                    ( "sort", JE.string "descending" )

                [ CustomSort dvs ] ->
                    ( "sort", dataValuesSpecs dvs )

                _ ->
                    ( "sort", JE.object (List.concatMap sortProperties sps) )

        PBandPosition x ->
            ( "bandPosition", JE.float x )

        PScale sps ->
            if sps == [] then
                ( "scale", JE.null )

            else
                ( "scale", JE.object (List.concatMap scaleProperty sps) )

        PAxis aps ->
            if aps == [] then
                ( "axis", JE.null )

            else
                ( "axis", JE.object (List.concatMap axisProperty aps) )

        PStack so ->
            stackOffsetProperty so

        PRepeat arr ->
            ( "field", JE.object [ ( "repeat", JE.string (arrangementLabel arr) ) ] )

        PWidth ->
            ( "value", JE.string "width" )

        PHeight ->
            ( "value", JE.string "height" )

        PNumber x ->
            ( "value", JE.float x )

        PImpute ips ->
            ( "impute", JE.object (List.map imputeProperty ips) )


positionLabel : Position -> String
positionLabel pChannel =
    case pChannel of
        X ->
            "x"

        Y ->
            "y"

        X2 ->
            "x2"

        Y2 ->
            "y2"

        Theta ->
            "theta"

        Theta2 ->
            "theta2"

        R ->
            "radius"

        R2 ->
            "radius2"

        XError ->
            "xError"

        YError ->
            "yError"

        XError2 ->
            "xError2"

        YError2 ->
            "yError2"

        Longitude ->
            "longitude"

        Latitude ->
            "latitude"

        Longitude2 ->
            "longitude2"

        Latitude2 ->
            "latitude2"


predicateProperties : Predicate -> List LabelledSpec
predicateProperties predicate =
    case predicate of
        Param p ->
            [ ( "param", JE.string p ) ]

        ParamEmpty p ->
            [ ( "param", JE.string p ), ( "empty", JE.bool False ) ]

        Test bo ->
            [ ( "test", booleanOpSpec bo ) ]


projectionSpec : Projection -> Spec
projectionSpec proj =
    case proj of
        Albers ->
            JE.string "albers"

        AlbersUsa ->
            JE.string "albersUsa"

        AzimuthalEqualArea ->
            JE.string "azimuthalEqualArea"

        AzimuthalEquidistant ->
            JE.string "azimuthalEquidistant"

        ConicConformal ->
            JE.string "conicConformal"

        ConicEqualArea ->
            JE.string "conicEqualarea"

        ConicEquidistant ->
            JE.string "conicEquidistant"

        Custom projName ->
            JE.string projName

        EqualEarth ->
            JE.string "equalEarth"

        Equirectangular ->
            JE.string "equirectangular"

        Gnomonic ->
            JE.string "gnomonic"

        Identity ->
            JE.string "identity"

        Mercator ->
            JE.string "mercator"

        NaturalEarth1 ->
            JE.string "naturalEarth1"

        Orthographic ->
            JE.string "orthographic"

        Stereographic ->
            JE.string "stereographic"

        TransverseMercator ->
            JE.string "transverseMercator"

        ProjectionExpr s ->
            JE.object [ ( "expr", JE.string s ) ]


projectionProperty : ProjectionProperty -> List LabelledSpec
projectionProperty pp =
    case pp of
        PrType proj ->
            [ ( "type", projectionSpec proj ) ]

        PrClipAngle n ->
            case n of
                Num x ->
                    if x > 0 then
                        numExpr "clipAngle" n

                    else
                        [ ( "clipAngle", JE.null ) ]

                NoNum ->
                    [ ( "clipAngle", JE.null ) ]

                NumExpr _ ->
                    numExpr "clipAngle" n

        PrClipExtent rClip ->
            case rClip of
                NoClip ->
                    [ ( "clipExtent", JE.null ) ]

                LTRB l t r b ->
                    [ ( "clipExtent", JE.list (JE.list JE.float) [ [ l, t ], [ r, b ] ] ) ]

                ClipRectExpr l t r b ->
                    [ ( "clipExtent"
                      , JE.object
                            [ ( "expr"
                              , JE.string ("[[" ++ l ++ "," ++ t ++ "],[" ++ r ++ "," ++ b ++ "]]")
                              )
                            ]
                      )
                    ]

        PrReflectX b ->
            booExpr "reflectX" b

        PrReflectY b ->
            booExpr "reflectY" b

        PrCenter lambda phi ->
            [ ( "center"
              , JE.object [ ( "expr", "[" ++ numStr lambda ++ "," ++ numStr phi ++ "]" |> JE.string ) ]
              )
            ]

        PrScale x ->
            numExpr "scale" x

        PrTranslate tx ty ->
            [ ( "translate"
              , JE.object [ ( "expr", "[" ++ numStr tx ++ "," ++ numStr ty ++ "]" |> JE.string ) ]
              )
            ]

        PrRotate lambda phi gamma ->
            [ ( "rotate"
              , JE.object [ ( "expr", "[" ++ numStr lambda ++ "," ++ numStr phi ++ "," ++ numStr gamma ++ "]" |> JE.string ) ]
              )
            ]

        PrPointRadius x ->
            numExpr "pointRadius" x

        PrPrecision x ->
            numExpr "precision" x

        PrCoefficient x ->
            numExpr "coefficient" x

        PrDistance x ->
            numExpr "distance" x

        PrFraction x ->
            numExpr "fraction" x

        PrLobes n ->
            numExpr "lobes" n

        PrParallel lat ->
            numExpr "parallel" lat

        PrParallels lat1 lat2 ->
            [ ( "parallels"
              , JE.object
                    [ ( "expr", "[" ++ numStr lat1 ++ "," ++ numStr lat2 ++ "]" |> JE.string ) ]
              )
            ]

        PrRadius x ->
            numExpr "radius" x

        PrRatio x ->
            numExpr "ratio" x

        PrSpacing x ->
            numExpr "spacing" x

        PrTilt x ->
            numExpr "tilt" x


quantileProperty : QuantileProperty -> LabelledSpec
quantileProperty qProp =
    case qProp of
        QtGroupBy fields ->
            ( "groupby", JE.list JE.string fields )

        QtProbs xs ->
            ( "probs", JE.list JE.float xs )

        QtStep x ->
            ( "step", JE.float x )

        QtAs pStr vStr ->
            ( "as", JE.list JE.string [ pStr, vStr ] )


rangeConfigProperty : RangeConfig -> LabelledSpec
rangeConfigProperty rangeCfg =
    case rangeCfg of
        RCategory schemeName ->
            ( "category", JE.object [ schemeProperty schemeName False [] ] )

        RDiverging schemeName ->
            ( "diverging", JE.object [ schemeProperty schemeName False [] ] )

        RHeatmap schemeName ->
            ( "heatmap", JE.object [ schemeProperty schemeName False [] ] )

        ROrdinal schemeName ->
            ( "ordinal", JE.object [ schemeProperty schemeName False [] ] )

        RRamp schemeName ->
            ( "ramp", JE.object [ schemeProperty schemeName False [] ] )

        RSymbol schemeName ->
            ( "symbol", JE.object [ schemeProperty schemeName False [] ] )


regMethodLabel : RegressionMethod -> String
regMethodLabel rm =
    case rm of
        RgLinear ->
            "linear"

        RgLog ->
            "log"

        RgExp ->
            "exp"

        RgPow ->
            "pow"

        RgQuad ->
            "quad"

        RgPoly ->
            "poly"


regressionProperty : RegressionProperty -> LabelledSpec
regressionProperty regProp =
    case regProp of
        RgGroupBy fields ->
            ( "groupby", JE.list JE.string fields )

        RgMethod m ->
            ( "method", JE.string (regMethodLabel m) )

        RgOrder n ->
            ( "order", JE.int n )

        RgExtent mn mx ->
            ( "extent", JE.list JE.float [ mn, mx ] )

        RgParams b ->
            ( "params", JE.bool b )

        RgAs iField dField ->
            ( "as", JE.list JE.string [ iField, dField ] )


repeatFieldsProperty : RepeatFields -> LabelledSpec
repeatFieldsProperty fields =
    case fields of
        RowFields fs ->
            ( "row", JE.list JE.string fs )

        ColumnFields fs ->
            ( "column", JE.list JE.string fs )

        LayerFields fs ->
            ( "layer", JE.list JE.string fs )


resolutionLabel : Resolution -> String
resolutionLabel res =
    case res of
        RShared ->
            "shared"

        RIndependent ->
            "independent"


resolveProperty : Resolve -> LabelledSpec
resolveProperty res =
    case res of
        RAxis chRules ->
            --( "axis", JE.object [ ( channelLabel ch, JE.string (resolutionLabel rule) ) ] )
            ( "axis", JE.object <| List.map (\( ch, chRule ) -> ( channelLabel ch, JE.string (resolutionLabel chRule) )) chRules )

        RLegend chRules ->
            --( "legend", JE.object [ ( channelLabel ch, JE.string (resolutionLabel rule) ) ] )
            ( "legend", JE.object <| List.map (\( ch, chRule ) -> ( channelLabel ch, JE.string (resolutionLabel chRule) )) chRules )

        RScale chRules ->
            --( "scale", JE.object [ ( channelLabel ch, JE.string (resolutionLabel rule) ) ] )
            ( "scale", JE.object <| List.map (\( ch, chRule ) -> ( channelLabel ch, JE.string (resolutionLabel chRule) )) chRules )


scaleConfigProperty : ScaleConfig -> LabelledSpec
scaleConfigProperty scaleCfg =
    case scaleCfg of
        SCBandPaddingInner x ->
            ( "bandPaddingInner", JE.float x )

        SCBandPaddingOuter x ->
            ( "bandPaddingOuter", JE.float x )

        SCBarBandPaddingInner x ->
            ( "barBandPaddingInner", JE.float x )

        SCBarBandPaddingOuter x ->
            ( "barBandPaddingOuter", JE.float x )

        SCRectBandPaddingInner x ->
            ( "rectBandPaddingInner", JE.float x )

        SCRectBandPaddingOuter x ->
            ( "rectBandPaddingOuter", JE.float x )

        SCClamp b ->
            ( "clamp", JE.bool b )

        SCMaxBandSize x ->
            ( "maxBandSize", JE.float x )

        SCMinBandSize x ->
            ( "minBandSize", JE.float x )

        SCMaxFontSize x ->
            ( "maxFontSize", JE.float x )

        SCMinFontSize x ->
            ( "minFontSize", JE.float x )

        SCMaxOpacity x ->
            ( "maxOpacity", JE.float x )

        SCMinOpacity x ->
            ( "minOpacity", JE.float x )

        SCMaxSize x ->
            ( "maxSize", JE.float x )

        SCMinSize x ->
            ( "minSize", JE.float x )

        SCMaxStrokeWidth x ->
            ( "maxStrokeWidth", JE.float x )

        SCMinStrokeWidth x ->
            ( "minStrokeWidth", JE.float x )

        SCPointPadding x ->
            ( "pointPadding", JE.float x )

        SCRound b ->
            ( "round", JE.bool b )

        SCUseUnaggregatedDomain b ->
            ( "useUnaggregatedDomain", JE.bool b )

        SCXReverse b ->
            ( "xReverse", JE.bool b )


scaleDomainSpec : ScaleDomain -> Spec
scaleDomainSpec sdType =
    let
        numSpec n =
            case n of
                Num x ->
                    JE.float x

                NoNum ->
                    JE.null

                NumExpr s ->
                    JE.object [ ( "expr", JE.string s ) ]

        numsSpec ns =
            case ns of
                Nums xs ->
                    JE.list JE.float xs

                NumsExpr s ->
                    JE.object [ ( "expr", JE.string s ) ]
    in
    case sdType of
        DNumbers xs ->
            numsSpec xs

        DMinNumber x ->
            numSpec x

        DMidNumber x ->
            numSpec x

        DMaxNumber x ->
            numSpec x

        DDateTimes ds ->
            JE.list (\d -> JE.object (List.map dateTimeProperty d)) ds

        DDateTimesExpr s ->
            JE.object [ ( "expr", JE.string s ) ]

        DMinDateTime ts ->
            case ts of
                Timestamp d ->
                    JE.object (List.map dateTimeProperty d)

                TimestampExpr s ->
                    JE.object [ ( "expr", JE.string s ) ]

        DMaxDateTime ts ->
            case ts of
                Timestamp d ->
                    JE.object (List.map dateTimeProperty d)

                TimestampExpr s ->
                    JE.object [ ( "expr", JE.string s ) ]

        DStrings cats ->
            JE.list JE.string cats

        DSelection selName ->
            JE.object [ ( "param", JE.string selName ) ]

        DSelectionChannel selName ch ->
            JE.object
                [ ( "param", JE.string selName )
                , ( "encoding", JE.string (channelLabel ch) )
                ]

        DSelectionField selName f ->
            JE.object
                [ ( "param", JE.string selName )
                , ( "field", JE.string f )
                ]

        Unaggregated ->
            JE.string "unaggregated"

        DUnionWith scDo ->
            JE.object [ ( "unionWith", scaleDomainSpec scDo ) ]


scaleLabel : Scale -> String
scaleLabel sc =
    case sc of
        ScLinear ->
            "linear"

        ScPow ->
            "pow"

        ScSymLog ->
            "symlog"

        ScSqrt ->
            "sqrt"

        ScLog ->
            "log"

        ScTime ->
            "time"

        ScUtc ->
            "utc"

        ScOrdinal ->
            "ordinal"

        ScBand ->
            "band"

        ScPoint ->
            "point"

        ScBinOrdinal ->
            "bin-ordinal"

        ScQuantile ->
            "quantile"

        ScQuantize ->
            "quantize"

        ScThreshold ->
            "threshold"


scaleNiceSpec : ScaleNice -> Spec
scaleNiceSpec ni =
    case ni of
        NMillisecond ->
            JE.string "millisecond"

        NSecond ->
            JE.string "second"

        NMinute ->
            JE.string "minute"

        NHour ->
            JE.string "hour"

        NDay ->
            JE.string "day"

        NWeek ->
            JE.string "week"

        NMonth ->
            JE.string "month"

        NYear ->
            JE.string "year"

        NInterval tu step ->
            JE.object [ ( "interval", JE.string (timeUnitLabel tu) ), ( "step", JE.int step ) ]

        NTrue ->
            JE.bool True

        NFalse ->
            JE.bool False

        NTickCount n ->
            JE.int n

        NExpr s ->
            JE.object [ ( "expr", JE.string s ) ]


scaleProperty : ScaleProperty -> List LabelledSpec
scaleProperty scaleProp =
    case scaleProp of
        SType sType ->
            [ ( "type", JE.string (scaleLabel sType) ) ]

        SDomainExpr s ->
            [ ( "domain", JE.object [ ( "expr", JE.string s ) ] ) ]

        SDomain sdType ->
            case sdType of
                DMinNumber x ->
                    numExpr "domainMin" x

                DMidNumber x ->
                    numExpr "domainMid" x

                DMaxNumber x ->
                    numExpr "domainMax" x

                DMinDateTime ts ->
                    case ts of
                        Timestamp d ->
                            [ ( "domainMin", JE.object (List.map dateTimeProperty d) ) ]

                        TimestampExpr s ->
                            [ ( "domainMin", JE.object [ ( "expr", JE.string s ) ] ) ]

                DMaxDateTime ts ->
                    case ts of
                        Timestamp d ->
                            [ ( "domainMax", JE.object (List.map dateTimeProperty d) ) ]

                        TimestampExpr s ->
                            [ ( "domainMax", JE.object [ ( "expr", JE.string s ) ] ) ]

                _ ->
                    [ ( "domain", scaleDomainSpec sdType ) ]

        SRange range ->
            case range of
                RMinNumber x ->
                    numExpr "rangeMin" x

                RMaxNumber x ->
                    numExpr "rangeMax" x

                -- TODO: Pending confirmation of https://github.com/vega/vega-lite/issues/6758
                -- RMinString s ->
                --     [( "rangeMin", JE.string s )]
                -- strExpr "rangeMin" s
                --
                -- RMaxString s ->
                --     [( "rangeMax", JE.string s )]
                -- strExpr "rangeMax" s
                RNumbers xs ->
                    numsExpr "range" xs

                RExprs ss ->
                    [ ( "range", JE.list (\s -> JE.object [ ( "expr", JE.string s ) ]) ss ) ]

                RNumberLists xss ->
                    [ ( "range", JE.list (JE.list JE.float) xss ) ]

                RStrings ss ->
                    strsExpr "range" ss

                RName s ->
                    [ ( "range", JE.string s ) ]

                RField s ->
                    [ ( "range", JE.object [ ( "field", JE.string s ) ] ) ]

        SScheme schName extent ->
            [ schemeProperty schName False extent ]

        SSchemeExpr schExpr extent ->
            [ schemeProperty schExpr True extent ]

        SAlign x ->
            [ ( "align", JE.float x ) ]

        SPadding x ->
            [ ( "padding", JE.float x ) ]

        SBase x ->
            [ ( "base", JE.float x ) ]

        SExponent x ->
            [ ( "exponent", JE.float x ) ]

        SDomainMid x ->
            [ ( "domainMid", JE.float x ) ]

        SConstant x ->
            [ ( "constant", JE.float x ) ]

        SPaddingInner x ->
            [ ( "paddingInner", JE.float x ) ]

        SPaddingOuter x ->
            [ ( "paddingOuter", JE.float x ) ]

        SRound b ->
            booExpr "round" b

        SClamp b ->
            booExpr "clamp" b

        SInterpolate interp ->
            [ ( "interpolate", cInterpolateSpec interp ) ]

        SNice ni ->
            [ ( "nice", scaleNiceSpec ni ) ]

        SZero b ->
            booExpr "zero" b

        SReverse b ->
            booExpr "reverse" b


schemeProperty : String -> Bool -> List Float -> LabelledSpec
schemeProperty schName isExpr extent =
    let
        nameSpec =
            if isExpr then
                JE.object [ ( "expr", JE.string schName ) ]

            else
                JE.string schName
    in
    case extent of
        [] ->
            ( "scheme", nameSpec )

        [ n ] ->
            ( "scheme", JE.object [ ( "name", nameSpec ), ( "count", JE.float n ) ] )

        [ mn, mx ] ->
            ( "scheme", JE.object [ ( "name", nameSpec ), ( "extent", JE.list JE.float [ mn, mx ] ) ] )

        _ ->
            -- |> Debug.log ("scScheme should have 0, 1 or 2 numbers but you provided " ++ Debug.toString extent)
            ( "scheme", nameSpec )


selectionLabel : Selection -> String
selectionLabel seType =
    case seType of
        SePoint ->
            "point"

        SeInterval ->
            "interval"

        SeSingle ->
            "single"

        SeMulti ->
            "multi"


selectionMarkProperty : SelectionMarkProperty -> LabelledSpec
selectionMarkProperty markProp =
    case markProp of
        SMFill colour ->
            ( "fill", JE.string colour )

        SMFillOpacity x ->
            ( "fillOpacity", JE.float x )

        SMStroke colour ->
            ( "stroke", JE.string colour )

        SMStrokeOpacity x ->
            ( "strokeOpacity", JE.float x )

        SMStrokeWidth x ->
            ( "strokeWidth", JE.float x )

        SMStrokeDash xs ->
            ( "strokeDash", JE.list JE.float xs )

        SMStrokeDashOffset x ->
            ( "strokeDashOffset", JE.float x )

        SMCursor cur ->
            ( "cursor", cursorSpec cur )


selectionProperties : SelectionProperty -> List LabelledSpec
selectionProperties selProp =
    case selProp of
        Fields fNames ->
            [ ( "fields", JE.list JE.string fNames ) ]

        SInit iVals ->
            [ ( "init", JE.object (List.map (Tuple.mapSecond dataValueSpec) iVals) ) ]

        SInitInterval maybeX maybeY ->
            let
                xExtent =
                    if maybeX == Just ( NullValue, NullValue ) then
                        Nothing

                    else
                        maybeX

                yExtent =
                    if maybeY == Just ( NullValue, NullValue ) then
                        Nothing

                    else
                        maybeY
            in
            case ( xExtent, yExtent ) of
                ( Just ( xMin, xMax ), Just ( yMin, yMax ) ) ->
                    [ ( "init"
                      , JE.object
                            [ ( "x", toList [ dataValueSpec xMin, dataValueSpec xMax ] )
                            , ( "y", toList [ dataValueSpec yMin, dataValueSpec yMax ] )
                            ]
                      )
                    ]

                ( Just ( xMin, xMax ), Nothing ) ->
                    [ ( "init"
                      , JE.object [ ( "x", toList [ dataValueSpec xMin, dataValueSpec xMax ] ) ]
                      )
                    ]

                ( Nothing, Just ( yMin, yMax ) ) ->
                    [ ( "init"
                      , JE.object [ ( "y", toList [ dataValueSpec yMin, dataValueSpec yMax ] ) ]
                      )
                    ]

                ( Nothing, Nothing ) ->
                    [ ( "init", JE.null ) ]

        Encodings channels ->
            [ ( "encodings", JE.list (JE.string << channelLabel) channels ) ]

        On evStr ->
            [ ( "on", JE.string evStr ) ]

        Clear evStr ->
            case String.trim evStr of
                "" ->
                    [ ( "clear", JE.bool False ) ]

                evStrTrimmed ->
                    [ ( "clear", JE.string evStrTrimmed ) ]

        Empty ->
            [ ( "empty", JE.string "none" ) ]

        ResolveSelections res ->
            [ ( "resolve", JE.string (selectionResolutionLabel res) ) ]

        SelectionMark markProps ->
            [ ( "mark", JE.object (List.map selectionMarkProperty markProps) ) ]

        BindScales ->
            [ ( "bind", JE.string "scales" ) ]

        BindLegend blProps ->
            let
                labelledSpecs =
                    List.map bindLegendProperty blProps
            in
            if List.member "bind" (List.map Tuple.first labelledSpecs) then
                labelledSpecs

            else
                ( "bind", JE.string "legend" ) :: labelledSpecs

        Bind binds ->
            [ ( "bind", JE.object (List.map bindingProperty binds) ) ]

        Nearest b ->
            [ ( "nearest", JE.bool b ) ]

        Toggle tp ->
            [ ( "toggle", togglePredicateSpec tp ) ]

        Translate e ->
            if e == "" then
                [ ( "translate", JE.bool False ) ]

            else
                [ ( "translate", JE.string e ) ]

        Zoom e ->
            if e == "" then
                [ ( "zoom", JE.bool False ) ]

            else
                [ ( "zoom", JE.string e ) ]


selectionResolutionLabel : SelectionResolution -> String
selectionResolutionLabel res =
    case res of
        SeGlobal ->
            "global"

        SeUnion ->
            "union"

        SeIntersection ->
            "intersect"


sideSpec : Side -> Spec
sideSpec side =
    case side of
        STop ->
            JE.string "top"

        SBottom ->
            JE.string "bottom"

        SLeft ->
            JE.string "left"

        SRight ->
            JE.string "right"

        SExpr ex ->
            JE.object [ ( "expr", JE.string ex ) ]


sortFieldProperties : SortField -> List LabelledSpec
sortFieldProperties wsf =
    case wsf of
        WAscending f ->
            [ ( "field", JE.string f ), ( "order", JE.string "ascending" ) ]

        WDescending f ->
            [ ( "field", JE.string f ), ( "order", JE.string "descending" ) ]


sortProperties : SortProperty -> List LabelledSpec
sortProperties sp =
    case sp of
        Ascending ->
            [ ( "order", JE.string "ascending" ) ]

        Descending ->
            [ ( "order", JE.string "descending" ) ]

        ByChannel ch ->
            [ ( "encoding", JE.string (channelLabel ch) ) ]

        ByFieldOp field op ->
            [ ( "field", JE.string field ), ( "op", operationSpec op ) ]

        ByRepeatOp arr op ->
            [ ( "field", JE.object [ ( "repeat", JE.string (arrangementLabel arr) ) ] )
            , ( "op", operationSpec op )
            ]

        CustomSort _ ->
            -- |> Debug.log "Warning: Unexpected custom sorting provided to sortProperty"
            []


stackOffsetProperty : StackOffset -> LabelledSpec
stackOffsetProperty offset =
    ( "stack", stackOffsetSpec offset )


stackOffsetSpec : StackOffset -> Spec
stackOffsetSpec sp =
    case sp of
        OfZero ->
            JE.string "zero"

        OfNormalize ->
            JE.string "normalize"

        OfCenter ->
            JE.string "center"

        OfNone ->
            JE.null


stackProperty : StackProperty -> LabelledSpec
stackProperty sProp =
    case sProp of
        StOffset op ->
            ( "offset", stackOffsetSpec op )

        StSort sfs ->
            ( "sort", JE.list (sortFieldProperties >> JE.object) sfs )


strokeCapSpec : StrokeCap -> Spec
strokeCapSpec cap =
    case cap of
        CButt ->
            JE.string "butt"

        CRound ->
            JE.string "round"

        CSquare ->
            JE.string "square"

        CExpr s ->
            JE.object [ ( "expr", JE.string s ) ]


strokeJoinSpec : StrokeJoin -> Spec
strokeJoinSpec jn =
    case jn of
        JMiter ->
            JE.string "miter"

        JRound ->
            JE.string "round"

        JBevel ->
            JE.string "bevel"

        JExpr s ->
            JE.object [ ( "expr", JE.string s ) ]


stopSpec : ( Float, String ) -> Spec
stopSpec ( x, c ) =
    JE.object [ ( "offset", JE.float x ), ( "color", JE.string c ) ]


strExpr : String -> Str -> List ( String, Spec )
strExpr objName s =
    case s of
        Str x ->
            [ ( objName, JE.string x ) ]

        NoStr ->
            [ ( objName, JE.null ) ]

        StrExpr x ->
            [ ( objName, JE.object [ ( "expr", JE.string x ) ] ) ]


strExprMultiline : String -> Str -> List ( String, Spec )
strExprMultiline objName s =
    case s of
        Str x ->
            [ ( objName, multilineTextSpec x ) ]

        NoStr ->
            [ ( objName, JE.null ) ]

        StrExpr x ->
            [ ( objName, JE.object [ ( "expr", JE.string x ) ] ) ]


strsExpr : String -> Strs -> List ( String, Spec )
strsExpr objName ss =
    case ss of
        Strs xs ->
            [ ( objName, JE.list JE.string xs ) ]

        StrsExpr s ->
            [ ( objName, JE.object [ ( "expr", JE.string s ) ] ) ]


symbolLabel : Symbol -> String
symbolLabel sym =
    case sym of
        SymCircle ->
            "circle"

        SymSquare ->
            "square"

        SymCross ->
            "cross"

        SymDiamond ->
            "diamond"

        SymTriangleUp ->
            "triangle-up"

        SymTriangleDown ->
            "triangle-down"

        SymTriangleLeft ->
            "triangle-left"

        SymTriangleRight ->
            "triangle-right"

        SymTriangle ->
            "triangle"

        SymStroke ->
            "stroke"

        SymArrow ->
            "arrow"

        SymWedge ->
            "wedge"

        SymPath svgPath ->
            svgPath

        SymExpr s ->
            s


symbolSpec : Symbol -> Spec
symbolSpec sym =
    case sym of
        SymExpr s ->
            JE.object [ ( "expr", JE.string s ) ]

        _ ->
            JE.string (symbolLabel sym)


textChannelProperties : TextChannel -> List LabelledSpec
textChannelProperties tDef =
    case tDef of
        TName s ->
            [ ( "field", JE.string s ) ]

        TRepeat arr ->
            [ ( "field", JE.object [ ( "repeat", JE.string (arrangementLabel arr) ) ] ) ]

        TmType measure ->
            [ ( "type", JE.string (measurementLabel measure) ) ]

        TBin bps ->
            [ bin bps ]

        TBinned ->
            [ ( "bin", JE.string "binned" ) ]

        TAggregate op ->
            [ ( "aggregate", operationSpec op ) ]

        TTimeUnit tu ->
            [ ( "timeUnit", timeUnitSpec tu ) ]

        TTitle t ->
            [ ( "title", multilineTextSpec t ) ]

        TFormat fmt ->
            [ ( "format", JE.string fmt ) ]

        TFormatAsNum ->
            [ ( "formatType", JE.string "number" ) ]

        TFormatAsTemporal ->
            [ ( "formatType", JE.string "time" ) ]

        TFormatAsCustom formatter ->
            [ ( "formatType", JE.string formatter ) ]

        TCondition predicate ifClause elseClause ->
            ( "condition", JE.object (predicateProperties predicate ++ List.concatMap textChannelProperties ifClause) )
                :: List.concatMap textChannelProperties elseClause

        TConditions ifClauses elseClause ->
            ( "condition"
            , JE.list
                (\( predicate, ifClause ) ->
                    JE.object (predicateProperties predicate ++ List.concatMap textChannelProperties ifClause)
                )
                ifClauses
            )
                :: List.concatMap textChannelProperties elseClause

        TDataCondition isSelection tests elseClause ->
            let
                testClause ( predicate, ifClause ) =
                    if isSelection then
                        JE.object
                            (( "selection", booleanOpSpec predicate )
                                :: List.concatMap textChannelProperties ifClause
                            )

                    else
                        JE.object
                            (( "test", booleanOpSpec predicate )
                                :: List.concatMap textChannelProperties ifClause
                            )
            in
            ( "condition", JE.list testClause tests )
                :: List.concatMap textChannelProperties elseClause

        TString s ->
            [ ( "value", multilineTextSpec s ) ]

        TDatum d ->
            [ ( "datum", dataValueSpec d ) ]


textDirectionSpec : TextDirection -> Spec
textDirectionSpec td =
    case td of
        LeftToRight ->
            JE.string "ltr"

        RightToLeft ->
            JE.string "rtl"

        TDExpr s ->
            JE.object [ ( "expr", JE.string s ) ]


tfSpec : TitleFrame -> Spec
tfSpec tf =
    case tf of
        FrGroup ->
            JE.string "group"

        FrBounds ->
            JE.string "bounds"

        FrExpr s ->
            JE.object [ ( "expr", JE.string s ) ]


tickBandSpec : TickBand -> Spec
tickBandSpec tb =
    case tb of
        TBCenter ->
            JE.string "center"

        TBExtent ->
            JE.string "extent"

        TBExpr s ->
            JE.object [ ( "expr", JE.string s ) ]


timeUnitLabel : TimeUnit -> String
timeUnitLabel tu =
    case tu of
        Year ->
            "year"

        YearDayOfYear ->
            "yeardayofyear"

        YearQuarter ->
            "yearquarter"

        YearQuarterMonth ->
            "yearquartermonth"

        YearMonth ->
            "yearmonth"

        YearMonthDate ->
            "yearmonthdate"

        YearMonthDateHours ->
            "yearmonthdatehours"

        YearMonthDateHoursMinutes ->
            "yearmonthdatehoursminutes"

        YearMonthDateHoursMinutesSeconds ->
            "yearmonthdatehoursminutesseconds"

        YearWeek ->
            "yearweek"

        YearWeekDay ->
            "yearweekday"

        YearWeekDayHours ->
            "yearweekdayhours"

        YearWeekDayHoursMinutes ->
            "yearweekdayhoursminutes"

        YearWeekDayHoursMinutesSeconds ->
            "yearweekdayhoursminutesseconds"

        Quarter ->
            "quarter"

        QuarterMonth ->
            "quartermonth"

        Month ->
            "month"

        MonthDate ->
            "monthdate"

        MonthDateHours ->
            "monthdatehours"

        MonthDateHoursMinutes ->
            "monthdatehoursminutes"

        MonthDateHoursMinutesSeconds ->
            "monthdatehoursminutesseconds"

        Week ->
            "week"

        WeekDay ->
            "weekday"

        WeekDayHours ->
            "weekdayhours"

        WeekDayHoursMinutes ->
            "weekdayhoursminutes"

        WeekDayHoursMinutesSeconds ->
            "weekdayhoursminutesseconds"

        Date ->
            "date"

        Day ->
            "day"

        DayOfYear ->
            "dayofyear"

        DayHours ->
            "dayhours"

        DayHoursMinutes ->
            "dayhoursminutes"

        DayHoursMinutesSeconds ->
            "dayhoursminutesseconds"

        Hours ->
            "hours"

        HoursMinutes ->
            "hoursminutes"

        HoursMinutesSeconds ->
            "hoursminutesseconds"

        Minutes ->
            "minutes"

        MinutesSeconds ->
            "minutesseconds"

        Seconds ->
            "seconds"

        SecondsMilliseconds ->
            "secondsmilliseconds"

        Milliseconds ->
            "milliseconds"

        -- Should never get to these options as they are intercepted before calling this function.
        Utc _ ->
            ""

        TUMaxBins _ ->
            ""

        TUStep _ _ ->
            ""


timeUnitProperties : TimeUnit -> List LabelledSpec
timeUnitProperties tUnit =
    case tUnit of
        Utc tu ->
            ( "utc", JE.bool True ) :: timeUnitProperties tu

        TUMaxBins n ->
            -- TODO: Would we ever require utc and maxbins together (currently not possible)?
            [ ( "maxbins", JE.int n ) ]

        TUStep x tu ->
            ( "step", JE.float x ) :: timeUnitProperties tu

        _ ->
            [ ( "unit", JE.string (timeUnitLabel tUnit) ) ]


timeUnitSpec : TimeUnit -> Spec
timeUnitSpec tUnit =
    JE.object (timeUnitProperties tUnit)


titleConfigProperty : TitleConfig -> List LabelledSpec
titleConfigProperty titleCfg =
    case titleCfg of
        TAnchor an ->
            [ ( "anchor", anchorSpec an ) ]

        TAngle n ->
            numExpr "angle" n

        TBaseline va ->
            [ ( "baseline", vAlignSpec va ) ]

        TColor s ->
            strExpr "color" s

        TDx n ->
            numExpr "dx" n

        TDy n ->
            numExpr "dy" n

        TFont s ->
            strExpr "font" s

        TFontSize n ->
            numExpr "fontSize" n

        TFontStyle s ->
            strExpr "fontStyle" s

        TFrame tf ->
            [ ( "frame", tfSpec tf ) ]

        TFontWeight w ->
            [ ( "fontWeight", fontWeightSpec w ) ]

        TLimit n ->
            numExpr "limit" n

        TLineHeight n ->
            numExpr "lineHeight" n

        TOffset n ->
            numExpr "offset" n

        TOrient sd ->
            [ ( "orient", sideSpec sd ) ]

        TStyle ss ->
            case ss of
                [ s ] ->
                    [ ( "style", JE.string s ) ]

                _ ->
                    [ ( "style", JE.list JE.string ss ) ]

        TSubtitle s ->
            strExpr "subtitle" s

        TSubtitleColor s ->
            strExpr "subtitleColor" s

        TSubtitleFont s ->
            strExpr "subtitleFont" s

        TSubtitleFontSize n ->
            numExpr "subtitleFontSize" n

        TSubtitleFontStyle s ->
            strExpr "subtitleFontStyle" s

        TSubtitleFontWeight w ->
            [ ( "subtitleFontWeight", fontWeightSpec w ) ]

        TSubtitleLineHeight n ->
            numExpr "subtitleLineHeight" n

        TSubtitlePadding n ->
            numExpr "subtitlePadding" n

        TZIndex n ->
            numExpr "zindex" n


togglePredicateSpec : TogglePredicate -> Spec
togglePredicateSpec tp =
    case tp of
        TpFalse ->
            JE.bool False

        TpExpr ex ->
            JE.string ex

        TpShiftKey ->
            JE.string "event.shiftKey"

        TpCtrlKey ->
            JE.string "event.ctrlKey"

        TpAltKey ->
            JE.string "event.altKey"


toList : List JE.Value -> JE.Value
toList =
    JE.list identity


trFilterSpec : MarkChannel -> Filter -> Spec
trFilterSpec mc f =
    case f of
        FExpr ex ->
            -- Simple expressions cannot be mixed with aggregating transforms.
            JE.string ex

        FCompose boolExpr ->
            booleanOpSpec boolExpr

        _ ->
            JE.object (markChannelProperties mc ++ filterProperties f)


ttContentSpec : TooltipContent -> Spec
ttContentSpec ttContent =
    case ttContent of
        TTEncoding ->
            JE.string "encoding"

        TTData ->
            JE.string "data"

        TTNone ->
            JE.string "null"



-- TTExpr s ->
--     JE.object [ ( "expr", JE.string s ) ]


vAlignSpec : VAlign -> Spec
vAlignSpec al =
    case al of
        VAlignTop ->
            JE.string "top"

        VAlignLineTop ->
            JE.string "line-top"

        VAlignMiddle ->
            JE.string "middle"

        VAlignBottom ->
            JE.string "bottom"

        VAlignLineBottom ->
            JE.string "line-bottom"

        VAlignAlphabetic ->
            JE.string "alphabetic"

        VAlignExpr s ->
            JE.object [ ( "expr", JE.string s ) ]


viewBackgroundProperty : ViewBackground -> List LabelledSpec
viewBackgroundProperty vb =
    case vb of
        VBStyle styles ->
            [ ( "style", JE.list JE.string styles ) ]

        VBCornerRadius n ->
            numExpr "cornerRadius" n

        VBFill s ->
            strExpr "fill" s

        VBFillOpacity n ->
            numExpr "fillOpacity" n

        VBOpacity n ->
            numExpr "opacity" n

        VBStroke s ->
            strExpr "stroke" s

        VBStrokeOpacity n ->
            numExpr "strokeOpacity" n

        VBStrokeCap cap ->
            [ ( "strokeCap", strokeCapSpec cap ) ]

        VBStrokeJoin jn ->
            [ ( "strokeJoin", strokeJoinSpec jn ) ]

        VBStrokeWidth n ->
            numExpr "strokeWidth" n

        VBStrokeDash ns ->
            numsExpr "strokeDash" ns

        VBStrokeDashOffset n ->
            numExpr "strokeDashOffset" n

        VBStrokeMiterLimit n ->
            numExpr "strokeMiterLimit" n


viewConfigProperties : ViewConfig -> List LabelledSpec
viewConfigProperties viewCfg =
    case viewCfg of
        VContinuousWidth x ->
            [ ( "continuousWidth", JE.float x ) ]

        VContinuousHeight x ->
            [ ( "continuousHeight", JE.float x ) ]

        VDiscreteWidth x ->
            [ ( "discreteWidth", JE.float x ) ]

        VDiscreteHeight x ->
            [ ( "discreteHeight", JE.float x ) ]

        VClip b ->
            [ ( "clip", JE.bool b ) ]

        VCornerRadius r ->
            [ ( "cornerRadius", JE.float r ) ]

        VCursor cur ->
            [ ( "cursor", cursorSpec cur ) ]

        VFill ms ->
            case ms of
                Just s ->
                    [ ( "fill", JE.string s ) ]

                Nothing ->
                    [ ( "fill", JE.null ) ]

        VFillOpacity x ->
            [ ( "fillOpacity", JE.float x ) ]

        VOpacity x ->
            [ ( "opacity", JE.float x ) ]

        VStep x ->
            [ ( "step", JE.float x ) ]

        VStroke ms ->
            case ms of
                Just s ->
                    [ ( "stroke", JE.string s ) ]

                Nothing ->
                    [ ( "stroke", JE.null ) ]

        VStrokeOpacity x ->
            [ ( "strokeOpacity", JE.float x ) ]

        VStrokeCap cap ->
            [ ( "strokeCap", strokeCapSpec cap ) ]

        VStrokeJoin jn ->
            [ ( "strokeJoin", strokeJoinSpec jn ) ]

        VStrokeWidth x ->
            [ ( "strokeWidth", JE.float x ) ]

        VStrokeDash xs ->
            [ ( "strokeDash", JE.list JE.float xs ) ]

        VStrokeDashOffset x ->
            [ ( "strokeDashOffset", JE.float x ) ]

        VStrokeMiterLimit x ->
            [ ( "strokeMiterLimit", JE.float x ) ]

        VBackground vbs ->
            List.concatMap viewBackgroundProperty vbs


vlPropertyLabel : VLProperty -> String
vlPropertyLabel spec =
    case spec of
        VLName ->
            "name"

        VLParams ->
            "params"

        VLDescription ->
            "description"

        VLTitle ->
            "title"

        VLWidth ->
            "width"

        VLWidthStep ->
            "width"

        VLHeight ->
            "height"

        VLHeightStep ->
            "height"

        VLPadding ->
            "padding"

        VLAutosize ->
            "autosize"

        VLBackground ->
            "background"

        VLBackgroundExpr ->
            "background"

        VLData ->
            "data"

        VLDatasets ->
            "datasets"

        VLProjection ->
            "projection"

        VLMark ->
            "mark"

        VLTransform ->
            "transform"

        VLEncoding ->
            "encoding"

        VLConfig ->
            "config"

        VLSelection ->
            "selection"

        VLConcat ->
            "concat"

        VLColumns ->
            "columns"

        VLHConcat ->
            "hconcat"

        VLVConcat ->
            "vconcat"

        VLLayer ->
            "layer"

        VLRepeat ->
            "repeat"

        VLFacet ->
            "facet"

        VLSpacing ->
            "spacing"

        VLAlign ->
            "align"

        VLBounds ->
            "bounds"

        VLCenter ->
            "center"

        VLSpec ->
            "spec"

        VLResolve ->
            "resolve"

        VLViewBackground ->
            "view"


wOperationLabel : WOperation -> String
wOperationLabel op =
    case op of
        RowNumber ->
            "row_number"

        Rank ->
            "rank"

        DenseRank ->
            "dense_rank"

        PercentRank ->
            "percent_rank"

        CumeDist ->
            "cume_dist"

        Ntile ->
            "ntile"

        Lag ->
            "lag"

        Lead ->
            "lead"

        FirstValue ->
            "first_value"

        LastValue ->
            "last_value"

        NthValue ->
            "nth_value"


windowFieldProperty : Window -> LabelledSpec
windowFieldProperty w =
    case w of
        WAggregateOp op ->
            ( "op", operationSpec op )

        WOp op ->
            ( "op", JE.string (wOperationLabel op) )

        WParam n ->
            ( "param", JE.int n )

        WField f ->
            ( "field", JE.string f )


imputeProperty : ImputeProperty -> LabelledSpec
imputeProperty ip =
    case ip of
        ImFrame (Just n1) (Just n2) ->
            ( "frame", JE.list JE.int [ n1, n2 ] )

        ImFrame Nothing (Just n2) ->
            ( "frame", toList [ JE.null, JE.int n2 ] )

        ImFrame (Just n1) Nothing ->
            ( "frame", toList [ JE.int n1, JE.null ] )

        ImFrame Nothing Nothing ->
            ( "frame", toList [ JE.null, JE.null ] )

        ImKeyVals dVals ->
            ( "keyvals", dataValuesSpecs dVals )

        ImKeyValSequence start stop step ->
            ( "keyvals"
            , JE.object
                [ ( "start", JE.float start )
                , ( "stop", JE.float stop )
                , ( "step", JE.float step )
                ]
            )

        ImMethod method ->
            ( "method", JE.string (imMethodLabel method) )

        ImNewValue dVal ->
            ( "value", dataValueSpec dVal )

        ImGroupBy fields ->
            ( "groupby", JE.list JE.string fields )


windowProperty : WindowProperty -> LabelledSpec
windowProperty wProp =
    case wProp of
        WFrame (Just n1) (Just n2) ->
            ( "frame", JE.list JE.int [ n1, n2 ] )

        WFrame Nothing (Just n2) ->
            ( "frame", toList [ JE.null, JE.int n2 ] )

        WFrame (Just n1) Nothing ->
            ( "frame", toList [ JE.int n1, JE.null ] )

        WFrame Nothing Nothing ->
            ( "frame", toList [ JE.null, JE.null ] )

        WIgnorePeers b ->
            ( "ignorePeers", JE.bool b )

        WGroupBy fs ->
            ( "groupby", JE.list JE.string fs )

        WSort sfs ->
            ( "sort", JE.list (sortFieldProperties >> JE.object) sfs )
