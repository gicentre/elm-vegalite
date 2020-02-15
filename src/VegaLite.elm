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
    , prType
    , prClipAngle
    , prClipExtent
    , prCenter
    , prScale
    , prTranslate
    , prRotate
    , prPrecision
    , prCoefficient
    , prDistance
    , prFraction
    , prLobes
    , prParallel
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
    , fiOp
    , fiOpTrans
    , fiCompose
    , fiSelection
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
    , maAlign
    , maAngle
    , maBandSize
    , maBaseline
    , maBinSpacing
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
    , maStrokeDash
    , maStrokeDashOffset
    , maStrokeJoin
    , joRound
    , joBevel
    , joMiter
    , maStrokeMiterLimit
    , maStrokeOpacity
    , maStrokeWidth
    , maStyle
    , maTension
    , maText
    , maTheta
    , maThickness
    , maTicks
    , maTooltip
    , maWidth
    , maHeight
    , maX
    , maY
    , maXOffset
    , maYOffset
    , maX2
    , maY2
    , maX2Offset
    , maY2Offset
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
    , tdLeftToRight
    , tdRightToLeft
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
    , encoding
    , Measurement(..)
    , position
    , Position(..)
    , pName
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
    , pBand
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
    , axBandPosition
    , axMaxExtent
    , axMinExtent
    , axOrient
    , axOffset
    , axPosition
    , axZIndex
    , axDataCondition
    , axDomain
    , axDomainColor
    , axDomainOpacity
    , axDomainWidth
    , axFormat
    , axFormatAsNum
    , axFormatAsTemporal
    , axLabels
    , axLabelAlign
    , cAxLabelAlign
    , axLabelAngle
    , axLabelBaseline
    , cAxLabelBaseline
    , axLabelBound
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
    , axLabelOpacity
    , cAxLabelOpacity
    , axLabelOverlap
    , axLabelPadding
    , cAxLabelPadding
    , axLabelSeparation
    , axTicks
    , axTickColor
    , cAxTickColor
    , axTickCount
    , axTickExtra
    , axTickOffset
    , axTickOpacity
    , cAxTickOpacity
    , axTickRound
    , axTickSize
    , cAxTickSize
    , axTickMinStep
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
    , axTitleOpacity
    , axTitlePadding
    , axTitleX
    , axTitleY
    , axGrid
    , axGridColor
    , cAxGridColor
    , axGridDash
    , cAxGridDash
    , axGridOpacity
    , cAxGridOpacity
    , axGridWidth
    , cAxGridWidth
    , haLeft
    , haCenter
    , haRight
    , vaTop
    , vaMiddle
    , vaBottom
    , vaAlphabetic
    , osNone
    , osGreedy
    , osParity
    , siTop
    , siBottom
    , siLeft
    , siRight
    , size
    , color
    , fill
    , stroke
    , strokeWidth
    , opacity
    , fillOpacity
    , strokeOpacity
    , shape
    , mName
    , mRepeat
    , mNominal
    , mOrdinal
    , mQuant
    , mTemporal
    , mGeo
    , mMType
    , mScale
    , mBin
    , mBinned
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
    , leGradientLength
    , leGradientThickness
    , leGradientStrokeColor
    , leGradientStrokeWidth
    , leGridAlign
    , leLabelAlign
    , leLabelBaseline
    , leLabelColor
    , leLabelFont
    , leLabelFontSize
    , leLabelLimit
    , leLabelOffset
    , leLabelOverlap
    , leOffset
    , leOrient
    , lePadding
    , leRowPadding
    , leStrokeColor
    , leStrokeWidth
    , leSymbolFillColor
    , leSymbolSize
    , leSymbolStrokeColor
    , leSymbolStrokeWidth
    , leSymbolType
    , leTickCount
    , leTitle
    , leTitleAlign
    , leTitleBaseline
    , leTitleColor
    , leTitleFont
    , leTitleFontSize
    , leTitleFontWeight
    , leTitleLimit
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
    , leNums
    , leStrs
    , leDts
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
    , tFormat
    , tFormatAsNum
    , tFormatAsTemporal
    , FontWeight(..)
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
    , scType
    , scDomain
    , categoricalDomainMap
    , domainRangeMap
    , doNums
    , doStrs
    , doDts
    , doUnaggregated
    , doSelection
    , scRange
    , raName
    , raNums
    , raStrs
    , scScheme
    , scAlign
    , scPadding
    , scPaddingInner
    , scPaddingOuter
    , scRound
    , scClamp
    , scInterpolate
    , scNice
    , scZero
    , scBand
    , scBinLinear
    , scBinOrdinal
    , scLinear
    , scLog
    , scSymLog
    , scConstant
    , scBase
    , scOrdinal
    , scPoint
    , scDomainMid
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
    , repeatFlow
    , repeat
    , rowFields
    , columnFields
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
    , arFlow
    , arColumn
    , arRow
    , hdLabelAngle
    , hdLabelAlign
    , hdLabelAnchor
    , hdLabelColor
    , hdLabelFont
    , hdLabelFontSize
    , hdLabelLimit
    , hdLabelOrient
    , hdLabelPadding
    , hdTitle
    , hdTitleAlign
    , hdTitleAnchor
    , hdTitleAngle
    , hdTitleBaseline
    , hdTitleColor
    , hdTitleFont
    , hdTitleFontWeight
    , hdTitleFontSize
    , hdTitleLimit
    , hdTitleOrient
    , hdTitlePadding
    , hdFormat
    , hdFormatAsNum
    , hdFormatAsTemporal
    , selection
    , select
    , seSingle
    , seMulti
    , seInterval
    , seEmpty
    , seClear
    , seInit
    , seInitInterval
    , seEncodings
    , seFields
    , seNearest
    , seOn
    , seToggle
    , seTranslate
    , seZoom
    , seBind
    , seBindLegend
    , blField
    , blChannel
    , blEvent
    , seBindScales
    , iRange
    , iCheckbox
    , iRadio
    , iSelect
    , iText
    , iNumber
    , iDate
    , iTime
    , iMonth
    , iWeek
    , iDateTimeLocal
    , iTel
    , iColor
    , inDebounce
    , inElement
    , inOptions
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
    , mSelectionCondition
    , mDataCondition
    , tSelectionCondition
    , tDataCondition
    , hDataCondition
    , hSelectionCondition
    , and
    , or
    , not
    , expr
    , selected
    , selectionName
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
    , paEdges
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
    , title
    , tiAnchor
    , tiAngle
    , tiBaseline
    , tiColor
    , tiFont
    , tiFontSize
    , tiFontStyle
    , tiFontWeight
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
    , tiLimit
    , tiOffset
    , tiOrient
    , tiStyle
    , tiZIndex
    , viewBackground
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
    , coAutosize
    , coAxis
    , coAxisX
    , coAxisY
    , coAxisLeft
    , coAxisRight
    , coAxisTop
    , coAxisBottom
    , coAxisBand
    , coBackground
    , coBar
    , coCircle
    , coConcat
    , coCountTitle
    , coFieldTitle
    , coGeoshape
    , coFacet
    , coHeader
    , coLegend
    , coLine
    , coMark
    , coNamedStyle
    , coNamedStyles
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
    , axcoBandPosition
    , axcoDomain
    , axcoDomainColor
    , axcoDomainOpacity
    , axcoDomainWidth
    , axcoMaxExtent
    , axcoMinExtent
    , axcoGrid
    , axcoGridColor
    , axcoGridDash
    , axcoGridOpacity
    , axcoGridWidth
    , axcoLabels
    , axcoLabelAlign
    , axcoLabelAngle
    , axcoLabelBaseline
    , axcoLabelBound
    , axcoLabelColor
    , axcoLabelFlush
    , axcoLabelFlushOffset
    , axcoLabelFont
    , axcoLabelFontSize
    , axcoLabelFontStyle
    , axcoLabelFontWeight
    , axcoLabelLimit
    , axcoLabelOpacity
    , axcoLabelOverlap
    , axcoLabelPadding
    , axcoLabelSeparation
    , axcoTicks
    , axcoTickColor
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
    , lecoClipHeight
    , lecoColumnPadding
    , lecoColumns
    , lecoCornerRadius
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
    , lecoLabelLimit
    , lecoLabelOffset
    , lecoLabelOverlap
    , lecoShortTimeLabels
    , lecoEntryPadding
    , lecoSymbolBaseFillColor
    , lecoSymbolBaseStrokeColor
    , lecoSymbolDirection
    , lecoSymbolFillColor
    , lecoSymbolOffset
    , lecoSymbolSize
    , lecoSymbolStrokeColor
    , lecoSymbolStrokeWidth
    , lecoSymbolType
    , lecoTitleAlign
    , lecoTitleBaseline
    , lecoTitleColor
    , lecoTitleFont
    , lecoTitleFontSize
    , lecoTitleFontWeight
    , lecoTitleLimit
    , lecoTitleLineHeight
    , lecoTitlePadding
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
    , nullValue
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
    , day
    , hours
    , hoursMinutes
    , hoursMinutesSeconds
    , milliseconds
    , minutes
    , minutesSeconds
    , month
    , monthDate
    , monthDateHours
    , quarter
    , quarterMonth
    , seconds
    , secondsMilliseconds
    , year
    , yearQuarter
    , yearQuarterMonth
    , yearMonth
    , yearMonthDate
    , yearMonthDateHours
    , yearMonthDateHoursMinutes
    , yearMonthDateHoursMinutesSeconds
    , utc
    , tuMaxBins
    , tuStep
    , Anchor
    , Arrangement
    , Autosize
    , AxisProperty
    , AxisConfig
    , Binding
    , BindLegendProperty
    , BinProperty
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
    , Legend
    , LegendConfig
    , LegendOrientation
    , LegendProperty
    , LegendValues
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
    , PivotProperty
    , PointMarker
    , PositionChannel
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
    , TooltipContent
    , VAlign
    , ViewBackground
    , ViewConfig
    , Window
    , WOperation
    , WindowProperty
    , axcoShortTimeLabels
    , axcoTickStep
    , axDates
    , axTickStep
    , coStack
    , lookupAs
    , sacoRangeStep
    , sacoTextXRangeStep
    , scRangeStep
    , scReverse
    , scSequential
    , vicoWidth
    , vicoHeight
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
7.  [Selections for Interaction](#7-selections-for-interaction)
8.  [Top-level Settings](#8-top-level-settings)
9.  [General Data Functions](#9-general-data-functions)
10. [Type Reference](#10-type-reference)
11. [Deprecated Functions](#11-deprecated-functions)

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

@docs prType
@docs prClipAngle
@docs prClipExtent
@docs prCenter
@docs prScale
@docs prTranslate
@docs prRotate
@docs prPrecision
@docs prCoefficient
@docs prDistance
@docs prFraction
@docs prLobes
@docs prParallel
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
@docs fiOp
@docs fiOpTrans
@docs fiCompose
@docs fiSelection
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

@docs maAlign
@docs maAngle
@docs maBandSize
@docs maBaseline
@docs maBinSpacing
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
@docs maStrokeDash
@docs maStrokeDashOffset
@docs maStrokeJoin
@docs joRound
@docs joBevel
@docs joMiter
@docs maStrokeMiterLimit
@docs maStrokeOpacity
@docs maStrokeWidth
@docs maStyle
@docs maTension
@docs maText
@docs maTheta
@docs maThickness
@docs maTicks
@docs maTooltip
@docs maWidth
@docs maHeight
@docs maX
@docs maY
@docs maXOffset
@docs maYOffset
@docs maX2
@docs maY2
@docs maX2Offset
@docs maY2Offset
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

@docs tdLeftToRight
@docs tdRightToLeft

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


### 4.2.3 Cursors

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
@docs pBand
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


#### General

@docs axBandPosition
@docs axMaxExtent
@docs axMinExtent
@docs axOrient
@docs axOffset
@docs axPosition
@docs axZIndex
@docs axDataCondition


#### Axis Domain

@docs axDomain
@docs axDomainColor
@docs axDomainOpacity
@docs axDomainWidth


#### Axis Labels

@docs axFormat
@docs axFormatAsNum
@docs axFormatAsTemporal
@docs axLabels
@docs axLabelAlign
@docs cAxLabelAlign
@docs axLabelAngle
@docs axLabelBaseline
@docs cAxLabelBaseline
@docs axLabelBound
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
@docs axLabelOpacity
@docs cAxLabelOpacity
@docs axLabelOverlap
@docs axLabelPadding
@docs cAxLabelPadding
@docs axLabelSeparation


#### Axis Ticks

@docs axTicks
@docs axTickColor
@docs cAxTickColor
@docs axTickCount
@docs axTickExtra
@docs axTickOffset
@docs axTickOpacity
@docs cAxTickOpacity
@docs axTickRound
@docs axTickSize
@docs cAxTickSize
@docs axTickMinStep
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
@docs axTitleOpacity
@docs axTitlePadding
@docs axTitleX
@docs axTitleY


#### Axis Grid

@docs axGrid
@docs axGridColor
@docs cAxGridColor
@docs axGridDash
@docs cAxGridDash
@docs axGridOpacity
@docs cAxGridOpacity
@docs axGridWidth
@docs cAxGridWidth


### 5.1.4 Positioning Constants


#### Text Alignment

@docs haLeft
@docs haCenter
@docs haRight

@docs vaTop
@docs vaMiddle
@docs vaBottom
@docs vaAlphabetic


#### Overlapping text

@docs osNone
@docs osGreedy
@docs osParity


### Relative Position

@docs siTop
@docs siBottom
@docs siLeft
@docs siRight


## 5.2 Mark Channels

Appearance of the visual marks in the visualization such as their color or size.

@docs size
@docs color
@docs fill
@docs stroke
@docs strokeWidth
@docs opacity
@docs fillOpacity
@docs strokeOpacity
@docs shape


### 5.2.1 Mark Channel Properties

@docs mName
@docs mRepeat
@docs mNominal
@docs mOrdinal
@docs mQuant
@docs mTemporal
@docs mGeo
@docs mMType
@docs mScale
@docs mBin
@docs mBinned
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
@docs leGradientLength
@docs leGradientThickness
@docs leGradientStrokeColor
@docs leGradientStrokeWidth
@docs leGridAlign
@docs leLabelAlign
@docs leLabelBaseline
@docs leLabelColor
@docs leLabelFont
@docs leLabelFontSize
@docs leLabelLimit
@docs leLabelOffset
@docs leLabelOverlap
@docs leOffset
@docs leOrient
@docs lePadding
@docs leRowPadding
@docs leStrokeColor
@docs leStrokeWidth
@docs leSymbolFillColor
@docs leSymbolSize
@docs leSymbolStrokeColor
@docs leSymbolStrokeWidth
@docs leSymbolType
@docs leTickCount
@docs leTitle
@docs leTitleAlign
@docs leTitleBaseline
@docs leTitleColor
@docs leTitleFont
@docs leTitleFontSize
@docs leTitleFontWeight
@docs leTitleLimit
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


#### Legend Literals

@docs leNums
@docs leStrs
@docs leDts


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
@docs tFormat
@docs tFormatAsNum
@docs tFormatAsTemporal
@docs FontWeight


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

Channels that relate to the order of data fields such as for sorting stacking order
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


## 5.7 Facet Channels

Channels for faceting single plots into small multiples. Can be used to create
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


## 5.10 Scaling

Used to specify how the encoding of a data field should be applied. See the
[Vega-Lite scale documentation](https://vega.github.io/vega-lite/docs/scale.html).

@docs scType


### 5.10.1 Scale Domain

Describes the data values that will be encoded.

@docs scDomain
@docs categoricalDomainMap
@docs domainRangeMap
@docs doNums
@docs doStrs
@docs doDts
@docs doUnaggregated
@docs doSelection


### 5.10.2 Scale Range

Describes the values after data have been encoded (e.g. pixel positions or color values).

@docs scRange
@docs raName
@docs raNums
@docs raStrs


### 5.10.3 Scaling Properties

@docs scScheme
@docs scAlign
@docs scPadding
@docs scPaddingInner
@docs scPaddingOuter
@docs scRound
@docs scClamp
@docs scInterpolate
@docs scNice
@docs scZero
@docs scBand
@docs scBinLinear
@docs scBinOrdinal
@docs scLinear
@docs scLog
@docs scSymLog
@docs scConstant
@docs scBase
@docs scOrdinal
@docs scPoint
@docs scDomainMid
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

Views can be combined to create more complex multiview displays. This may involve
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


## 6.2 Faceted Views

Small multiples each of which show subsets of the same dataset. The specification
determines which field should be used to determine subsets along with their spatial
arrangement. See the
[Vega-Lite facet documentation](https://vega.github.io/vega-lite/docs/facet.html)

@docs repeatFlow
@docs repeat
@docs rowFields
@docs columnFields
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
@docs arFlow
@docs arColumn
@docs arRow


### 6.2.1 Facet Headers

See
[Vega-Lite header documentation](https://vega.github.io/vega-lite/docs/header.html)

@docs hdLabelAngle
@docs hdLabelAlign
@docs hdLabelAnchor
@docs hdLabelColor
@docs hdLabelFont
@docs hdLabelFontSize
@docs hdLabelLimit
@docs hdLabelOrient
@docs hdLabelPadding

@docs hdTitle
@docs hdTitleAlign
@docs hdTitleAnchor
@docs hdTitleAngle
@docs hdTitleBaseline
@docs hdTitleColor
@docs hdTitleFont
@docs hdTitleFontWeight
@docs hdTitleFontSize
@docs hdTitleLimit
@docs hdTitleOrient
@docs hdTitlePadding

@docs hdFormat
@docs hdFormatAsNum
@docs hdFormatAsTemporal

---


# 7. Selections for Interaction

Selections allow a visualization to respond to interactions (such as clicking or
dragging). They transform interactions into data queries. See the Vega-Lite
[selection](https://vega.github.io/vega-lite/docs/selection.html) and
[bind](https://vega.github.io/vega-lite/docs/bind.html)
documentation.

  - 7.1 [Selections](#7-1-selections)
  - 7.2 [Selection Resolution](#7-2-selection-resolution)
  - 7.3 [Conditional Channel Encodings](#7-3-conditional-channel-encodings)


## 7.1 Selections

@docs selection
@docs select
@docs seSingle
@docs seMulti
@docs seInterval
@docs seEmpty
@docs seClear
@docs seInit
@docs seInitInterval
@docs seEncodings
@docs seFields
@docs seNearest
@docs seOn
@docs seToggle
@docs seTranslate
@docs seZoom


### Selection Bindings

@docs seBind
@docs seBindLegend
@docs blField
@docs blChannel
@docs blEvent
@docs seBindScales


### Input Elements

@docs iRange
@docs iCheckbox
@docs iRadio
@docs iSelect
@docs iText
@docs iNumber
@docs iDate
@docs iTime
@docs iMonth
@docs iWeek
@docs iDateTimeLocal
@docs iTel
@docs iColor

@docs inDebounce
@docs inElement
@docs inOptions
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

To make channel encoding conditional on the result of some interaction, use
[mSelectionCondition](#mSelectionCondition) (and its 't' and 'h' variants). Similarly
[mDataCondition](#mDataCondition) (and its 't' and 'h' variants) will encode a mark
conditionally depending on some data properties such as whether a datum is null
or an outlier.

For interaction, once a selection has been defined and named, supplying a set of
encodings allow mark encodings to become dependent on that selection.
`mSelectionCondition` is followed firstly a (Boolean) selection and then an
encoding if that selection is true and another encoding to be applied if it is false.
The color specification below states "whenever data marks are selected with an
interval mouse drag, encode the cylinder field with an ordinal color scheme,
otherwise make them grey":

    sel =
        selection << select "myBrush" Interval []

    enc =
        encoding
            << position X [ pName "Horsepower", pQuant ]
            << position Y [ pName "Miles_per_Gallon", pQuant ]
            << color
                [ mSelectionCondition (selectionName "myBrush")
                    [ mName "Cylinders", mOrdinal ]
                    [ mStr "grey" ]
                ]

In a similar way, `mDataCondition` will encode a mark depending on whether any
predicate tests are satisfied. Unlike selections, multiple conditions and associated
encodings can be specified. Each test condition is evaluated in order and only on
failure of the test does encoding proceed to the next test. If no tests are true,
the encoding in the final parameter is applied in a similar way to 'case of'
expressions:

    enc =
        encoding
            << position X [ pName "value", pOrdinal ]
            << color
                [ mDataCondition
                    [ ( expr "datum.value < 40", [ mStr "blue" ] )
                    , ( expr "datum.value < 50", [ mStr "red" ] )
                    , ( expr "datum.value < 60", [ mStr "yellow" ] )
                    ]
                    [ mStr "black" ]
                ]

See the
[Vega-Lite documentation](https://vega.github.io/vega-lite/docs/condition.html).

@docs mSelectionCondition
@docs mDataCondition
@docs tSelectionCondition
@docs tDataCondition
@docs hDataCondition
@docs hSelectionCondition

@docs and
@docs or
@docs not
@docs expr
@docs selected
@docs selectionName

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
@docs paEdges
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


## 8.1 Title

Per-title settings. To standardize the appearance of all titles in a multi-view
specification, use [coTitle](#coTitle) instead.

@docs title
@docs tiAnchor
@docs tiAngle
@docs tiBaseline
@docs tiColor
@docs tiFont
@docs tiFontSize
@docs tiFontStyle
@docs tiFontWeight
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
@docs coAutosize
@docs coAxis
@docs coAxisX
@docs coAxisY
@docs coAxisLeft
@docs coAxisRight
@docs coAxisTop
@docs coAxisBottom
@docs coAxisBand
@docs coBackground
@docs coBar
@docs coCircle
@docs coConcat
@docs coCountTitle
@docs coFieldTitle
@docs coGeoshape
@docs coFacet
@docs coHeader
@docs coLegend
@docs coLine
@docs coMark
@docs coNamedStyle
@docs coNamedStyles
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

@docs axcoBandPosition
@docs axcoDomain
@docs axcoDomainColor
@docs axcoDomainOpacity
@docs axcoDomainWidth
@docs axcoMaxExtent
@docs axcoMinExtent
@docs axcoGrid
@docs axcoGridColor
@docs axcoGridDash
@docs axcoGridOpacity
@docs axcoGridWidth
@docs axcoLabels
@docs axcoLabelAlign
@docs axcoLabelAngle
@docs axcoLabelBaseline
@docs axcoLabelBound
@docs axcoLabelColor
@docs axcoLabelFlush
@docs axcoLabelFlushOffset
@docs axcoLabelFont
@docs axcoLabelFontSize
@docs axcoLabelFontStyle
@docs axcoLabelFontWeight
@docs axcoLabelLimit
@docs axcoLabelOpacity
@docs axcoLabelOverlap
@docs axcoLabelPadding
@docs axcoLabelSeparation
@docs axcoTicks
@docs axcoTickColor
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

@docs lecoClipHeight
@docs lecoColumnPadding
@docs lecoColumns
@docs lecoCornerRadius
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
@docs lecoLabelLimit
@docs lecoLabelOffset
@docs lecoLabelOverlap
@docs lecoShortTimeLabels
@docs lecoEntryPadding
@docs lecoSymbolBaseFillColor
@docs lecoSymbolBaseStrokeColor
@docs lecoSymbolDirection
@docs lecoSymbolFillColor
@docs lecoSymbolOffset
@docs lecoSymbolSize
@docs lecoSymbolStrokeColor
@docs lecoSymbolStrokeWidth
@docs lecoSymbolType
@docs lecoTitleAlign
@docs lecoTitleBaseline
@docs lecoTitleColor
@docs lecoTitleFont
@docs lecoTitleFontSize
@docs lecoTitleFontWeight
@docs lecoTitleLimit
@docs lecoTitleLineHeight
@docs lecoTitlePadding


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

Unlike [title](#title) title configuration applies to all titles if multiiple views
are created. See the
[Vega-Lite title configuration documentation](https://vega.github.io/vega-lite/docs/title.html#config)

@docs ticoAnchor
@docs ticoAngle
@docs ticoBaseline
@docs ticoColor
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

In addition to more general data types like integers and string, the following types
can carry data used in specifications.

  - 9.1 [Temporal Data](#9-1-temporal-data)

@docs boo
@docs true
@docs false
@docs dt
@docs num
@docs str
@docs nullValue
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
@docs day
@docs hours
@docs hoursMinutes
@docs hoursMinutesSeconds
@docs milliseconds
@docs minutes
@docs minutesSeconds
@docs month
@docs monthDate
@docs monthDateHours
@docs quarter
@docs quarterMonth
@docs seconds
@docs secondsMilliseconds
@docs year
@docs yearQuarter
@docs yearQuarterMonth
@docs yearMonth
@docs yearMonthDate
@docs yearMonthDateHours
@docs yearMonthDateHoursMinutes
@docs yearMonthDateHoursMinutesSeconds
@docs utc
@docs tuMaxBins
@docs tuStep

---


# 10. Type Reference

Types that are not specified directly, provided here for reference with links
to the functions that generate them.

@docs Anchor
@docs Arrangement
@docs Autosize
@docs AxisProperty
@docs AxisConfig
@docs Binding
@docs BindLegendProperty
@docs BinProperty
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
@docs Legend
@docs LegendConfig
@docs LegendOrientation
@docs LegendProperty
@docs LegendValues
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
@docs PivotProperty
@docs PointMarker
@docs PositionChannel
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
@docs TooltipContent
@docs VAlign
@docs ViewBackground
@docs ViewConfig
@docs Window
@docs WOperation
@docs WindowProperty

---


# 11. Deprecated functions

@docs axcoShortTimeLabels
@docs axcoTickStep
@docs axDates
@docs axTickStep
@docs coStack
@docs lookupAs
@docs sacoRangeStep
@docs sacoTextXRangeStep
@docs scRangeStep
@docs scReverse
@docs scSequential
@docs vicoWidth
@docs vicoHeight

-}

import Json.Decode as JD
import Json.Encode as JE


{-| Generated by [anStart](#anStart), [anMiddle](#anMiddle) and [anEnd](#anEnd).
-}
type Anchor
    = AnStart
    | AnMiddle
    | AnEnd


{-| Generated by [arFlow](#arFlow), [arColumn](#arColumn) and [arRow](#arRow).
-}
type Arrangement
    = Column
    | Row
    | Flow


{-| Generated by [asContent](#asContent), [asFit](#asFit), [asFitX](#asFitX),
[asFitY](#asFitY), [asNone](#asNone), [asPad](#asPad), [asPadding](#asPadding)
and [asResize](#asReeize).
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


{-| Generated by [axcoBandPosition](#axcoBandPosition), [axcoDomain](#axcoDomain),
[axcoDomainColor](#axcoDomainColor), [axcoDomainOpacity](#axcoDomainOpacity),
[axcoDomainWidth](#axcoDomainWidth), [axcoMaxExtent](#axcoMaxExtent),
[axcoMinExtent](#axcoMinExtent), [axcoGrid](#axcoGrid), [axcoGridColor](#axcoGridColor),
[axcoGridDash](#axcoGridDash), [axcoGridOpacity](#axcoGridOpacity),
[axcoGridWidth](#axcoGridWidth), [axcoLabels](#axcoLabels), [axcoLabelAlign](#axcoLabelAlign),
[axcoLabelAngle](#axcoLabelAngle), [axcoLabelBaseline](#axcoLabelBaseline),
[axcoLabelBound](#axcoLabelBound), [axcoLabelColor](#axcoLabelColor),
[axcoLabelFlush](#axcoLabelFlush), [axcoLabelFlushOffset](#axcoLabelFlushOffset),
[axcoLabelFont](#axcoLabelFont), [axcoLabelFontSize](#axcoLabelFontSize),
[axcoLabelFontStyle](#axcoLabelFontStyle), [axcoLabelFontWeight](#axcoLabelFontWeight),
[axcoLabelLimit](#axcoLabelLimit), [axcoLabelOpacity](#axcoLabelOpacity),
[axcoLabelOverlap](#axcoLabelOverlap), [axcoLabelPadding](#axcoLabelPadding),
[axcoLabelSeparation](#axcoLabelSeparation),[axcoTicks](#axcoTicks),
[axcoTickColor](#axcoTickColor), [axcoTickExtra](#axcoTickExtra),
[axcoTickOffset](#axcoTickOffset), [axcoTickOpacity](#axcoTickOpacity),
[axcoTickRound](#axcoTickRound), [axcoTickSize](#axcoTickSize),
[axcoTickMinStep](#axcoTickMinStep), [axcoTickWidth](#axcoTickWidth),
[axcoTitleAlign](#axcoTitleAlign), [axcoTitleAnchor](#axcoTitleAnchor),
[axcoTitleAngle](#axcoTitleAngle), [axcoTitleBaseline](#axcoTitleBaseline),
[axcoTitleColor](#axcoTitleColor), [axcoTitleFont](#axcoTitleFont),
[axcoTitleFontSize](#axcoTitleFontSize), [axcoTitleFontStyle](#axcoTitleFontStyle),
[axcoTitleFontWeight](#axcoTitleFontWeight), [axcoTitleLimit](#axcoTitleLimit),
[axcoTitleLineHeight](#axcoTitleLineHeight), [axcoTitleOpacity](#axcoTitleOpacity),
[axcoTitlePadding](#axcoTitlePadding), [axcoTitleX](#axcoTitleX) and [axcoTitleY](#axcoTitleY).
-}
type AxisConfig
    = BandPosition Float
    | Domain Bool
    | DomainColor String
    | DomainOpacity Float
    | DomainWidth Float
    | Grid Bool
    | GridColor String
    | GridDash (List Float)
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
    | LabelOpacity Float
    | LabelOverlap OverlapStrategy
    | LabelPadding Float
    | LabelSeparation Float
    | MaxExtent Float
    | MinExtent Float
    | ShortTimeLabels Bool
    | Ticks Bool
    | TickColor String
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


{-| Generated by [axBandPosition](#axBandPosition), [axMaxExtent](#axMaxExtent),
[axMinExtent](#axMinExtent), [axOrient](#axOrient), [axOffset](#axOffset),
[axPosition](#axPosition), [axZIndex](#axZIndex), [axDataCondition](#axDataCondition),
[axDomain](#axDomain), [axDomainColor](#axDomainColor), [axDomainOpacity](#axDomainOpacity),
[axDomainWidth](#axDomainWidth), [axFormat](#axFormat), [axFormatAsNum](#axFormatAsNum),
[axFormatAsTemporal](#axFormatAsTemporal), [axLabels](#axLabels), [axLabelAlign](#axLabelAlign),
[axLabelAngle](#axLabelAngle), [axLabelBaseline](#axLabelBaseline), [axLabelBound](#axLabelBound),
[axLabelColor](#axLabelColor), [axLabelExpr](#axLabelExpr), [axLabelFlush](#axLabelFlush),
[axLabelFlushOffset](#axLabelFlushOffset), [axLabelFont](#axLabelFont),
[axLabelFontSize](#axLabelFontSize), [axLabelFontStyle](#axLabelFontStyle),
[axLabelFontWeight](#axLabelFontWeight), [axLabelLimit](#axLabelLimit),
[axLabelOpacity](#axLabelOpacity), [axLabelOverlap](#axLabelOverlap),
[axLabelPadding](#axLabelPadding), [axLabelSeparation](#axLabelSeparation),
[axTicks](#axTicks), [axTickColor](#axTickColor), [axTickCount](#axTickCount),
[axTickExtra](#axTickExtra), [axTickOffset](#axTickOffset), [axTickOpacity](#axTickOpacity),
[axTickRound](#axTickRound), [axTickSize](#axTickSize), [axTickMinStep](#axTickMinStep),
[axTickWidth](#axTickWidth), [axValues](#axValues), [axTitle](#axTitle), [axTitleAlign](#axTitleAlign),
[axTitleAnchor](#axTitleAnchor), [axTitleAngle](#axTitleAngle), [axTitleBaseline](#axTitleBaseline),
[axTitleColor](#axTitleColor), [axTitleFont](#axTitleFont), [axTitleFontSize](#axTitleFontSize),
[axTitleFontStyle](#axTitleFontStyle), [axTitleFontWeight](#axTitleFontWeight),
[axTitleLimit](#axTitleLimit), [axTitleOpacity](#axTitleOpacity), [axTitlePadding](#axTitlePadding),
[axTitleX](#axTitleX), [axTitleY](#axTitleY), [axGrid](#axGrid), [axGridColor](#axGridColor),
[axGridDash](#axGridDash), [axGridOpacity](#axGridOpacity) and [axGridWidth](#axGridWidth).
-}
type AxisProperty
    = AxBandPosition Float
    | AxMaxExtent Float
    | AxMinExtent Float
    | AxOrient Side
    | AxOffset Float
    | AxPosition Float
    | AxZIndex Int
    | AxDomain Bool
    | AxDomainColor String
    | AxDomainOpacity Float
    | AxDomainWidth Float
    | AxFormat String
    | AxFormatAsNum
    | AxFormatAsTemporal
    | AxLabels Bool
    | AxLabelAlign HAlign
    | AxLabelAngle Float
    | AxLabelBaseline VAlign
    | AxLabelBound (Maybe Float)
    | AxLabelColor String
    | AxLabelExpr String
    | AxLabelFlush (Maybe Float)
    | AxLabelFlushOffset Float
    | AxLabelFont String
    | AxLabelFontSize Float
    | AxLabelFontStyle String
    | AxLabelFontWeight FontWeight
    | AxLabelLimit Float
    | AxLabelOpacity Float
    | AxLabelOverlap OverlapStrategy
    | AxLabelPadding Float
    | AxLabelSeparation Float
    | AxTickColor String
    | AxTickCount Int
    | AxTickExtra Bool
    | AxTickOffset Float
    | AxTickOpacity Float
    | AxTickRound Bool
    | AxTicks Bool
    | AxTickSize Float
    | AxTickWidth Float
    | AxDates (List (List DateTime))
    | AxValues DataValues
    | AxTitle String
    | AxTitleAlign HAlign
    | AxTitleAnchor Anchor
    | AxTitleAngle Float
    | AxTitleBaseline VAlign
    | AxTitleColor String
    | AxTitleFont String
    | AxTitleFontSize Float
    | AxTitleFontStyle String
    | AxTitleFontWeight FontWeight
    | AxTitleLimit Float
    | AxTitleOpacity Float
    | AxTitlePadding Float
    | AxTitleX Float
    | AxTitleY Float
    | AxGrid Bool
    | AxGridColor String
    | AxGridDash (List Float)
    | AxGridOpacity Float
    | AxGridWidth Float
    | AxTickMinStep Float
    | AxDataCondition BooleanOp ConditionalAxisProperty


{-| Generated by [iRange](#iRange), [iCheckbox](#iCheckbox),
[iRadio](#iRadio), [iSelect](#iSelect), [iText](#iText), [iNumber](#iNumber),
[iDate](#iDate), [iTime](#iTime), [iMonth](#iMonth), [iWeek](#iWeek), [iDateTimeLocal](#iDateTimeLocal),
[iTel](#iTel) and [iColor](#iColor).
-}
type Binding
    = IRange String (List InputProperty)
    | ICheckbox String (List InputProperty)
    | IRadio String (List InputProperty)
    | ISelect String (List InputProperty)
      -- TODO: Check validity: The following input types can generate a warning if options are included even if options appear to have an effect (e.g. placeholder)
    | IText String (List InputProperty)
    | INumber String (List InputProperty)
    | IDate String (List InputProperty)
    | ITime String (List InputProperty)
    | IMonth String (List InputProperty)
    | IWeek String (List InputProperty)
    | IDateTimeLocal String (List InputProperty)
    | ITel String (List InputProperty)
    | IColor String (List InputProperty)


{-| Generated by [blField](#blField), [blChannel](#blChannel) and [blEvent](#blEvent).
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


{-| Generated by [expr](#expr), [fiOp](#fiOp), [fiOpTrans](#fiOpTrans), [selected](#selected),
[selectionName](#selectionName), [and](#and), [or](#or) and [not](#not).
-}
type BooleanOp
    = Expr String
    | FilterOp Filter
    | FilterOpTrans MarkChannel Filter
    | Selection String
    | SelectionName String
    | And BooleanOp BooleanOp
    | Or BooleanOp BooleanOp
    | Not BooleanOp


{-| Generated by [boFull](#boFull) and [boFlush](#boFlush).
-}
type Bounds
    = Full
    | Flush


{-| Generated by [chX](#chX), [chY](#chY), [chX2](#chX2), [chY2](#chY2),
[chColor](#chColor), [chOpacity](#chOpacity), [chShape](#chShape) and [chSize](#chSize).
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


{-| Generated by [noClip](#noClip) and [clipRect](#clipRect).
-}
type ClipRect
    = NoClip
    | LTRB Float Float Float Float


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
[cAxLabelOpacity](#cAxLabelOpacity), [cAxLabelPadding](#cAxLabelPadding),
[cAxTickColor](#cAxTickColor), [cAxTickOpacity](#cAxOpacity), [cAxTickSize](#cAxTickSize),
[cAxTickWidth](#cAxTickWidth), [cAxGridColor](#cAxGridColor), [cAxGridDash](#cAxGridDash),
[cAxGridOpacity](#cAxGridOpacity) and [cAxGridWidth](#cAxGridWidth)
-}
type ConditionalAxisProperty
    = CAxLabelAlign HAlign HAlign
    | CAxLabelBaseline VAlign VAlign
    | CAxLabelColor String String
    | CAxLabelFont String String
    | CAxLabelFontSize Float Float
    | CAxLabelFontStyle String String
    | CAxLabelFontWeight FontWeight FontWeight
    | CAxLabelOpacity Float Float
    | CAxLabelPadding Float Float
    | CAxTickColor String String
    | CAxTickOpacity Float Float
    | CAxTickWidth Float Float
    | CAxGridColor String String
    | CAxGridDash (List Float) (List Float)
    | CAxGridOpacity Float Float
    | CAxTickSize Float Float
    | CAxGridWidth Float Float


{-| Generated by [coArea](#coArea), [coAutosize](#coAutosize), [coAxis](#coAxis),
[coAxisX](#coAxisX), [coAxisY](#coAxisY), [coAxisLeft](#coAxisLeft),
[coAxisRight](#coAxisRight), [coAxisTop](#coAxisTop),
[coAxisBottom](#coAxisBottom), [coAxisBand](#coAxisBand), [coBackground](#coBackground),
[coBar](#coBar), [coCircle](#coCircle), [coConcat](#coConcat), [coCountTitle](#coCountTitle),
[coFieldTitle](#coFieldTitle), [coGeoshape](#coGeoshape), [coFacet](#coFacet),
[coHeader](#coHeader), [coLegend](#coLegend), [coLine](#coLine), [coMark](#coMark),
[coNamedStyle](#coNamedStyle), [coNamedStyles](#coNamedStyles),
[coNumberFormat](#coNumberFormat), [coPadding](#coPadding), [coPoint](#coPoint),
[coProjection](#coProjection), [coRange](#coRange), [coRect](#coRect), [coRule](#coRule),
[coScale](#coScale), [coSelection](#coSelection), [coSquare](#coSquare),
[coText](#coText), [coTick](#coTick), [coTitle](#coTitle), [coTimeFormat](#coTimeFormat),
[coTrail](#coTrail) and [coView](#coView).
-}
type ConfigurationProperty
    = AreaStyle (List MarkProperty)
    | Autosize (List Autosize)
    | Axis (List AxisConfig)
    | AxisX (List AxisConfig)
    | AxisY (List AxisConfig)
    | AxisLeft (List AxisConfig)
    | AxisRight (List AxisConfig)
    | AxisTop (List AxisConfig)
    | AxisBottom (List AxisConfig)
    | AxisBand (List AxisConfig)
    | Background String
    | BarStyle (List MarkProperty)
    | CircleStyle (List MarkProperty)
    | ConcatStyle (List ConcatConfig)
    | CountTitle String
    | FieldTitle FieldTitleProperty
    | GeoshapeStyle (List MarkProperty)
    | Legend (List LegendConfig)
    | LineStyle (List MarkProperty)
    | FacetStyle (List FacetConfig)
    | HeaderStyle (List HeaderProperty)
    | MarkStyle (List MarkProperty)
    | NamedStyle String (List MarkProperty)
    | NamedStyles (List ( String, List MarkProperty ))
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
    | Stack StackOffset
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
[cuZoomIn](#cuZoomIn), [cuZoomOut](#cuZoomOut), [cuGrab](#cuGrab) and
[cuGrabbing](#cuGrabbing).
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
[num](#num), [str](#str) and [nullValue](#nullValue).
-}
type DataValue
    = Boolean Bool
    | DateTime (List DateTime)
    | Number Float
    | Str String
    | NullValue


{-| Generated by [boos](#boos), [dts](#dts), [nums](#nums) and [strs](#strs).
-}
type DataValues
    = Booleans (List Bool)
    | DateTimes (List (List DateTime))
    | Numbers (List Float)
    | Strings (List String)


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
    | DnExtent DataValue DataValue
    | DnMinSteps Int
    | DnMaxSteps Int
    | DnSteps Int
    | DnAs String String


{-| Generated by [dName](#dName), [dMType](#dMType), [dAggregate](#dAggregate),
[dBin](#dBin) and [dTimeUnit](#dTimeUnit).
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


{-| Generated by [fName](#fName), [fMType](#fMType), [fAggregate](#fAggregate),
[fBin](#fBin), [fSort](#fSort), [fHeader](#fHeader), [fTimeUnit](#fTimeUnit),
[fAlign](#fAlign), [fCenter](#fCenter) and [fSpacing](#fSpacing).
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
[fiSelection](#fiSelection), [fiOneOf](#fiOneOf), [fiRange](#fiRange) and
[fiValid](#fiValid).
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
    | FOneOf String DataValues
    | FRange String FilterRange
    | FValid String


{-| Generated by [numRange](#numRange) and [dtRange](#dtRange).
-}
type FilterRange
    = NumberRange Float Float
    | DateRange (List DateTime) (List DateTime)


{-| Weight options for a font.
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


{-| Generated by [haLeft](#haLeft), [haCenter](#haCenter) and [haRight](#haRight).
-}
type HAlign
    = AlignCenter
    | AlignLeft
    | AlignRight


{-| Generated by [hdFormat](#hdFormat), [hdFormatAsNum](#hdFormatAsNum),
[hdFormatAsTemporal](#hdFormatAsTemporal), [hdLabelAlign](#hdLabelAlign),
[hdLabelAnchor](#hdLabelAnchor), [hdLabelAngle](#hdLabelAngle), [hdLabelColor](#hdLabelColor),
[hdLabelFont](#hdLabelFont), [hdLabelFontSize](#hdLabelFontSize), [hdLabelLimit](#hdLabelLimit),
[hdLabelOrient](#hdLabelOrient), [hdLabelPadding](#hdLabelPadding), [hdTitle](#hdTitle),
[hdTitleAlign](#hdTitleAlign), [hdTitleAnchor](#hdTitleAnchor), [hdTitleAngle](#hdTitleAngle),
[hdTitleBaseline](#hdTitleBaseline), [hdTitleColor](#hdTitleColor), [hdTitleFont](#hdTitleFont),
[hdTitleFontWeight](#hdTitleFontWeight), [hdTitleFontSize](#hdTitleFontSize),
[hdTitleLimit](#hdTitleLimit), [hdTitleOrient](#hdTitleOrient), and [hdTitlePadding](#hdTitlePadding).
-}
type HeaderProperty
    = HFormat String
    | HFormatAsNum
    | HFormatAsTemporal
    | HTitle String
    | HLabelAlign HAlign
    | HLabelAnchor Anchor
    | HLabelAngle Float
    | HLabelColor String
    | HLabelFont String
    | HLabelFontSize Float
    | HLabelLimit Float
    | HLabelOrient Side
    | HLabelPadding Float
    | HTitleAlign HAlign
    | HTitleAnchor Anchor
    | HTitleAngle Float
    | HTitleBaseline VAlign
    | HTitleColor String
    | HTitleFont String
    | HTitleFontWeight String
    | HTitleFontSize Float
    | HTitleLimit Float
    | HTitleOrient Side
    | HTitlePadding Float


{-| Generated by [hName](#hName), [hRepeat](#hRepeat), [hMType](#hMType), [hBin](#hBin),
[hBinned](#hBinned), [hAggregate](#hAggregate), [hTimeUnit](#hTimeUnit),
[hDataCondition](#hDataCondition), [hSelectionCondition](#hSelectionCondition)
and [hStr](#hStr).
-}
type HyperlinkChannel
    = HName String
    | HRepeat Arrangement
    | HmType Measurement
    | HBin (List BinProperty)
    | HBinned
    | HAggregate Operation
    | HTimeUnit TimeUnit
    | HSelectionCondition BooleanOp (List HyperlinkChannel) (List HyperlinkChannel)
    | HDataCondition BooleanOp (List HyperlinkChannel) (List HyperlinkChannel)
    | HString String


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
[inOptions](#inOptions), [inMin](#inMin), [inMax](#inMax), [inName](#inName),
[inStep](#inStep) and [inPlaceholder](#inPlaceholder).
-}
type InputProperty
    = Debounce Float
    | Element String
    | InOptions (List String)
    | InMin Float
    | InMax Float
    | InName String
    | InStep Float
    | InPlaceholder String


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


{-| Generated by [lecoClipHeight](#lecoClipHeight), [lecoColumnPadding](#lecoColumnPadding),
[lecoColumns](#lecoColumns), [lecoCornerRadius](#lecoCornerRadius), [lecoFillColor](#lecoFillColor),
[lecoOrient](#lecoOrient), [lecoOffset](#lecoOffset), [lecoStrokeColor](#lecoStrokeColor),
[lecoStrokeDash](#lecoStrokeDash), [lecoStrokeWidth](#lecoStrokeWidth), [lecoPadding](#lecoPadding),
[lecoRowPadding](#lecoRowPadding), [lecoGradientDirection](#lecoGradientDirection),
[lecoGradientLabelBaseline](#lecoGradientLabelBaseline), [lecoGradientLabelLimit](#lecoGradientLabelLimit),
[lecoGradientLabelOffset](#lecoGradientLabelOffset), [lecoGradientStrokeColor](#lecoGradientStrokeColor),
[lecoGradientStrokeWidth](#lecoGradientStrokeWidth), [lecoGradientHeight](#lecoGradientHeight),
[lecoGradientWidth](#lecoGradientWidth), [lecoGridAlign](#lecoGridAlign),
[lecoLabelAlign](#lecoLabelAlign), [lecoLabelBaseline](#lecoLabelBaseline),
[lecoLabelColor](#lecoLabelColor), [lecoLabelFont](#lecoLabelFont),
[lecoLabelFontSize](#lecoLabelFontSize), [lecoLabelLimit](#lecoLabelLimit),
[lecoLabelOffset](#lecoLabelOffset), [lecoLabelOverlap](#lecoLabelOverlap),
[lecoShortTimeLabels](#lecoShortTimeLabels), [lecoEntryPadding](#lecoEntryPadding),
[lecoSymbolBaseFillColor](#lecoSymbolBaseFillColor),
[lecoSymbolBaseStrokeColor](#lecoSymbolBaseStrokeColor), [lecoSymbolDirection](#lecoSymbolDirection),
[lecoSymbolFillColor](#lecoSymbolFillColor), [lecoSymbolOffset](#lecoSymbolOffset),
[lecoSymbolSize](#lecoSymbolSize), [lecoSymbolStrokeColor](#lecoSymbolStrokeColor),
[lecoSymbolStrokeWidth](#lecoSymbolStrokeWidth), [lecoSymbolType](#lecoSymbolType),
[lecoTitleAlign](#lecoTitleAlign), [lecoTitleBaseline](#lecoTitleBaseline),
[lecoTitleColor](#lecoTitleColor), [lecoTitleFont](#lecoTitleFont),
[lecoTitleFontSize](#lecoTitleFontSize), [lecoTitleFontWeight](#lecoTitleFontWeight),
[lecoTitleLimit](#lecoTitleLimit), [lecotTitleLineHeight](#lecoTitleLineHeight)
and [lecoTitlePadding](#lecoTitlePadding).
-}
type LegendConfig
    = LeClipHeight Float
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
    | GradientStrokeColor String
    | GradientStrokeWidth Float
    | GradientWidth Float
    | LeGridAlign CompositionAlignment
    | LeLabelAlign HAlign
    | LeLabelBaseline VAlign
    | LeLabelColor String
    | LeLabelFont String
    | LeLabelFontSize Float
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
    | SymbolDirection MarkOrientation
    | SymbolFillColor String
    | SymbolOffset Float
    | SymbolType Symbol
    | SymbolSize Float
    | SymbolStrokeWidth Float
    | SymbolStrokeColor String
    | LeTitleAlign HAlign
    | LeTitleBaseline VAlign
    | LeTitleColor String
    | LeTitleFont String
    | LeTitleFontSize Float
    | LeTitleFontWeight FontWeight
    | LeTitleLimit Float
    | LeTitleLineHeight Float
    | LeTitlePadding Float


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


{-| Generated by [leGradient](#leGradient), [leSymbol](#leSymbol), [leClipHeight](#leClipHeight),
[leColumnPadding](#leColumnPadding), [leColumns](#leColumns), [leCornerRadius](#leCornerRadius),
[leDirection](#leDirection), [leFillColor](#leFillColor), [leFormat](#leFormat),
[leFormatAsNum](#leFormatAsNum), [leFormatAsTemporal](#leFormatAsTemporal),
[leGradientLength](#leGradientLength), [leGradientThickness](#leGradientThickness),
[leGradientStrokeColor](#leGradientStrokeColor), [leGradientStrokeWidth](#leGradientStrokeWidth),
[leGridAlign](#leGridAlign), [leLabelAlign](#leLabelAlign), [leLabelBaseline](#leLabelBaseline),
[leLabelColor](#leLabelColor), [leLabelFont](#leLabelFont), [leLabelFontSize](#leLabelFontSize),
[leLabelLimit](#leLabelLimit), [leLabelOffset](#leLabelOffset), [leLabelOverlap](#leLabelOverlap),
[leOffset](#leOffset), [leOrient](#leOrient), [lePadding](#lePadding),
[leRowPadding](#leRowPadding), [leStrokeColor](#leStrokeColor), [leStrokeWidth](#leStrokeWidth),
[leSymbolFillColor](#leSymbolFillColor), [leSymbolSize](#leSymbolSize),
[leSymbolStrokeColor](#leSymbolStrokeColor), [leSymbolStrokeWidth](#leSymbolStrokeWidth),
[leSymbolType](#leSymbolType), [leTickCount](#leTickCount), [leTitle](#leTitle),
[leTitleAlign](#leTitleAlign), [leTitleBaseline](#leTitleBaseline), [leTitleColor](#leTitleColor),
[leTitleFont](#leTitleFont), [leTitleFontSize](#leTitleFontSize),
[leTitleFontWeight](#leTitleFontWeight), [leTitleLimit](#leTitleLimit),
[leTitlePadding](#leTitlePadding), [leType](#leType), [leValues](#leValues),
[leX](#leX), [leY](#leY) and [leZIndex](#leZIndex).
-}
type LegendProperty
    = LClipHeight Float
    | LColumnPadding Float
    | LColumns Float
    | LCornerRadius Float
    | LDirection MarkOrientation
    | LFillColor String
    | LFormat String
    | LFormatAsNum
    | LFormatAsTemporal
    | LGradientLength Float
    | LGradientThickness Float
    | LGradientStrokeColor String
    | LGradientStrokeWidth Float
    | LGridAlign CompositionAlignment
    | LLabelAlign HAlign
    | LLabelBaseline VAlign
    | LLabelColor String
    | LLabelFont String
    | LLabelFontSize Float
    | LLabelLimit Float
    | LLabelOffset Float
    | LLabelOverlap OverlapStrategy
    | LOffset Float
    | LOrient LegendOrientation
    | LPadding Float
    | LRowPadding Float
    | LStrokeColor String
    | LStrokeWidth Float
    | LSymbolFillColor String
    | LSymbolType Symbol
    | LSymbolSize Float
    | LSymbolStrokeWidth Float
    | LSymbolStrokeColor String
    | LTickCount Float
    | LTitle String
    | LTitleAlign HAlign
    | LTitleBaseline VAlign
    | LTitleColor String
    | LTitleFont String
    | LTitleFontSize Float
    | LTitleFontWeight FontWeight
    | LTitleLimit Float
    | LTitlePadding Float
    | LType Legend
    | LValues LegendValues
    | LeX Float
    | LeY Float
    | LZIndex Int


{-| Generated by [leNums](#leNums), [leStrs](#leStrs) and [leDts](#leDts).
-}
type LegendValues
    = LDateTimes (List (List DateTime))
    | LNumbers (List Float)
    | LStrings (List String)


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


{-| Generated by
[area](#area), [bar](#bar), [boxplot](#boxplot), [circle](#circle), [errorband](#errorband),
[errorbar](#errorbar), [geoshape](#geoshape), [image](#image), [line](#line),
[point](#point), [rect](#rect), [rule](#rule),[square](#square), [textMark](#textMark),
[tick](#tick) and [trail](#trail).
-}
type Mark
    = Area
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


{-| Generated by [mName](#mName), [mRepeat](#mRepeat), [mMType](#mMType), [mScale](#mScale),
[mBin](#mBin), [mBinned](#mBinned), [mTimeUnit](#mTimeUnit), [mTitle](#mTitle),
[mAggregate](#mAggregate), [mLegend](#mLegend), [mSort](#mSort),
[mSelectionCondition](#mSelectionCondition), [mDataCondition](#mDataCondition),
[mPath](#mPath), [mNum](#mNum), [mStr](#mStr) and [mBoo](#mBoo).
-}
type MarkChannel
    = MName String
    | MRepeat Arrangement
    | MmType Measurement
    | MScale (List ScaleProperty)
    | MBin (List BinProperty)
    | MBinned
    | MSort (List SortProperty)
    | MTimeUnit TimeUnit
    | MTitle String
    | MAggregate Operation
    | MLegend (List LegendProperty)
    | MSelectionCondition BooleanOp (List MarkChannel) (List MarkChannel)
    | MDataCondition (List ( BooleanOp, List MarkChannel )) (List MarkChannel)
    | MPath String
    | MNumber Float
    | MString String
    | MBoolean Bool


{-| Generated by [miBasis](#miBasis), [miBasisClosed](#miBasisClosed),
[miBasisOpen](#miBasisOpen), [miBundle](#miBundle), [miCardinal](#miCardinal),
[miCardinalClosed](#miCardinalClosed), [miCardinalOpen](#miCardinalOpen),
[miLinear](#miLinear), [miLinearClosed](#miLinearClosed), [miMonotone](#miMonotone),
[miStepwise](#miStepwise), [miStepAfter](#miStepAfter) and [miStepBefore](#miStepBefore).
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


{-| Generated by [moHorizontal](#moHorizontal) and [moVertical](#moVertical).
-}
type MarkOrientation
    = MOHorizontal
    | MOVertical


{-| Generated by [maAlign](#maAlign), [maAngle](#maAngle), [maBandSize](#maBandSize),
[maBaseline](#maBaseline), [maBinSpacing](#maBinSpacing), [maBorders](#maBorders),
[maBox](#maBox), [maClip](#maClip), [maColor](#maColor), [maColorGradient](#maColorGradient),
[maCornerRadius](#maCornerRadius), [maCornerRadiusEnd](#maCornerRadiusEnd),
[maCornerRadiusTopLeft](#maCornerRadiusTopLeft), [maCornerRadiusTopRight](#maCornerRadiusTopRightR),
[maCornerRadiusBottomLeft](#maCornerRadiusBottomLeft), [maCornerRadiusBottomRight](#maCornerRadiusBottomRight),
[maCursor](#maCursor), [maHRef](#maHRef), [maContinuousBandSize](#maContinuousBandSize),
[maDir](#maDir), [maDiscreteBandSize](#maDiscreteBandSize), [maDx](#maDx), [maDy](#maDy),
[maEllipsis](#maEllipsis), [maExtent](#maExtent), [maFill](#maFill), [maFillGradient](#maFillGradient),
[maFilled](#maFilled), [maFillOpacity](#maFillOpacity), [maFont](#maFont), [maFontSize](#maFontSize),
[maFontStyle](#maFontStyle), [maFontWeight](#maFontWeight), [maInterpolate](#maInterpolate),
[maLimit](#maLimit), [maLine](#maLine), [maMedian](#maMedian), [maOpacity](#maOpacity),
[maOutliers](#maOutliers), [maOrient](#maOrient), [maPoint](#maPoint), [maRadius](#maRadius),
[maRemoveInvalid](#maRemoveInvalid), [maRule](#maRule), [maShape](#maShape),
[maShortTimeLabels](#maShortTimeLabels), [maSize](#maSize), [maStroke](#maStroke),
[maStrokeGradient](#maStrokeGradient), [maStrokeCap](#maStrokeCap), [maStrokeDash](#maStrokeDash),
[maStrokeDashOffset](#maStrokeDashOffset), [maStrokeJoin](#maStrokeJoin), [maStrokeMiterLimit](#maStrokeMiterLimit),
[maStrokeOpacity](#maStrokeOpacity), [maStrokeWidth](#maStrokeWidth), [maStyle](#maStyle),
[maTension](#maTension), [maText](#maText), [maTheta](#maTheta), [maThickness](#maThickness),
[maTicks](#maTicks), [maTooltip](#maTooltip), [maX](#maX), [maWidth](#maWidth),
[maHeight](#maHeight), [maY](#maY), [maXOffset](#maXOffset), [maYOffset](#maYOffset),
[maX2](#maX2), [maY2](#maY2), [maX2Offset](#maX2Offset) and [maY2Offset](#maY2Offset).
-}
type
    MarkProperty
    -- Note some of the following properties are specific options for particular
    -- types of mark (e.g. `bar`, `textMark` and `tick`) but for simplicity of the API,
    -- carry over for the general case: MBandSize, MBinSpacing, MClip, MContinuousBandSize,
    -- MDiscreteBandSize, MShortTimeLabels and  MThickness.
    = MAlign HAlign
    | MAngle Float
    | MBandSize Float
    | MBaseline VAlign
    | MBinSpacing Float
    | MBorders (List MarkProperty)
    | MBox (List MarkProperty)
    | MClip Bool
    | MColor String
    | MColorGradient ColorGradient (List GradientProperty)
    | MCornerRadius Float
    | MCornerRadiusEnd Float
    | MCornerRadiusTL Float
    | MCornerRadiusTR Float
    | MCornerRadiusBL Float
    | MCornerRadiusBR Float
    | MCursor Cursor
    | MHRef String
    | MContinuousBandSize Float
    | MLimit Float
    | MEllipsis String
    | MDir TextDirection
    | MDiscreteBandSize Float
    | MdX Float
    | MdY Float
    | MExtent SummaryExtent
    | MFill String
    | MFillGradient ColorGradient (List GradientProperty)
    | MFilled Bool
    | MFillOpacity Float
    | MFont String
    | MFontSize Float
    | MFontStyle String
    | MFontWeight FontWeight
    | MInterpolate MarkInterpolation
    | MLine LineMarker
    | MMedian (List MarkProperty)
    | MOpacity Float
    | MOutliers (List MarkProperty)
    | MOrder Bool
    | MOrient MarkOrientation
    | MPoint PointMarker
    | MRadius Float
    | MRemoveInvalid Bool
    | MRule (List MarkProperty)
    | MShape Symbol
    | MShortTimeLabels Bool
    | MSize Float
    | MStroke String
    | MStrokeGradient ColorGradient (List GradientProperty)
    | MStrokeCap StrokeCap
    | MStrokeDash (List Float)
    | MStrokeDashOffset Float
    | MStrokeJoin StrokeJoin
    | MStrokeMiterLimit Float
    | MStrokeOpacity Float
    | MStrokeWidth Float
    | MStyle (List String)
    | MTension Float
    | MText String
    | MTheta Float
    | MThickness Float
    | MTicks (List MarkProperty)
    | MTooltip TooltipContent
    | MWidth Float
    | MHeight Float
    | MX Float
    | MY Float
    | MX2 Float
    | MY2 Float
    | MXOffset Float
    | MYOffset Float
    | MX2Offset Float
    | MY2Offset Float
    | MAspect Bool


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
[opQ1](#opQ1), [opQ3](#opQ3), [opStderr](#opStderr), [opStdev](#opStdev),
[opStdevP](#opStdevP), [opSum](#opSum), [opValid](#opValid),
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
    | Q1
    | Q3
    | Stderr
    | Stdev
    | StdevP
    | Sum
    | Valid
    | Variance
    | VarianceP


{-| Generated by [OName](#oName), [oRepeat](#oRepeat), [oMType](#oMType), [oBin](#oBin),
[oAggregate](#oAggregate), [oTimeUnit](#oTimeUnit) and [oSort](#oSort).
-}
type OrderChannel
    = OName String
    | ORepeat Arrangement
    | OmType Measurement
    | OBin (List BinProperty)
    | OAggregate Operation
    | OTimeUnit TimeUnit
    | OSort (List SortProperty)


{-| Generated by [osNone](#osNone), [osGreedy](#osGreedy) and [osParity](#osParity).
-}
type OverlapStrategy
    = ONone
    | OParity
    | OGreedy


{-| Generated by [paSize](#paSize) and [paEdges](#paEdges).
-}
type Padding
    = PSize Float
    | PEdges Float Float Float Float


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

`Longitude`/`Longitude2` and `Latitude`/`Latitude2` are the equivalent for
geographic positioning subject to [projection](#prejection).

`XError`/`XError2` and `YError`/`YError2` are used when specifying bounds of an
[errorbar](#errorbar) mark.

-}
type Position
    = X
    | Y
    | X2
    | Y2
    | Longitude
    | Latitude
    | Longitude2
    | Latitude2
    | XError
    | YError
    | XError2
    | YError2


{-| Generated by [pName](#pName), [pRepeat](#pRepeat), [pMType](#pMType), [pBin](#PBin),
[pBinned](#pBinned), [pTimeUnit](#pTimeUnit), [pTitle](#pTitle), [pAggregate](#pAggregate),
[pScale](#pScale), [pAxis](#pAxis), [pSort](#pSort), [pBand](#pBand), [pStack](#pStack),
[pWidth](#pWidth), [pHeight](#pHeight), [pNum](#pNum) and [pImpute](#pImpute).
-}
type PositionChannel
    = PName String
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
    | PBand Float
    | PStack StackOffset
    | PImpute (List ImputeProperty)


{-| Generated by [albers](#albers), [albersUsa](#albersUsa),
[azimuthalEqualArea](#azimuthalEqualArea), [azimuthalEquidistant](#azimuthalEquidistant),
[conicConformal](#conicConformal), [conicEqualArea](#conicEqualArea),
[conicEquidistant](#conicEquidistant), [equalEarth](#equalEarth),
[equirectangular](#equirectangular), [gnomonic](#gnomonic),
[identityProjection](#identityProjection), [mercator](#mercator), [naturalEarth1](#naturalEarth1)
[orthographic](#orthographic), [stereographic](#stereographic),
[transverseMercator](#transverseMercator) and [customProjection](#customProjection).
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


{-| Generated by [prType](#prType), [prClipAngle](#prClipAngle), [prClipExtent](#prClipExtent),
[prCenter](#prCenter), [prScale](#prScale), [prTranslate](#prTranslate), [prRotate](#prRotate),
[prPrecision](#prPrecision), [prCoefficient](#prCoefficient), [prDistance](#prDistance),
[prFraction](#prFraction), [prLobes](#prLobes), [prReflectX](#prReflectX),
[prReflectY](#prReflectY), [prParallel](#prParallel), [prRadius](#prRadius),
[prRatio](#prRatio), [prSpacing](#prSpacing) and [prTilt](#prTilt).
-}
type ProjectionProperty
    = PType Projection
    | PClipAngle (Maybe Float)
    | PClipExtent ClipRect
    | PCenter Float Float
    | PrScale Float
    | PrTranslate Float Float
    | PrRotate Float Float Float
    | PPrecision Float
    | PReflectX Bool
    | PReflectY Bool
    | PCoefficient Float
    | PDistance Float
    | PFraction Float
    | PLobes Int
    | PParallel Float
    | PRadius Float
    | PRatio Float
    | PSpacing Float
    | PTilt Float


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
[rgExtent](#rgExtent) and [rgAs](#rgAs).
-}
type RegressionProperty
    = RgGroupBy (List String)
    | RgMethod RegressionMethod
    | RgOrder Int
    | RgExtent DataValue DataValue
    | RgAs String String


{-| Generated by [rowFields](#rowFields) and [columnFields](#columnFields).
-}
type RepeatFields
    = RowFields (List String)
    | ColumnFields (List String)


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
[scBinLinear](#scBinLinear), [scBinOrdinal](#scBinOrdinal), [scQuantile](#scQuantile),
[scQuantize](#scQuantize) and [scThreshold](#scThreshold).
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
    | ScBinLinear
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
[sacoPointPadding](#sacoPointPadding), [sacoRound](#sacoRound) and
[sacoUseUnaggregatedDomain](#sacoUseUnaggregatedDomain).
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
    | SCRangeStep (Maybe Float)
    | SCRound Bool
    | SCTextXRangeStep Float
    | SCUseUnaggregatedDomain Bool


{-| Generated by [doNums](#doNums), [doStrs](#doStrs), [doDts](#doDts),
[doSelection](#doSelection) and [doUnaggregated](#doUnaggregated).
-}
type ScaleDomain
    = DNumbers (List Float)
    | DStrings (List String)
    | DDateTimes (List (List DateTime))
    | DSelection String
    | Unaggregated


{-| Generated by [niTrue](#niTrue), [niFalse](#niFalse), [niMillisecond](#niMillisecond),
[niSecond](#niSecond), [niMinute](#niMinute), [niHour](#niHour), [niDay](#niDay),
[niWeek](#niWeek), [niMonth](#niMonth), [niYear](#niYear), [niTickCount](#niTickCount)
and [niInterval](#niInterval).
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


{-| Generated by [scType](#scType), [scDomain](#scDomain), [scRange](#scRange),
[scScheme](#scScheme), [scAlign](#scAlign), [scPadding](#scPadding),
[scPaddingInner](#scPaddingInner), [scPaddingOuter](#scPaddingOuter), [scRound](#scRound),
[scClamp](#scClamp), [scInterpolate](#scInterpolate), [scNice](#scNice),
[scDomainMid](#scDomainMid), [scExponent](#scExponent), [scConstant](#scConstant),
[scBase](#scBase), [scZero](#scZero) and [scReverse](#scReverse).
-}
type ScaleProperty
    = SType Scale
    | SDomain ScaleDomain
    | SRange ScaleRange
    | SScheme String (List Float)
    | SAlign Float
    | SPadding Float
    | SPaddingInner Float
    | SPaddingOuter Float
    | SRangeStep (Maybe Float)
    | SRound Bool
    | SClamp Bool
      -- TODO:  Need to restrict set of valid scale types that work with color interpolation.
    | SInterpolate CInterpolate
    | SNice ScaleNice
    | SZero Bool
    | SExponent Float
    | SDomainMid Float
    | SConstant Float
    | SBase Float
    | SReverse Bool


{-| Generated by [raNums](#raNums), [raStrs](#raStrs) and [raName](#raName).
-}
type ScaleRange
    = RNumbers (List Float)
    | RStrings (List String)
    | RName String


{-| Generated by [seInterval](#seInterval), [seSingle](#seSingle) and [seMulti](#seMulti).
-}
type Selection
    = SeSingle
    | SeMulti
    | SeInterval


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


{-| Generated by [seBind](#seBind), [seBindLegend](#seBindLegend), [seBindScales](#seBindScales),
[seEmpty](#seEmpty), [seClear](#seClear), [seEncodings](#seEncodings),[seFields](#seFields),
[seInit](#seInit), [seInitInterval](#seInitInterval), [seNearest](#seNearest), [seOn](#seOn),
[seResolve](#seResolve), [seSelectionMark](#seSelectionMark), [seToggle](#seToggle),
[seTranslate](#seTranslate) and [seZoom](#seZoom).
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
    | Toggle String


{-| Generated by [seGlobal](#seGlobal), [seUnion](#seUnion) and
[seIntersection](#seIntersection).
-}
type SelectionResolution
    = SeGlobal
    | SeUnion
    | SeIntersection


{-| Generated by [siLeft](#siLeft), [siRight](#siRight), [siTop](#siTop),
and [siBottom](#siBottom)
-}
type Side
    = STop
    | SBottom
    | SLeft
    | SRight


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


{-| Generated by [caButt](#caButt), [caRound](#caRound) and [caSquare](#caSquare).
-}
type StrokeCap
    = CButt
    | CRound
    | CSquare


{-| Generated by [joMiter](#joMiter), [joRound](#joRound) and [joBevel](#joBevel).
-}
type StrokeJoin
    = JMiter
    | JRound
    | JBevel


{-| Generated by [symCircle](#symCircle), [symSquare](#symSquare), [symCross](#symCross),
[symDiamond](#symDiamond), [symTriangleUp](#symTriangleUp), [symTriangleDown](#symTriangleDown),
[symTriangleLeft](#symTriangleLeft), [symTriangleRight](#symTriangleRight), [symPath](#symPath),
[symStroke](#symStroke), [symArrow](#symArrow), [symWedge](#symWedge) and
[symTriangle](#symTriangle).
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


{-| Generated by [tName](#tName), [tRepeat](#tRepeat), [tMType](#tMType),
[tBin](#tBin), [tBinned](#tBinned), [tAggregate](#tAggregate), [tTimeUnit](#tTimeUnit),
[tTitle](#tTitle), [tSelectionCondition](#tSelectionCondition),
[tDataCondition](#tDataCondition), [tFormat](#tFormat), [tFormatAsNum](#tFormatAsNum),
[tFormatAsTemporal](#tFormatAsTemporal) and [tStr](#tStr).
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
    | TSelectionCondition BooleanOp (List TextChannel) (List TextChannel)
    | TDataCondition (List ( BooleanOp, List TextChannel )) (List TextChannel)
    | TFormat String
    | TFormatAsNum
    | TFormatAsTemporal
    | TString String


{-| Generated by [tdLeftToRight](#tdLeftToRight) and [tdRightToLeft](#tdRightToLeft).
-}
type TextDirection
    = LeftToRight
    | RightToLeft


{-| Generated by [date](#date), [day](#day), [hours](#hours), [hoursMinutes](#hoursMinutes),
[hoursMinutesSeconds](#hoursMinutesSeconds), [milliseconds](#milliseconds),
[minutes](#minutes), [minutesSeconds](#minutesSeconds), [month](#month), [monthDate](#monthDate),
[quarter](#quarter), [quarterMonth](#quarterMonth), [seconds](#seconds),
[secondsMilliseconds](#secondsMilliseconds), [year](#year), [yearQuarter](#yearQuarter),
[yearQuarterMonth](#yearQuarterMonth), [yearMonth](#yearMonth), [yearMonthDate](#yearMonthDate),
[yearMonthDateHours](#yearMonthDateHours), [yearMonthDateHoursMinutes](#yearMonthDateHoursMinutes),
[yearMonthDateHoursMinutesSeconds](#yearMonthDateHoursMinutesSeconds), [utc](#utc),
[tuMaxBins](#tuMaxBins) and [tuStep](#tuStep).
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
    | Quarter
    | QuarterMonth
    | Month
    | MonthDate
    | MonthDateHours
    | Date
    | Day
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
[ticoColor](#ticoColor), [ticoFont](#ticoFont), [ticoFontSize](#ticoFontSize),
[ticoFontStyle](#ticoFontStyle), [ticoFontWeivght](#ticoFontWeight), [ticoFrame](#ticoFrame),
[ticoLimit](#ticoLimit), [ticoLineHeight](#ticoLineHeight), [ticoOffset](#ticoOffset),
[ticoOrient](#ticoOrient), [ticoStyle](#ticoStyle) [ticoSubtitleColor](#ticoSubtitleColor),
[ticoSubtitleFont](#ticoSubtitleFont), [ticoSubtitleFontSize](#ticoSubtitleFontSize),
[ticoSubtitleFontStyle](#ticoSubtitleFontStyle), [ticoSubtitleFontWeight](#ticoSubtitleFontWeight),
[ticoSubtitleLineHeight](#ticoSubtitleLineHeight), [ticoSubtitlePadding](#ticoSubtitlePadding)
and [ticoZIndex](#ticoZIndex).
-}
type TitleConfig
    = TAnchor Anchor
    | TAngle Float
    | TBaseline VAlign
    | TColor String
    | TFont String
    | TFontSize Float
    | TFontStyle String
    | TFontWeight FontWeight
    | TFrame TitleFrame
    | TLineHeight Float
    | TLimit Float
    | TOffset Float
    | TOrient Side
    | TStyle (List String)
    | TSubtitle String
    | TSubtitleColor String
    | TSubtitleFont String
    | TSubtitleFontSize Float
    | TSubtitleFontStyle String
    | TSubtitleFontWeight FontWeight
    | TSubtitleLineHeight Float
    | TSubtitlePadding Float
    | TZIndex Int


{-| Generated by [tfBounds](#tfBounds) and [tfGroup](#tfGroup).
-}
type TitleFrame
    = FrBounds
    | FrGroup


{-| Generated by [tiAnchor](#tiAnchor), [tiAngle](#tiAngle), [tiBaseline](#tiBaseline),
[tiColor](#tiColor), [tiFont](#tiFont), [tiFontSize](#tiFontSize),
[tiFontStyle](#tiFontStyle), [tiFontWeivght](#tiFontWeight), [tiFrame](#tiFrame),
[tiLimit](#tiLimit), [tiOffset](#tiOffset), [tiOrient](#tiOrient), [tiStyle](#tiStyle)
[tiSubtitle](#tiSubtitle), [tiSubtitleColor](#tiSubtitleColor), [tiSubtitleFont](#tiSubtitleFont),
[tiSubtitleFontSize](#tiSubtitleFontSize), [tiSubtitleFontStyle](#tiSubtitleFontStyle),
[tiSubtitleFontWeight](#tiSubtitleFontWeight), [tiSubtitleLineHeight](#tiSubtitleLineHeight),
[tiSubtitlePadding](#tiSubtitlePadding) and [tiZIndex](#tiZIndex).
-}
type alias TitleProperty =
    TitleConfig


{-| Generated by [ttEncoding](#ttEncoding), [ttData](#ttData) and [ttNone](#ttNone).
-}
type TooltipContent
    = TTEncoding
    | TTData
    | TTNone


{-| Generated by [vaTop](#vaTop), [vaMiddle](#vaMiddle), [vaAlphabetic](#vaAlphabetic)
and [vaBottom](#vaBottom).
-}
type VAlign
    = AlignTop
    | AlignMiddle
    | AlignBottom
    | AlignAlphabetic


{-| Generated by [viewStyle](#viewStyle), [viewCornerRadius](#viewCornerRadius),
[viewFill](#viewFill), [viewFillOpacity](#viewFillOpacity), [viewOpacity](#viewOpacity),
[viewStroke](#viewStroke), [viewStrokeOpacity](#viewStrokeOpacity), [viewStrokeWidth](#viewStrokeWidth),
[viewStrokeCap](#viewStrokeCap), [viewStrokeDash](#viewStrokeDash), [viewStrokeDashOffset](#viewStrokeDashOffset),
[viewStrokeJoin](#viewStrokeJoin) and [viewStrokeMiterLimit](#viewStrokeMiterLimit).
-}
type ViewBackground
    = VBStyle (List String)
    | VBCornerRadius Float
    | VBFill (Maybe String)
    | VBFillOpacity Float
    | VBOpacity Float
    | VBStroke (Maybe String)
    | VBStrokeOpacity Float
    | VBStrokeWidth Float
    | VBStrokeCap StrokeCap
    | VBStrokeDash (List Float)
    | VBStrokeDashOffset Float
    | VBStrokeJoin StrokeJoin
    | VBStrokeMiterLimit Float


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
[`description`](#description), [`background`](#background), [`width`](#width),
[`height`](#height), [`widthStep`](#widthStep), [`heightStep`](#heightStep),
[`padding`](#padding), [`autosize`](#autosize), [`viewBackground`](#viewBackground)
and [`configure`](#configure).

-}
type VLProperty
    = VLName
    | VLDescription
    | VLTitle
    | VLWidth
    | VLHeight
    | VLWidthStep
    | VLHeightStep
    | VLAutosize
    | VLPadding
    | VLBackground
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


{-| Column arrangement in a repeated/faceted view.
-}
arColumn : Arrangement
arColumn =
    Column


{-| An [area mark](https://vega.github.io/vega-lite/docs/area.html) for representing
a series of data elements, such as in a stacked area chart or streamgraph.
-}
area : List MarkProperty -> ( VLProperty, Spec )
area =
    mark Area


{-| Flow arrangement in a repeated/faceted view.
-}
arFlow : Arrangement
arFlow =
    Flow


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


{-| Position of axis tick relative to a band (0 to 1).
-}
axBandPosition : Float -> AxisProperty
axBandPosition =
    AxBandPosition


{-| Default axis band position.
-}
axcoBandPosition : Float -> AxisConfig
axcoBandPosition =
    BandPosition


{-| Whether or not an axis domain should be displayed by default.
-}
axcoDomain : Bool -> AxisConfig
axcoDomain =
    Domain


{-| Default axis domain color.
-}
axcoDomainColor : String -> AxisConfig
axcoDomainColor =
    DomainColor


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


{-| Make an axis property (tick, grid or label) conditional on one or more predicate
expressions. The first parameter is the test to apply. The second is a pair of properties
to set if the test evaluates to true or false.

The test parameter has access to the axis properties `value` and `label` corresponding
to the value associated with an individual axis element and its text label. These
should be used rather than the underlying data field when referencing a data value.
For example,

     pAxis
        [ axDataCondition (expr "datum.value <= 2")
            (cAxTickColor "red" "blue")
        , axDataCondition (expr "datum.label =='4.0'")
            (cAxTickWidth 5 2)
        ]

You can also apply inline aggregation before applying the test using
[fiOpTrans](#fiOpTrans), which can be particularly useful for filtering temporal
data. For example the following will apply solid grid lines for January 1st of
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


{-| Deprecated since short time labels are used by default since VL4
-}
axcoShortTimeLabels : Bool -> AxisConfig
axcoShortTimeLabels =
    ShortTimeLabels


{-| Default axis tick mark color.
-}
axcoTickColor : String -> AxisConfig
axcoTickColor =
    TickColor


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


{-| Deprecated in favour of [axcoTickMinStep](#axcoTickMinStep).
-}
axcoTickStep : Float -> AxisConfig
axcoTickStep =
    TickMinStep


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


{-| Deprecated in favour of [axValues](#axValues).
-}
axDates : List (List DateTime) -> AxisProperty
axDates =
    AxDates


{-| Whether or not an axis baseline (domain) should be included as part of an axis.
-}
axDomain : Bool -> AxisProperty
axDomain =
    AxDomain


{-| Color of axis domain line.
-}
axDomainColor : String -> AxisProperty
axDomainColor =
    AxDomainColor


{-| Opacity of axis domain line.
-}
axDomainOpacity : Float -> AxisProperty
axDomainOpacity =
    AxDomainOpacity


{-| Width of axis domain line.
-}
axDomainWidth : Float -> AxisProperty
axDomainWidth =
    AxDomainWidth


{-| [Formatting pattern](https://vega.github.io/vega-lite/docs/format.html) for
axis labels. To distinguish between formatting as numeric values and data/time values,
additionally use [axFormatAsNum](#axFormatAsNum) or [axFormatAsTemporal](#axFormatAsTemporal).
-}
axFormat : String -> AxisProperty
axFormat =
    AxFormat


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


{-| Whether or not grid lines should be included as part of an axis.
-}
axGrid : Bool -> AxisProperty
axGrid =
    AxGrid


{-| Color of grid lines associated with an axis.
-}
axGridColor : String -> AxisProperty
axGridColor =
    AxGridColor


{-| Axis grid line dash style. The parameter is a list of alternating 'on' and
'off' lengths in pixels representing the dashed line.
-}
axGridDash : List Float -> AxisProperty
axGridDash =
    AxGridDash


{-| Opacity of grid lines associated with an axis.
-}
axGridOpacity : Float -> AxisProperty
axGridOpacity =
    AxGridOpacity


{-| Width of grid lines associated with an axis.
-}
axGridWidth : Float -> AxisProperty
axGridWidth =
    AxGridWidth


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
axLabelBound =
    AxLabelBound


{-| Color of axis tick label.
-}
axLabelColor : String -> AxisProperty
axLabelColor =
    AxLabelColor


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
axLabelExpr =
    AxLabelExpr


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
axLabelFlushOffset =
    AxLabelFlushOffset


{-| Font name of an axis label.
-}
axLabelFont : String -> AxisProperty
axLabelFont =
    AxLabelFont


{-| Font size of an axis label.
-}
axLabelFontSize : Float -> AxisProperty
axLabelFontSize =
    AxLabelFontSize


{-| Font style of an axis label (e.g. "italic")
-}
axLabelFontStyle : String -> AxisProperty
axLabelFontStyle =
    AxLabelFontStyle


{-| Font weight of an axis label.
-}
axLabelFontWeight : FontWeight -> AxisProperty
axLabelFontWeight =
    AxLabelFontWeight


{-| Maximum length in pixels of axis tick labels.
-}
axLabelLimit : Float -> AxisProperty
axLabelLimit =
    AxLabelLimit


{-| Opacity of an axis label.
-}
axLabelOpacity : Float -> AxisProperty
axLabelOpacity =
    AxLabelOpacity


{-| Color of axis ticks.
-}
axTickColor : String -> AxisProperty
axTickColor =
    AxTickColor


{-| Whether or not an extra axis tick should be added for the initial position
of an axis.
-}
axTickExtra : Bool -> AxisProperty
axTickExtra =
    AxTickExtra


{-| The minimum desired step between axis ticks, in terms of scale domain values.
For example, a value of `1` indicates that ticks should not be less than 1 unit
apart. If specified, the tick count value will be adjusted, if necessary, to
enforce the minimum step value.
-}
axTickMinStep : Float -> AxisProperty
axTickMinStep =
    AxTickMinStep


{-| Offset in pixels of an axis's ticks, labels and gridlines.
-}
axTickOffset : Float -> AxisProperty
axTickOffset =
    AxTickOffset


{-| Opacity of axis ticks.
-}
axTickOpacity : Float -> AxisProperty
axTickOpacity =
    AxTickOpacity


{-| Whether or not axis tick positions should be rounded to nearest integer.
-}
axTickRound : Bool -> AxisProperty
axTickRound =
    AxTickRound


{-| Deprecated in favour of [axTickMinStep](#axTickMinStep).
-}
axTickStep : Float -> AxisProperty
axTickStep =
    AxTickMinStep


{-| Width of axis ticks.
-}
axTickWidth : Float -> AxisProperty
axTickWidth =
    AxTickWidth


{-| Vertical alignment of axis title.
-}
axTitleBaseline : VAlign -> AxisProperty
axTitleBaseline =
    AxTitleBaseline


{-| Color of axis title.
-}
axTitleColor : String -> AxisProperty
axTitleColor =
    AxTitleColor


{-| Font name for an axis title.
-}
axTitleFont : String -> AxisProperty
axTitleFont =
    AxTitleFont


{-| Font size of an axis title.
-}
axTitleFontSize : Float -> AxisProperty
axTitleFontSize =
    AxTitleFontSize


{-| Font style of an axis title (e.g. "italic").
-}
axTitleFontStyle : String -> AxisProperty
axTitleFontStyle =
    AxTitleFontStyle


{-| Font weight of an axis title.
-}
axTitleFontWeight : FontWeight -> AxisProperty
axTitleFontWeight =
    AxTitleFontWeight


{-| Maximum length in pixels of axis title.
-}
axTitleLimit : Float -> AxisProperty
axTitleLimit =
    AxTitleLimit


{-| Opacity of an axis title.
-}
axTitleOpacity : Float -> AxisProperty
axTitleOpacity =
    AxTitleOpacity


{-| X position of an axis title relative to the axis group.
-}
axTitleX : Float -> AxisProperty
axTitleX =
    AxTitleX


{-| Y position of an axis title relative to the axis group.
-}
axTitleY : Float -> AxisProperty
axTitleY =
    AxTitleY


{-| Rotation angle of axis labels (degrees from horizontal).
-}
axLabelAngle : Float -> AxisProperty
axLabelAngle =
    AxLabelAngle << positiveAngle


{-| Overlap strategy for labels when they are too large to fit within the space
devoted to an axis.
-}
axLabelOverlap : OverlapStrategy -> AxisProperty
axLabelOverlap =
    AxLabelOverlap


{-| Padding in pixels between an axis and its text labels.
-}
axLabelPadding : Float -> AxisProperty
axLabelPadding =
    AxLabelPadding


{-| The minimum separation between labels (in pixel units) before they are considered
non-overlapping. Ignored if [axLabelOverlap](#axLabelOverlap) is [osNone](#osNone).
-}
axLabelSeparation : Float -> AxisProperty
axLabelSeparation =
    AxLabelSeparation


{-| Whether or not axis labels should be displayed.
-}
axLabels : Bool -> AxisProperty
axLabels =
    AxLabels


{-| Maximum extent in pixels that axis ticks and labels should use.
-}
axMaxExtent : Float -> AxisProperty
axMaxExtent =
    AxMaxExtent


{-| Minimum extent in pixels that axis ticks and labels should use.
-}
axMinExtent : Float -> AxisProperty
axMinExtent =
    AxMinExtent


{-| Offset to displace the axis from the edge of the enclosing group or data rectangle.
-}
axOffset : Float -> AxisProperty
axOffset =
    AxOffset


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
axPosition =
    AxPosition


{-| Whether or not an axis should include tick marks.
-}
axTicks : Bool -> AxisProperty
axTicks =
    AxTicks


{-| Desired number of ticks for axes visualizing quantitative scales.
The resulting number may be different so that values are “nice” (multiples of 2, 5, 10).
-}
axTickCount : Int -> AxisProperty
axTickCount =
    AxTickCount


{-| Tick mark size in pixels.
-}
axTickSize : Float -> AxisProperty
axTickSize =
    AxTickSize


{-| Title to display as part of an axis. An empty string can be used to prevent
a title being displayed. Multi-line titles can be specified by adding a `\n` at
line breaks.
-}
axTitle : String -> AxisProperty
axTitle =
    AxTitle


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
axTitleAngle =
    AxTitleAngle << positiveAngle


{-| Padding in pixels between a title and axis.
-}
axTitlePadding : Float -> AxisProperty
axTitlePadding =
    AxTitlePadding


{-| Set explicit tick/grid/label values along an axis. For example, for a
quantitative field:

    pAxis [ axValues (nums [ 2, 3, 5, 7, 11, 13, 17 ]) ]

Or a categorical field:

    pAxis [ axValues (strs [ "cats", "dogs", "parrots" ]) ]

Or for a temporal field:

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


{-| Drawing order of the axis and its associated features (grid lines, ticks etc.)
relative to the other chart elements. A value greater than 0 indicates axis is
drawn in front of chart marks, 0 indicates it is drawn behind them. The z-order
of intersecting grid lines associated with x- and y- axes can be controlled by
assigning a higher z-value to the axis to appear on top.
-}
axZIndex : Int -> AxisProperty
axZIndex =
    AxZIndex


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


{-| Desired range of bin values when binning a collection of values.
The first and second parameters indicate the minimum and maximum range values.
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
encodings. The first parameter is a list of customisation optiona ([biBase](#biBase),
[biDivide](#biDivide) etc.) or an empty list to use the default binning. Sthe second
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
parameter should be the name of an interval selection that defines the extent.

For example,

    sel =
        selection
            << select "brush" seInterval [ seEncodings [ chX ] ]

    enc =
        encoding
            << position X
                [ pName "temperature"
                , pBin [ biSelectionExtent "brush" ]
                , pQuant
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


{-| The channel shown to be made interactive in an interactive legend binding.
`seBindLegend` should specify either this channel or a data field with [blField](#blField).
-}
blChannel : Channel -> BindLegendProperty
blChannel =
    BLChannel


{-| A [Vega event stream](https://vega.github.io/vega/docs/event-streams) that triggers
an interactive legend selection. If not specified, the selection is triggered with
a single click.
-}
blEvent : String -> BindLegendProperty
blEvent =
    BLEvent


{-| The data field shown to be made interactive in an interactive legend binding.
`seBindLegend` should specify either this field or a channel with [blChannel](#blChannel).
-}
blField : String -> BindLegendProperty
blField =
    BLField


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
([imKeyVals](#imKeyVals)) and customized sorting ([soCustom](#soCustom)).
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
are shown, but ticks and outliers can be specified explicitly. For example,

    boxplot
        [ maTicks [ maColor "black", maSize 8 ]
        , maBox [ maFill "grey" ]
        , maOutliers [ maColor "firebrick" ]
        ]

-}
boxplot : List MarkProperty -> ( VLProperty, Spec )
boxplot =
    mark Boxplot


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
    [ SDomain (DStrings domain), SRange (RStrings range) ]


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


{-| Opacity channel to be used in a resolution specification
-}
chOpacity : Channel
chOpacity =
    ChOpacity


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


{-| Configure the default appearance of area marks.
-}
coArea : List MarkProperty -> ConfigurationProperty
coArea =
    AreaStyle


{-| Configure the default sizing of visualizations.
-}
coAutosize : List Autosize -> ConfigurationProperty
coAutosize =
    Autosize


{-| Configure the default appearance of axes.
-}
coAxis : List AxisConfig -> ConfigurationProperty
coAxis =
    Axis


{-| Configure the default appearance of x-axes.
-}
coAxisX : List AxisConfig -> ConfigurationProperty
coAxisX =
    AxisX


{-| Configure the default appearance of y-axes.
-}
coAxisY : List AxisConfig -> ConfigurationProperty
coAxisY =
    AxisY


{-| Configure the default appearance of left-side axes.
-}
coAxisLeft : List AxisConfig -> ConfigurationProperty
coAxisLeft =
    AxisLeft


{-| Configure the default appearance of right-side axes.
-}
coAxisRight : List AxisConfig -> ConfigurationProperty
coAxisRight =
    AxisRight


{-| Configure the default appearance of top-side axes.
-}
coAxisTop : List AxisConfig -> ConfigurationProperty
coAxisTop =
    AxisTop


{-| Configure the default appearance of bottom-side axes.
-}
coAxisBottom : List AxisConfig -> ConfigurationProperty
coAxisBottom =
    AxisBottom


{-| Configure the default appearance of axes with band scaling.
-}
coAxisBand : List AxisConfig -> ConfigurationProperty
coAxisBand =
    AxisBand


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


{-| Combines a list of labelled specifications that may be passed to JavaScript
for rendering. Useful when you wish to create a single page with multiple
visualizations.

    combineSpecs
        [ ( "vis1", myFirstVis )
        , ( "vis2", mySecondVis )
        , ( "vis3", myOtherVis )
        ]

-}
combineSpecs : List LabelledSpec -> Spec
combineSpecs specs =
    JE.object specs


{-| Configure the default appearance of a single named style.
-}
coNamedStyle : String -> List MarkProperty -> ConfigurationProperty
coNamedStyle =
    NamedStyle


{-| Configure the default appearance of a list of named styles.
-}
coNamedStyles : List ( String, List MarkProperty ) -> ConfigurationProperty
coNamedStyles =
    NamedStyles


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
                << configuration (coSelection [ ( seSingle, [ seOn "dblclick" ] ) ])
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


{-| Deprecated as stack offset is not supported since Vega-Lite 4.
-}
coStack : StackOffset -> ConfigurationProperty
coStack =
    Stack


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
    CNESWResize


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


{-| Compute some aggregate summary statistics for a field to be encoded with a
level of detail (grouping) channel. The type of aggregation is determined by the
given operation parameter.
-}
dAggregate : Operation -> DetailChannel
dAggregate =
    DAggregate


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
    let
        dataArray =
            cols |> transpose |> JE.list JE.object
    in
    if fmts == [] then
        ( VLData, JE.object [ ( "values", dataArray ) ] )

    else
        ( VLData
        , JE.object
            [ ( "values", dataArray )
            , ( "format", JE.object (List.concatMap formatProperties fmts) )
            ]
        )


{-| Declare a data source from a json specification. The most likely use-case is
creating [geojson](http://geojson.org) objects with [`geometry`](#geometry),
[`geometryCollection`](#geometryCollection) and [`geoFeatureCollection`](#geoFeatureCollection).
For example,

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
objects, consider using with Elm's
[`Json.Encode`](http://package.elm-lang.org/packages/elm-lang/core/5.1.1/Json-Encode).
For example,

    row title ranges =
        Json.Encode.object
            [ ( "title", Json.Encode.string title )
            , ( "ranges", Json.Encode.list Json.Encode.float ranges )
            ]

    data =
        dataFromJson
            (Json.Encode.list identity
                [ row "Revenue" [ 150, 225, 300 ]
                , row "Profit" [ 20, 25, 30 ]
                , row "Order size" [ 350, 500, 600 ]
                , row "New customers" [ 1400, 2000, 2500 ]
                , row "Satisfaction" [ 3.5, 4.25, 5 ]
                ]
            )

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
    if fmts == [] then
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


{-| Day of the week time unit used for discretizing temporal data.
-}
day : TimeUnit
day =
    Day


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


{-| The bandwidth (standard deviation) of the Gaussian kernal used in KDE estimation.
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
dnExtent : DataValue -> DataValue -> DensityProperty
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
`dMType Nominal`.
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
    [ SDomain (DNumbers domain), SRange (RStrings range) ]


{-| Numeric values that define a scale domain.
-}
doNums : List Float -> ScaleDomain
doNums =
    DNumbers


{-| Indicate a data field encoded with a detail channel is ordinal. Equivalent to
`dMType Ordinal`.
-}
dOrdinal : DetailChannel
dOrdinal =
    DmType Ordinal


{-| Scale domain based on a named interactive selection.
-}
doSelection : String -> ScaleDomain
doSelection =
    DSelection


{-| String values that define a scale domain.
-}
doStrs : List String -> ScaleDomain
doStrs =
    DStrings


{-| Specify an unaggregated scale domain (type of data in scale).
-}
doUnaggregated : ScaleDomain
doUnaggregated =
    Unaggregated


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
dtRange =
    DateRange


{-| List of date-time data values. Used when declaring inline data with
[dataColumn](#dataColumn), filtering ([fiOneOf](#fiOneOf)), imputation
([imKeyVals](#imKeyVals)) and customized sorting ([soCustom](#soCustom)).
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
or mark properties to customise. For example,

    errorband [ maBorders [ maColor "black", maStrokeWidth 0.5 ] ]

-}
errorband : List MarkProperty -> ( VLProperty, Spec )
errorband =
    mark Errorband


{-| [Errorbar composite mark](https://vega.github.io/vega-lite/docs/errorbar.html)
for showing summaries of variation along a signal. By default no ticks are drawn.
To add ticks with use [maTicks](#maTicks) with an empty list for default appearance,
or with a list of mark properties to customise. For example,

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
over 65,

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
complex Boolean composition. For example,

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
a Boolean operation. This can be useful when working with dates. For example the
following will aggregate a set of dates into years and filter only those years
between 2010 and 2017 inclusive. Note the use of [fiCompose](#fiCompose) to
convert the Boolean operation back into a [Filter](#Filter).

    filter
        (fiRange "date" (dtRange [ dtYear 2010 ] [ dtYear 2017 ])
            |> fiOpTrans (mTimeUnit year)
            |> fiCompose
        )

-}
fiOpTrans : MarkChannel -> Filter -> BooleanOp
fiOpTrans =
    FilterOpTrans


{-| Filter a data stream so that only data in a given field that are within the
given range are used. For example,

    filter (fiRange "date" (dtRange [ dtYear 2006 ] [ dtYear 2016 ]))

-}
fiRange : String -> FilterRange -> Filter
fiRange =
    FRange


{-| Filter a data stream so that only data in a given field that are within the
given interactive selection are used. For example,

    sel =
        selection
            << select "myBrush" seInterval [ seEncodings [ chX ] ]

    trans =
        transform
            << filter (fiSelection "myBrush")

-}
fiSelection : String -> Filter
fiSelection =
    FSelection


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
`fMType Nominal`.
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


{-| Indicates a linear color gradient. See the
[Vega-Lite color gradient documentation](https://vega.github.io/vega-lite/docs/types.html#linear-gradient).
-}
grLinear : ColorGradient
grLinear =
    GrLinear


{-| The radius, normalized to [0, 1], of the inner circle for a radial color gradient.
Default is 0.
-}
grR1 : Float -> GradientProperty
grR1 =
    GrR1


{-| The radius, normalized to [0, 1], of the outer circle for a radial color gradient.
Default is 0.5.
-}
grR2 : Float -> GradientProperty
grR2 =
    GrR2


{-| Indicates a radial color gradient. See the
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


{-| The x-coordinate, normalized to [0, 1], for the start of a color gradient. If
the gradient is linear the default is 0; if radial, it is the x-position of the
centre of the inner circle with a default of 0.5.
-}
grX1 : Float -> GradientProperty
grX1 =
    GrX1


{-| The x-coordinate, normalized to [0, 1], for the end of a color gradient. If
the gradient is linear the default is 1; if radial, it is the x-position of the
centre of the outer circle with a default of 0.5.
-}
grX2 : Float -> GradientProperty
grX2 =
    GrX2


{-| The y-coordinate, normalized to [0, 1], for the start of a color gradient. If
the gradient is linear the default is 0; if radial, it is the y-position of the
centre of the inner circle with a default of 0.5.
-}
grY1 : Float -> GradientProperty
grY1 =
    GrY1


{-| The y-coordinate, normalized to [0, 1], for the end of a color gradient. If
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
    AlignCenter


{-| Compute some aggregate summary statistics for a field to be encoded with a
hyperlink channel. The type of aggregation is determined by the given operation
parameter.
-}
hAggregate : Operation -> HyperlinkChannel
hAggregate =
    HAggregate


{-| Left horizontal text alignment.
-}
haLeft : HAlign
haLeft =
    AlignLeft


{-| Right horizontal text alignment.
-}
haRight : HAlign
haRight =
    AlignRight


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


{-| Make a hyperlink channel conditional on some predicate expression. The first
parameter provides the expression to evaluate, the second the encoding to apply
if the expression is true, the third the encoding if the expression is false.
-}
hDataCondition : BooleanOp -> List HyperlinkChannel -> List HyperlinkChannel -> HyperlinkChannel
hDataCondition op tCh fCh =
    HDataCondition op tCh fCh


{-| [Formatting pattern](https://vega.github.io/vega-lite/docs/format.html) for
facet header (title) values. To distinguish between formatting as numeric values
and data/time values, additionally use [hdFormatAsNum](#hdFormatAsNum) or
[hdFormatAsTemporal](#hdFormatAsTemporal).
-}
hdFormat : String -> HeaderProperty
hdFormat =
    HFormat


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


{-| Header label rotation angle (in degrees from horizontal) for a faceted view.
A 'label' is the title for each sub-plot in a faceted view.
-}
hdLabelAngle : Float -> HeaderProperty
hdLabelAngle =
    HLabelAngle << positiveAngle


{-| Header label text color for a faceted view.
-}
hdLabelColor : String -> HeaderProperty
hdLabelColor =
    HLabelColor


{-| Header label font for a faceted view.
-}
hdLabelFont : String -> HeaderProperty
hdLabelFont =
    HLabelFont


{-| Header label font size for a faceted view.
-}
hdLabelFontSize : Float -> HeaderProperty
hdLabelFontSize =
    HLabelFontSize


{-| Maximum length of a header label in a faceted view.
-}
hdLabelLimit : Float -> HeaderProperty
hdLabelLimit =
    HLabelLimit


{-| The position of a header label relative to a sub-plot. A 'label' is the title
for each sub-plot in a faceted view.
-}
hdLabelOrient : Side -> HeaderProperty
hdLabelOrient =
    HLabelOrient


{-| Spacing in pixels between facet labels and the main plot area.
-}
hdLabelPadding : Float -> HeaderProperty
hdLabelPadding =
    HLabelPadding


{-| Header title in a faceted view. A 'title' is the overall title describing the
collection of faceted plots. Multi-line titles can be specified by adding a `\n`
at line breaks.
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
hdTitleAngle =
    HTitleAngle << positiveAngle


{-| Vertical alignment of a header title in a faceted view.
-}
hdTitleBaseline : VAlign -> HeaderProperty
hdTitleBaseline =
    HTitleBaseline


{-| Text color of a header title in a faceted view.
-}
hdTitleColor : String -> HeaderProperty
hdTitleColor =
    HTitleColor


{-| Title font in a faceted view.
-}
hdTitleFont : String -> HeaderProperty
hdTitleFont =
    HTitleFont


{-| Title font size in a faceted view.
-}
hdTitleFontSize : Float -> HeaderProperty
hdTitleFontSize =
    HTitleFontSize


{-| Title font weight in a faceted view.
-}
hdTitleFontWeight : String -> HeaderProperty
hdTitleFontWeight =
    HTitleFontWeight


{-| Maximum length of a header title in a faceted view.
-}
hdTitleLimit : Float -> HeaderProperty
hdTitleLimit =
    HTitleLimit


{-| The position of a header title relative to a group of sub-plots in a faceted
view.
-}
hdTitleOrient : Side -> HeaderProperty
hdTitleOrient =
    HTitleOrient


{-| Spacing in pixels between the main facet title and labels.
-}
hdTitlePadding : Float -> HeaderProperty
hdTitlePadding =
    HTitlePadding


{-| Override the default height of the visualization. If not specified the height
will be calculated based on the content of the visualization. How the content is
sized relative to this height specification can be customised with [autosize])(#autosize).
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
Equivalent to `hMType Nominal`.
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


{-| Make a hyperlink channel conditional on interactive selection. The first parameter
provides the selection to evaluate, the second the encoding to apply if the hyperlink
has been selected, the third the encoding if it is not selected.
-}
hSelectionCondition : BooleanOp -> List HyperlinkChannel -> List HyperlinkChannel -> HyperlinkChannel
hSelectionCondition op tCh fCh =
    HSelectionCondition op tCh fCh


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


{-| Checkbox input element that can bound to a named field value.
-}
iCheckbox : String -> List InputProperty -> Binding
iCheckbox f =
    ICheckbox f


{-| Color input element that can bound to a named field value.
-}
iColor : String -> List InputProperty -> Binding
iColor f =
    IColor f


{-| Date input element that can bound to a named field value.
-}
iDate : String -> List InputProperty -> Binding
iDate f =
    IDate f


{-| Local time input element that can bound to a named field value.
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


{-| Month input element that can bound to a named field value.
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


{-| Options for a radio or select input element.
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


{-| Number input element that can bound to a named field value.
-}
iNumber : String -> List InputProperty -> Binding
iNumber f =
    INumber f


{-| Radio box input element that can bound to a named field value.
-}
iRadio : String -> List InputProperty -> Binding
iRadio f =
    IRadio f


{-| Range slider input element that can bound to a named field value.
-}
iRange : String -> List InputProperty -> Binding
iRange f =
    IRange f


{-| Select input element that can bound to a named field value.
-}
iSelect : String -> List InputProperty -> Binding
iSelect f =
    ISelect f


{-| Telephone number input element that can bound to a named field value.
-}
iTel : String -> List InputProperty -> Binding
iTel f =
    ITel f


{-| Text input element that can bound to a named field value.
-}
iText : String -> List InputProperty -> Binding
iText f =
    IText f


{-| Time input element that can bound to a named field value.
-}
iTime : String -> List InputProperty -> Binding
iTime f =
    ITime f


{-| Week input element that can bound to a named field value.
-}
iWeek : String -> List InputProperty -> Binding
iWeek f =
    IWeek f


{-| Bevelled stroke join.
-}
joBevel : StrokeJoin
joBevel =
    JBevel


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


{-| Encode an key channel for use with the [Vega View API](https://vega.github.io/vega/docs/api/view/#data).
The first parameter is the name of the data field to use as a unique key for data
binding.

    enc =
        encoding
            << key "myFieldName"

-}
key : String -> List LabelledSpec -> List LabelledSpec
key f =
    (::) ( "key", JE.string f )


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


{-| Limit height of legend entries.
-}
leClipHeight : Float -> LegendProperty
leClipHeight =
    LClipHeight


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


{-| Default font size legend labels.
-}
lecoLabelFontSize : Float -> LegendConfig
lecoLabelFontSize =
    LeLabelFontSize


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


{-| Whether or not time labels are abbreviated by default in a legend.
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


{-| Default legend symbol fill color.
-}
lecoSymbolFillColor : String -> LegendConfig
lecoSymbolFillColor =
    SymbolFillColor


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


{-| Default spacing in pixel units between title and legend.
-}
lecoTitlePadding : Float -> LegendConfig
lecoTitlePadding =
    LeTitlePadding


{-| Legend corner radius.
-}
leCornerRadius : Float -> LegendProperty
leCornerRadius =
    LCornerRadius


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
leColumnPadding =
    LColumnPadding


{-| Number of columns in which to arrange symbol legend entries.
-}
leColumns : Float -> LegendProperty
leColumns =
    LColumns


{-| Direction of a legend.
-}
leDirection : MarkOrientation -> LegendProperty
leDirection =
    LDirection


{-| An explicit set of legend date-times.
-}
leDts : List (List DateTime) -> LegendValues
leDts =
    LDateTimes


{-| Legend background color.
-}
leFillColor : String -> LegendProperty
leFillColor =
    LFillColor


{-| [Formatting pattern](https://vega.github.io/vega-lite/docs/format.html) for
legend values. To distinguish between formatting as numeric values and data/time values,
additionally use [leFormatAsNum](#leFormatAsNum) or [leFormatAsTemporal](#leFormatAsTemporal).
-}
leFormat : String -> LegendProperty
leFormat =
    LFormat


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


{-| A gradient legend for continuous quantitative data.
-}
leGradient : Legend
leGradient =
    Gradient


{-| Length in pixels of the primary axis of a color ramp legend.
-}
leGradientLength : Float -> LegendProperty
leGradientLength =
    LGradientLength


{-| Color for strokes in a color ramp legend.
-}
leGradientStrokeColor : String -> LegendProperty
leGradientStrokeColor =
    LGradientStrokeColor


{-| Width for strokes in a color ramp legend.
-}
leGradientStrokeWidth : Float -> LegendProperty
leGradientStrokeWidth =
    LGradientStrokeWidth


{-| Thickness in pixels of a color ramp legend.
-}
leGradientThickness : Float -> LegendProperty
leGradientThickness =
    LGradientThickness


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
leLabelColor =
    LLabelColor


{-| Font for legend labels.
-}
leLabelFont : String -> LegendProperty
leLabelFont =
    LLabelFont


{-| Font size legend labels.
-}
leLabelFontSize : Float -> LegendProperty
leLabelFontSize =
    LLabelFontSize


{-| Maximum width for legend labels in pixel units.
-}
leLabelLimit : Float -> LegendProperty
leLabelLimit =
    LLabelLimit


{-| Offset for legend labels.
-}
leLabelOffset : Float -> LegendProperty
leLabelOffset =
    LLabelOffset


{-| Strategy for resolving overlapping legend labels.
-}
leLabelOverlap : OverlapStrategy -> LegendProperty
leLabelOverlap =
    LLabelOverlap


{-| An explicit set of numeric legend values.
-}
leNums : List Float -> LegendValues
leNums =
    LNumbers


{-| Offset in pixels of a legend from the encoded marks it describes. If the legend
orientation is one of `loTop`, `loBottom`, `loLeft` or `loRight`, a positive offset
moves the legend outwards away from the encoded marks. If it is one of `loTopLeft`,
`loTopRight`, `loBottomLeft` or `loBottomRight` a positive offset will move it
inwards away from the corner. If `loNone`, the offset has no effect.
-}
leOffset : Float -> LegendProperty
leOffset =
    LOffset


{-| Position of a legend in a scene.
-}
leOrient : LegendOrientation -> LegendProperty
leOrient =
    LOrient


{-| Padding in pixels between a legend and axis.
-}
lePadding : Float -> LegendProperty
lePadding =
    LPadding


{-| Vertical spacing in pixel units between a symbol legend entries.
-}
leRowPadding : Float -> LegendProperty
leRowPadding =
    LRowPadding


{-| Legend border color.
-}
leStrokeColor : String -> LegendProperty
leStrokeColor =
    LStrokeColor


{-| Legend border stroke width.
-}
leStrokeWidth : Float -> LegendProperty
leStrokeWidth =
    LStrokeWidth


{-| An explicit set of legend strings.
-}
leStrs : List String -> LegendValues
leStrs =
    LStrings


{-| A symbol legend for categorical data.
-}
leSymbol : Legend
leSymbol =
    Symbol


{-| Legend symbol fill color.
-}
leSymbolFillColor : String -> LegendProperty
leSymbolFillColor =
    LSymbolFillColor


{-| Legend symbol type.
-}
leSymbolType : Symbol -> LegendProperty
leSymbolType =
    LSymbolType


{-| Legend symbol size.
-}
leSymbolSize : Float -> LegendProperty
leSymbolSize =
    LSymbolSize


{-| Legend symbol stroke width.
-}
leSymbolStrokeWidth : Float -> LegendProperty
leSymbolStrokeWidth =
    LSymbolStrokeWidth


{-| Legend symbol outline color.
-}
leSymbolStrokeColor : String -> LegendProperty
leSymbolStrokeColor =
    LSymbolStrokeColor


{-| Number of tick marks in a quantitative legend.
-}
leTickCount : Float -> LegendProperty
leTickCount =
    LTickCount


{-| Title of a legend. Multi-line titles can be specified by adding a `\n` at
line breaks.
-}
leTitle : String -> LegendProperty
leTitle =
    LTitle


{-| Horizontal alignment for legend titles.
-}
leTitleAlign : HAlign -> LegendProperty
leTitleAlign =
    LTitleAlign


{-| Vertical alignment for legend titles.
-}
leTitleBaseline : VAlign -> LegendProperty
leTitleBaseline =
    LTitleBaseline


{-| Color for legend title.
-}
leTitleColor : String -> LegendProperty
leTitleColor =
    LTitleColor


{-| Font for legend titles.
-}
leTitleFont : String -> LegendProperty
leTitleFont =
    LTitleFont


{-| Font size for legend titles.
-}
leTitleFontSize : Float -> LegendProperty
leTitleFontSize =
    LTitleFontSize


{-| Font weight for legend titles.
-}
leTitleFontWeight : FontWeight -> LegendProperty
leTitleFontWeight =
    LTitleFontWeight


{-| Maximum size in pixel units for legend titles.
-}
leTitleLimit : Float -> LegendProperty
leTitleLimit =
    LTitleLimit


{-| Spacing in pixel units between title and legend.
-}
leTitlePadding : Float -> LegendProperty
leTitlePadding =
    LTitlePadding


{-| Type of legend.
-}
leType : Legend -> LegendProperty
leType =
    LType


{-| An explicit set of legend values.
-}
leValues : LegendValues -> LegendProperty
leValues =
    LValues


{-| x-position of legend group in pixel units for absolute positioning when
[leOrient](#leOrient) is set to `loNone`.
-}
leX : Float -> LegendProperty
leX =
    LeX


{-| y-position of legend group in pixel units for absolute positioning when
[leOrient](#leOrient) is set to `loNone`.
-}
leY : Float -> LegendProperty
leY =
    LeY


{-| Drawing order of a legend relative to other chart elements. To
place a legend in front of others use a positive integer, or 0 to draw behind.
-}
leZIndex : Int -> LegendProperty
leZIndex =
    LZIndex


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


{-| Indicates no line marker on an area mark.
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
                (censuData [])
                "borough"
                (luFields [ "carOwnership", "numBedrooms" ])

-}
lookup : String -> Data -> String -> LookupFields -> List LabelledSpec -> List LabelledSpec
lookup key1 ( vlProp, spec ) key2 lufs =
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


{-| Deprecated in favour of [lookup](#lookup). For example,

    lookupAs "key1" secondaryData "key2" "matchedName"

should be replaced with

    lookup "key1" secondaryData "key2" (luAs "matchedName")

-}
lookupAs : String -> Data -> String -> String -> List LabelledSpec -> List LabelledSpec
lookupAs key1 sData key2 luAlias =
    lookup key1 sData key2 (luAs luAlias)


{-| Attach the results of an interactive selection to a primary data source.
The first three parameters are the field in the primary data source to look up;
the name of the interactive selection; and the name of the field in the selection
to link with the primary data field. This is similar to [lookup](#lookup) except
that the data in a selection are used in place of the secondary data source.

For example:

      sel =
          selection
              << select "mySel" seSingle [ seOn "mouseover", seEncodings [ chX ] ]

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
                    [ ( "selection", JE.string selName )
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
a [lookup](#lookup). To refer to individual fields via this name, use dot notiation.
For example,

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
maAngle =
    MAngle << positiveAngle


{-| Whether or not the aspect ratio of an image mark should be preserved.
-}
maAspect : Bool -> MarkProperty
maAspect =
    MAspect


{-| Band size of a bar mark.
-}
maBandSize : Float -> MarkProperty
maBandSize =
    MBandSize


{-| Vertical alignment of a text mark.
-}
maBaseline : VAlign -> MarkProperty
maBaseline =
    MBaseline


{-| Offset between bars for a binned field using a bar mark.
-}
maBinSpacing : Float -> MarkProperty
maBinSpacing =
    MBinSpacing


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
maClip =
    MClip


{-| Default color of a mark. Note that `maFill` and `maStroke` have higher
precedence and will override this if specified. Color strings can use any valid
HTML color specification. For example,

    maColor "#eee"

    maColor "#734FD8"

    maColor "crimson"

    maColor "rgb(255,204,210)"

    maColor "hsl(180, 50%, 50%)"

-}
maColor : String -> MarkProperty
maColor =
    MColor


{-| A color gradient to apply to a mark. The first parameter indicates whether the
gradient should be linear or radial. The second is a set of customisation options
for the colors, positioning and rate of change of the gradient. For example,
to set a radial red-blue color gradient for a mark:

    maColorGradient grRadial [ grStops [ ( 0, "red" ), ( 1, "blue" ) ] ]

-}
maColorGradient : ColorGradient -> List GradientProperty -> MarkProperty
maColorGradient =
    MColorGradient


{-| The radius in pixels of all four corners of a rectangle mark. Default is 0
(square corners).
-}
maCornerRadius : Float -> MarkProperty
maCornerRadius =
    MCornerRadius


{-| The radius in pixels of the bottom-left corner of a rectangle mark. Will override
any value specified in [maCornerRadius](#maCornerRadius).
-}
maCornerRadiusBottomLeft : Float -> MarkProperty
maCornerRadiusBottomLeft =
    MCornerRadiusBL


{-| The radius in pixels of the bottom-right corner of a rectangle mark. Will override
any value specified in [maCornerRadius](#maCornerRadius).
-}
maCornerRadiusBottomRight : Float -> MarkProperty
maCornerRadiusBottomRight =
    MCornerRadiusBR


{-| The radius in pixels of the 'end' corners of a bar mark. For vertical bars
this would be the top corners and for horiztonal bars, the right corners.
-}
maCornerRadiusEnd : Float -> MarkProperty
maCornerRadiusEnd =
    MCornerRadiusEnd


{-| The radius in pixels of the top-left corner of a rectangle mark. Will override
any value specified in [maCornerRadius](#maCornerRadius).
-}
maCornerRadiusTopLeft : Float -> MarkProperty
maCornerRadiusTopLeft =
    MCornerRadiusTL


{-| The radius in pixels of the top-right corner of a rectangle mark. Will override
any value specified in [maCornerRadius](#maCornerRadius).
-}
maCornerRadiusTopRight : Float -> MarkProperty
maCornerRadiusTopRight =
    MCornerRadiusTR


{-| Cursor to be associated with a hyperlink mark.
-}
maCursor : Cursor -> MarkProperty
maCursor =
    MCursor


{-| Continuous band size of a bar mark.
-}
maContinuousBandSize : Float -> MarkProperty
maContinuousBandSize =
    MContinuousBandSize


{-| Direction of text, which determins which end is truncated in cases where text
is larger than available space.
-}
maDir : TextDirection -> MarkProperty
maDir =
    MDir


{-| Discrete band size of a bar mark.
-}
maDiscreteBandSize : Float -> MarkProperty
maDiscreteBandSize =
    MDiscreteBandSize


{-| Horizontal offset between a text mark and its anchor.
-}
maDx : Float -> MarkProperty
maDx =
    MdX


{-| Vertical offset between a text mark and its anchor.
-}
maDy : Float -> MarkProperty
maDy =
    MdY


{-| Text to indicate a truncated piece of text (default is the ellipsis ...)
-}
maEllipsis : String -> MarkProperty
maEllipsis =
    MEllipsis


{-| Extent of whiskers used in a boxplot, error bars or error bands.
-}
maExtent : SummaryExtent -> MarkProperty
maExtent =
    MExtent


{-| Default fill color of a mark. Color strings can use any valid HTML color
specification. For example,

    maFill "#eee"

    maFill "#734FD8"

    maFill "crimson"

    maFill "rgb(255,204,210)"

    maFill "hsl(180, 50%, 50%)"

An empty string (`""`) indicates that no filling should be provided (but for clearer
semantics, better to use `maFilled False`).

-}
maFill : String -> MarkProperty
maFill =
    MFill


{-| Whether or not a mark's color should be used as the fill color instead of
stroke color.
-}
maFilled : Bool -> MarkProperty
maFilled =
    MFilled


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
maFillOpacity =
    MFillOpacity


{-| Font of a text mark. Can be any font name made accessible via
a css file (or a generic font like `serif`, `monospace` etc.).
-}
maFont : String -> MarkProperty
maFont =
    MFont


{-| Font size in pixels used by a text mark.
-}
maFontSize : Float -> MarkProperty
maFontSize =
    MFontSize


{-| Font style (e.g. `italic`) used by a text mark.
-}
maFontStyle : String -> MarkProperty
maFontStyle =
    MFontStyle


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
maHeight =
    MHeight


{-| Hyperlink to be associated with a mark making it a clickable hyperlink.
-}
maHRef : String -> MarkProperty
maHRef =
    MHRef


{-| Interpolation method used by line and area marks. For example to create a
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
maLimit =
    MLimit


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
maOpacity =
    MOpacity


{-| Ordering of vertices in a line or area mark. If true (default), order is
determined by measurement type or order channel. If false, the original data order
is used.
-}
maOrder : Bool -> MarkProperty
maOrder =
    MOrder


{-| Orientation of a non-stacked bar, tick, area or line mark.
-}
maOrient : MarkOrientation -> MarkProperty
maOrient =
    MOrient


{-| Outlier symbol properties for the boxplot mark. If an empty list is provided,
no outliers will be shown.
-}
maOutliers : List MarkProperty -> MarkProperty
maOutliers =
    MOutliers


{-| Appearance of a point marker joining the vertices of a line or area mark.

    line [ maPoint (pmMarker [ maFill "black" ]) ]

-}
maPoint : PointMarker -> MarkProperty
maPoint =
    MPoint


{-| Polar coordinate radial offset of a text mark from its origin.
-}
maRadius : Float -> MarkProperty
maRadius =
    MRadius


{-| Determine whether or not invalid (`null` and `NaN`) values are considered for
encoding as marks. If `true` (default), invalid values are ignored, otherwise
they are treated as if 0.
-}
maRemoveInvalid : Bool -> MarkProperty
maRemoveInvalid =
    MRemoveInvalid


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
maShortTimeLabels =
    MShortTimeLabels


{-| Size of a mark in square units. For example to create a circle of diameter
50 pixels,

    circle [ maSize 2500 ]

-}
maSize : Float -> MarkProperty
maSize =
    MSize


{-| Default stroke color of a mark. Color strings can use any valid HTML color
specification. For example,

    maStroke "#eee"

    maStroke "#734FD8"

    maStroke "crimson"

    maStroke "rgb(255,204,210)"

    maStroke "hsl(180, 50%, 50%)"

An empty string (`""`) indicates that no stroke around a mark be drawn.

-}
maStroke : String -> MarkProperty
maStroke =
    MStroke


{-| Cap style of a mark's stroke.
-}
maStrokeCap : StrokeCap -> MarkProperty
maStrokeCap =
    MStrokeCap


{-| Stroke dash style used by a mark. Determined by an alternating 'on-off'
sequence of line lengths.
-}
maStrokeDash : List Float -> MarkProperty
maStrokeDash =
    MStrokeDash


{-| Number of pixels before the first line dash is drawn.
-}
maStrokeDashOffset : Float -> MarkProperty
maStrokeDashOffset =
    MStrokeDashOffset


{-| A color gradient to apply to a mark's bounary stroke. The first parameter indicates
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
maStrokeMiterLimit =
    MStrokeMiterLimit


{-| Stroke opacity of a mark in the range 0 to 1.
-}
maStrokeOpacity : Float -> MarkProperty
maStrokeOpacity =
    MStrokeOpacity


{-| Stroke width of a mark in pixel units.
-}
maStrokeWidth : Float -> MarkProperty
maStrokeWidth =
    MStrokeWidth


{-| Names of custom styles to apply to a mark. Each should refer to a named style
defined in a separate style configuration.
-}
maStyle : List String -> MarkProperty
maStyle =
    MStyle


{-| Interpolation tension used when interpolating line and area marks.
-}
maTension : Float -> MarkProperty
maTension =
    MTension


{-| Placeholder text for a text mark for when a text channel is not specified.
-}
maText : String -> MarkProperty
maText =
    MText


{-| Polar coordinate angle (clockwise from north in radians) of a text mark from
the origin determined by its x and y properties.
-}
maTheta : Float -> MarkProperty
maTheta =
    MTheta


{-| Thickness of a tick mark.
-}
maThickness : Float -> MarkProperty
maThickness =
    MThickness


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
maWidth =
    MWidth


{-| X position of a mark.
-}
maX : Float -> MarkProperty
maX =
    MX


{-| X2 position (secondary x value for lines and areal marks).
-}
maX2 : Float -> MarkProperty
maX2 =
    MX2


{-| X position offset for a mark.
-}
maXOffset : Float -> MarkProperty
maXOffset =
    MXOffset


{-| X2 position offset for a mark.
-}
maX2Offset : Float -> MarkProperty
maX2Offset =
    MX2Offset


{-| Y position of a mark.
-}
maY : Float -> MarkProperty
maY =
    MY


{-| Y2 position (secondary y value for lines and areal marks).
-}
maY2 : Float -> MarkProperty
maY2 =
    MY2


{-| Y position offset for a mark.
-}
maYOffset : Float -> MarkProperty
maYOffset =
    MYOffset


{-| Y2 position offset for a mark.
-}
maY2Offset : Float -> MarkProperty
maY2Offset =
    MY2Offset


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


{-| Make a mark channel conditional on one or more predicate expressions. The first
parameter is a list of tuples each pairing a test condition with the encoding if
that condition evaluates to true. The second is the encoding if none of the tests
are true.

    color
        [ mDataCondition [ ( expr "datum.myField === null", [ mStr "grey" ] ) ]
            [ mStr "black" ]
        ]

-}
mDataCondition : List ( BooleanOp, List MarkChannel ) -> List MarkChannel -> MarkChannel
mDataCondition =
    MDataCondition


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
`mMType Nominal`.
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


{-| Month of the year (1-12) time unit used for discretizing temporal data.
-}
month : TimeUnit
month =
    Month


{-| Month and day of month time unit used for discretizing temporal data.
-}
monthDate : TimeUnit
monthDate =
    MonthDate


{-| Month, day of month and hour of day time unit used for discretizing temporal data.
-}
monthDateHours : TimeUnit
monthDateHours =
    MonthDateHours


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
fields that are to be arranged in columns, in rows or a with a flow layout.
-}
mRepeat : Arrangement -> MarkChannel
mRepeat =
    MRepeat


{-| Scaling applied to a field when encoding with a mark property channel.
The scale will transform a field's value into a color, shape, size etc.
-}
mScale : List ScaleProperty -> MarkChannel
mScale =
    MScale


{-| Make a mark channel conditional on interactive selection. The first parameter
is a selection condition to evaluate; the second the encoding to apply if that selection
is true; the third parameter is the encoding if the selection is false.

    color
        [ mSelectionCondition (selectionName "myBrush")
            [ mName "myField", mOrdinal ]
            [ mStr "grey" ]
        ]

-}
mSelectionCondition : BooleanOp -> List MarkChannel -> List MarkChannel -> MarkChannel
mSelectionCondition =
    MSelectionCondition


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


{-| Title of a field when encoding with a mark property channel. Multi-line titles
can be specified by adding a `\n` at line breaks.
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
undefined. For example:

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


{-| Minimum-maximum number range to be used in data filtering.
-}
numRange : Float -> Float -> FilterRange
numRange =
    NumberRange


{-| List of numeric data values. Used when declaring inline data with
[dataColumn](#dataColumn), filtering ([fiOneOf](#fiOneOf)), imputation
([imKeyVals](#imKeyVals)) and customized sorting ([soCustom](#soCustom)).
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
should be `Just` the name of the field to maximise. For example the following would
find the production budget for the maximum US grossing film in each genre.

    encoding
        << position X
            [ pName "Production_Budget"
            , pQuant
            , pAggregate (opArgMax (Just "US_Gross"))
            ]
        << position Y [ pName "Major_Genre", pNominal ]

If supplied as part of a transform, the parameter should be `Nothing` as the field
is specified in the [aggregate](#aggregate) parameter. For example,

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
    (::) ( "order", List.map orderChannelProperty oDefs |> JE.object )


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


{-| Parsing rules when processing some data text, specified as a list of tuples
in the form (_fieldname_, _datatype_). Useful when automatic type inference needs
to be overridden, for example when converting integers representing years into dates
and strings into numbers:

    data =
        dataFromUrl "myDataFile.csv"
            [ parse [ ( "year", foDate "%Y" ), ( "y", foNum ) ] ]

-}
parse : List ( String, DataType ) -> Format
parse =
    Parse


{-| Indicate uniform padding around a visualization in pixel units.
-}
paSize : Float -> Padding
paSize =
    PSize


{-| Axis properties used when encoding with a position channel. For no axis,
provide an empty list.
-}
pAxis : List AxisProperty -> PositionChannel
pAxis =
    PAxis


{-| Specify mark position or size relative to band size. For non-rect marks,
the relative position on a band of a stacked, binned, time unit or band scale is
used. A value of 0, posituions the mark at the beginning of the band; 0.5, in the
middle etc.

For rect-based marks (rect, bar, and image), if set to 1, the mark size is set
to the band width or the time unit interval. If set to 0.5, the mark size is half
of the bandwidth or the time unit interval. etc.

-}
pBand : Float -> PositionChannel
pBand =
    PBand


{-| Discretize numeric values into bins when encoding with a position channel.
For non-default binning, bin-widths, extent etc. can be specified in the first
parameter. For example, to encode a frequency histogram with bins every 5 units,

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
`pMType Nominal`.
-}
pNominal : PositionChannel
pNominal =
    PmType Nominal


{-| Set a position to an arbitrary value. Useful for placing items at the top of
a plot area (`pNum 0`) or a fixed number of pixels from the top.
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
`pMType Quantitative`.
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
    let
        isNotPmType pp =
            case pp of
                PmType t ->
                    False

                _ ->
                    True
    in
    case pos of
        X ->
            (::) ( positionLabel X, List.map positionChannelProperty pDefs |> JE.object )

        Y ->
            (::) ( positionLabel Y, List.map positionChannelProperty pDefs |> JE.object )

        X2 ->
            (::) ( positionLabel X2, List.map positionChannelProperty pDefs |> JE.object )

        Y2 ->
            (::) ( positionLabel Y2, List.map positionChannelProperty pDefs |> JE.object )

        XError ->
            (::) ( positionLabel XError, List.map positionChannelProperty pDefs |> JE.object )

        YError ->
            (::) ( positionLabel YError, List.map positionChannelProperty pDefs |> JE.object )

        XError2 ->
            (::) ( positionLabel XError2, List.map positionChannelProperty pDefs |> JE.object )

        YError2 ->
            (::) ( positionLabel YError2, List.map positionChannelProperty pDefs |> JE.object )

        Longitude ->
            (::) ( positionLabel Longitude, List.map positionChannelProperty pDefs |> JE.object )

        Latitude ->
            (::) ( positionLabel Latitude, List.map positionChannelProperty pDefs |> JE.object )

        Longitude2 ->
            (::) ( positionLabel Longitude2, List.map positionChannelProperty pDefs |> JE.object )

        Latitude2 ->
            (::) ( positionLabel Latitude2, List.map positionChannelProperty pDefs |> JE.object )


{-| Projection’s center as longitude and latitude in degrees.
-}
prCenter : Float -> Float -> ProjectionProperty
prCenter =
    PCenter


{-| Projection’s clipping circle radius to the specified angle in degrees.
A value of `Nothing` will switch to antimeridian cutting rather than small-circle
clipping.
-}
prClipAngle : Maybe Float -> ProjectionProperty
prClipAngle =
    PClipAngle


{-| Projection’s viewport clip extent to the specified bounds in pixels.
-}
prClipExtent : ClipRect -> ProjectionProperty
prClipExtent =
    PClipExtent


{-| 'Hammer' map projection coefficient.
-}
prCoefficient : Float -> ProjectionProperty
prCoefficient =
    PCoefficient


{-| 'Satellite' map projection distance.
-}
prDistance : Float -> ProjectionProperty
prDistance =
    PDistance


{-| Reference in a position channel to a field name generated by [repeatFlow](#repeatFlow)
or [repeat](#repeat). The parameter identifies whether reference is being made to
fields that are to be arranged in columns, in rows or a with a flow layout.

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


{-| `Bottomley` map projection fraction.
-}
prFraction : Float -> ProjectionProperty
prFraction =
    PFraction


{-| Number of lobes in lobed map projections such as the 'Berghaus star'.
-}
prLobes : Int -> ProjectionProperty
prLobes =
    PLobes


{-| Parallel for map projections such as the 'Armadillo'.
-}
prParallel : Float -> ProjectionProperty
prParallel =
    PParallel


{-| Threshold for the projection’s adaptive resampling in pixels.
Corresponds to the Douglas–Peucker distance. If precision is not specified, the
projection’s current resampling precision of 0.707 is used.
-}
prPrecision : Float -> ProjectionProperty
prPrecision =
    PPrecision


{-| Radius value for map projections such as the 'Gingery'.
-}
prRadius : Float -> ProjectionProperty
prRadius =
    PRadius


{-| Ratio value for map projections such as the 'Hill'.
-}
prRatio : Float -> ProjectionProperty
prRatio =
    PRatio


{-| Map projection used for geospatial coordinates.

    proj =
        projection [ prType equirectangular, prRotate -156 0 0 ]

-}
projection : List ProjectionProperty -> ( VLProperty, Spec )
projection pProps =
    ( VLProjection, JE.object (List.map projectionProperty pProps) )


{-| Reflect the x-coordinates after performing an identity projection. This
creates a left-right mirror image of the geoshape marks when subject to an
[identityProjection](#identityProjection).
-}
prReflectX : Bool -> ProjectionProperty
prReflectX =
    PReflectX


{-| Reflect the y-coordinates after performing an identity projection. This
creates a top-bottom mirror image of the geoshape marks when subject to an
[identityProjection](#identityProjection).
-}
prReflectY : Bool -> ProjectionProperty
prReflectY =
    PReflectY


{-| A projection’s three-axis rotation angle. This should be in order _lambda phi
gamma_ specifying the rotation angles in degrees about each spherical axis.
-}
prRotate : Float -> Float -> Float -> ProjectionProperty
prRotate =
    PrRotate


{-| A projection’s zoom scale, which if set, overrides automatic scaling of a
geo feature to fit within the viewing area.
-}
prScale : Float -> ProjectionProperty
prScale =
    PrScale


{-| Spacing value for map projections such as the 'Lagrange'.
-}
prSpacing : Float -> ProjectionProperty
prSpacing =
    PSpacing


{-| 'Satellite' map projection tilt.
-}
prTilt : Float -> ProjectionProperty
prTilt =
    PTilt


{-| A projection’s panning translation, which if set, overrides automatic positioning
of a geo feature to fit within the viewing area.
-}
prTranslate : Float -> Float -> ProjectionProperty
prTranslate =
    PrTranslate


{-| Type of global map projection.
-}
prType : Projection -> ProjectionProperty
prType =
    PType


{-| Scaling applied to a field when encoding with a position channel.
The scale will transform a field's value into a position along one axis.

For example, the following will scale the bars positioned along a horizontal axis
to have an inner spacing of 50% (0.5) of the total space allocated to each bar.

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
example, stacking areas away from a centreline can be used to create a
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
`pMType Temporal`.
-}
pTemporal : PositionChannel
pTemporal =
    PmType Temporal


{-| Form of time unit aggregation of field values when encoding with a position channel.
-}
pTimeUnit : TimeUnit -> PositionChannel
pTimeUnit =
    PTimeUnit


{-| Title of a field when encoding with a position channel. Multi-line titles can
be specified by adding a `\n` at line breaks.
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
specified, a single group contianing all data objects will be used.
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


{-| The interval between probabilties to use when performing a quantile transformation.
All values from half the given step size to 1 will be sampled. Only used if [qtProbs](#qtProbs)
is not specified.
-}
qtStep : Float -> QuantileProperty
qtStep =
    QtStep


{-| The field names to give the probability and associated quantile values generated
by a quantile transofrmation. If not specified, `prob` and `value` are used.
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


{-| Name of a pre-defined scale range (e.g. `symbol` or `diverging`).
-}
raName : String -> ScaleRange
raName =
    RName


{-| Numeric scale range. Depending on the scaling this may be a [min, max]
pair, or a list of explicit numerical values.
-}
raNums : List Float -> ScaleRange
raNums =
    RNumbers


{-| Text scale range for discrete scales.
-}
raStrs : List String -> ScaleRange
raStrs =
    RStrings


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


{-| Indicates an exponential regression method.
-}
rgExp : RegressionMethod
rgExp =
    RgExp


{-| The min (first parameter) - max (second parameter) domain over which to estimate
the dependent variable in a regression. If unspecified, the full extent of input
values will be used.
-}
rgExtent : DataValue -> DataValue -> RegressionProperty
rgExtent =
    RgExtent


{-| The data fields to group by when generating a regression model. If not
specified, a single group containing all data objects will be used.
-}
rgGroupBy : List String -> RegressionProperty
rgGroupBy =
    RgGroupBy


{-| Indicates a linear regression method.
-}
rgLinear : RegressionMethod
rgLinear =
    RgLinear


{-| Indicates a log regression method.
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


{-| Indicates a polynomial regression method. The order of the polynomial can be
set with [rgOrder](#rgOrder) (defaulting to cubic if not provided).
-}
rgPoly : RegressionMethod
rgPoly =
    RgPoly


{-| Indicates a power regression method.
-}
rgPow : RegressionMethod
rgPow =
    RgPow


{-| Indicates a quadratic regression method.
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


{-| Deprecated in favour of [vicoStep](#vicoStep).
-}
sacoRangeStep : Maybe Float -> ScaleConfig
sacoRangeStep =
    SCRangeStep


{-| Whether or not numeric values are rounded to integers when scaling. Useful
for snapping to the pixel grid.
-}
sacoRound : Bool -> ScaleConfig
sacoRound =
    SCRound


{-| Deprecated in favour of [vicoStep](#vicoStep).
-}
sacoTextXRangeStep : Float -> ScaleConfig
sacoTextXRangeStep =
    SCTextXRangeStep


{-| Whether or not to use the source data range before aggregation.
-}
sacoUseUnaggregatedDomain : Bool -> ScaleConfig
sacoUseUnaggregatedDomain =
    SCUseUnaggregatedDomain


{-| Randomly sample rows from a data source up to a given maximum. For example,
to randomly sample 50 values from a sine curve.

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


{-| A linear band scale.
-}
scBinLinear : Scale
scBinLinear =
    ScBinLinear


{-| An ordinal band scale.
-}
scBinOrdinal : Scale
scBinOrdinal =
    ScBinOrdinal


{-| Whether or not values outside the data domain are clamped to the minimum or
maximum value.
-}
scClamp : Bool -> ScaleProperty
scClamp =
    SClamp


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


{-| Set the midpoint of continuous diverging domain. Useful when the domain is not
symmetric about the given midpoint but you wish to use a color scheme that diverges
equally from that point.
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


{-| Deprecated in favour of [widthStep](#widthStep) and [heightStep](#heightStep).
-}
scRangeStep : Maybe Float -> ScaleProperty
scRangeStep =
    SRangeStep


{-| Deprecated in favour of [pSort](#pSort), [mSort](#mSort) or [fSort](#fSort),
providing [soDescending](#soDescending) as the sort order.
-}
scReverse : Bool -> ScaleProperty
scReverse =
    SReverse


{-| Whether or not numeric values in a scaling are rounded to integers.
-}
scRound : Bool -> ScaleProperty
scRound =
    SRound


{-| Color scheme used by a color scaling with [mScale](#mScale). The first parameter
is the name of the scheme (e.g. "viridis") and the second an optional specification
of the number of colors to use (list of one number), or the extent of the color
range to use (list of two numbers between 0 and 1). For example

    color
        [ mName "value"
        , mOrdinal
        , mScale [ scScheme "redblue" [ 0, 0.8 ] ]
        ]

-}
scScheme : String -> List Float -> ScaleProperty
scScheme =
    SScheme


{-| Deprecated in favour of [scLinear](#scLinear).
-}
scSequential : Scale
scSequential =
    ScLinear


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
scZero =
    SZero


{-| Bind to some input elements as part of a named selection. For example, to
allow a selection to be based on a drop-down list of options:

    sel =
        selection
            << select "mySelection"
                seSingle
                [ seFields [ "crimeType" ]
                , seBind
                    [ iSelect "crimeType"
                        [ inOptions
                            [ "Anti-social behaviour"
                            , "Criminal damage and arson"
                            , "Drugs"
                            , "Robbery"
                            , "Vehicle crime"
                            ]
                        ]
                    ]
                ]

-}
seBind : List Binding -> SelectionProperty
seBind =
    Bind


{-| Enable binding between a legend selection and the item it references. Currently
only applicable to categorical (symbol) legends.

For example, to make an interactive legend of crime types that can be selected
with a click:

    sel =
        selection
            << select "mySelection"
                seSingle
                [ seBindLegend [ blField "crimeType" ] ]

To make the binding two-way (clcking on an item in the chart selects its legend
category), add an event stream selector to the selection with [seOn](#seOn).

For example, to allow multiple legend entries to be selected with double clicks
directly on the legend or clicks on the main chart:

    select "mySelection"
        seMulti
        [ seOn "click"
        , seBindLegend
            [ blField "crimeType"
            , blEvent "dblclick"
            ]
        ]

-}
seBindLegend : List BindLegendProperty -> SelectionProperty
seBindLegend =
    BindLegend


{-| Enable two-way binding between a selection and the scales used in the same
view. Commonly used for zooming and panning by binding selection to position scaling:

    sel =
        selection
            << select "mySelection" seInterval [ seBindScales ]

-}
seBindScales : SelectionProperty
seBindScales =
    BindScales


{-| [Vega event stream selector](https://vega.github.io/vega/docs/event-streams/#selector)
that can clear a selection. For example, to allow a zoomed/panned view to be reset
on shift-click:

    selection
        << select "myZoomPan"
            seInterval
            [ seBindScales, seClear "click[event.shiftKey]" ]

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


{-| Make a selection empty by default when nothing selected.
-}
seEmpty : SelectionProperty
seEmpty =
    Empty


{-| Encoding channels that form a named selection. For example, to _project_ a
selection across all items that share the same value in the color channel:

    sel =
        selection
            << select "mySelection" seMulti [ seEncodings [ chColor ] ]

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


{-| Initialise one or more selections with values from bound fields.

    sel =
        selection
            << select "CylYr"
                seSingle
                [ seFields [ "Cylinders", "Year" ]
                , seInit
                    [ ( "Cylinders", num 4 )
                    , ( "Year", num 1977 )
                    ]
                , seBind
                    [ iRange "Cylinders" [ inName "Cylinders ", inMin 3, inMax 8, inStep 1 ]
                    , iRange "Year" [ inName "Year ", inMin 1969, inMax 1981, inStep 1 ]
                    ]
                ]

-}
seInit : List ( String, DataValue ) -> SelectionProperty
seInit =
    SInit


{-| Initialse the domain extent of an interval selection. The parameters refer to
the (xMin, xMax) and (yMin, yMax) domain extents of the initial interval selection.
If one of the tuples is `Nothing` the selection is projected over that dimension.
If both are nothing, no initialization is provided.

Initialise selection between 2013-2015 along x-channel and 40-80 along y-channel:

    select "mySelection"
        seInterval
        [ seInitInterval (Just ( dt [ dtYear 2013 ], dt [ dtYear 2015 ] ))
            (Just ( num 40, num 80 ))
        ]

Initialise selection on the y-channel between 40-80 and project across the x-channel:

    select "mySelection"
        seInterval
        [ seInitInterval Nothing (Just ( num 40, num 80 )) ]

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


{-| Create a single named selection that may be applied to a data query or transformation.
The first two parameters specify the name to be given to the selection for later
reference and the type of selection made. The third allows additional selection options to
be specified.
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


{-| Interactive selection that will be true or false as part of a logical composition.
e.g., to filter a dataset so that only items selected interactively and that have
a weight of more than 30:

    transform
        << filter (fCompose (and (selected "brush") (expr "datum.weight > 30")))

-}
selected : String -> BooleanOp
selected =
    Selection


{-| Create a full selection specification from a list of selections.

    sel =
        selection
            << select "view" seInterval [ seBindScales ] []
            << select "myBrush" seInterval []
            << select "myPaintbrush" seMulti [ seOn "mouseover", seNearest True ]

-}
selection : List LabelledSpec -> ( VLProperty, Spec )
selection sels =
    ( VLSelection, JE.object sels )


{-| Name a selection that is used as part of a conditional encoding.

    color
        [ mSelectionCondition (selectionName "myBrush")
            [ mName "myField", mNominal ]
            [ mStr "grey" ]
        ]

-}
selectionName : String -> BooleanOp
selectionName =
    SelectionName


{-| Indicate multiple interactive mark selections can be made (e.g. with shift-click).
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
that triggers a selection.
-}
seOn : String -> SelectionProperty
seOn =
    On


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


{-| Indicate a single, mark at a time, interactive selection can be made.
-}
seSingle : Selection
seSingle =
    SeSingle


{-| Predicate expression that determines a toggled selection. See the
[Vega-Lite toggle documentation](https://vega.github.io/vega-lite/docs/toggle.html)
-}
seToggle : String -> SelectionProperty
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


{-| Bottom side, used to specify an axis position.
-}
siBottom : Side
siBottom =
    SBottom


{-| Left side, used to specify an axis position.
-}
siLeft : Side
siLeft =
    SLeft


{-| Right side, used to specify an axis position.
-}
siRight : Side
siRight =
    SRight


{-| Top side, used to specify an axis position.
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
    Str


{-| Encode a stroke channel. This acts in a similar way to encoding by `color` but
only affects the exterior boundary of marks.
-}
stroke : List MarkChannel -> List LabelledSpec -> List LabelledSpec
stroke markProps =
    (::) ( "stroke", List.concatMap markChannelProperties markProps |> JE.object )


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
([imKeyVals](#imKeyVals)) and customized sorting ([soCustom](#soCustom)).
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


{-| Make a text channel conditional on one or more predicate expressions. The first
parameter is a list of tuples each pairing an expression to evaluate with the encoding
if that expression is true. The second is the encoding if none of the expressions
are evaluated as true.
-}
tDataCondition : List ( BooleanOp, List TextChannel ) -> List TextChannel -> TextChannel
tDataCondition =
    TDataCondition


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


{-| Specify a title anchor position relative to the group width / height.
-}
tfGroup : TitleFrame
tfGroup =
    FrGroup


{-| [Formatting pattern](https://vega.github.io/vega-lite/docs/format.html)
for text marks. To distinguish between formatting as numeric values and data/time
values, additionally use [tFormatAsNum](#tFormatAsNum) or [tFormatAsTemporal](#tFormatAsTemporal).
-}
tFormat : String -> TextChannel
tFormat =
    TFormat


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
tiAngle =
    TAngle << positiveAngle


{-| Vertical alignment of a title.
-}
tiBaseline : VAlign -> TitleProperty
tiBaseline =
    TBaseline


{-| Text colour of a title.
-}
tiColor : String -> TitleProperty
tiColor =
    TColor


{-| Title font.
-}
tiFont : String -> TitleProperty
tiFont =
    TFont


{-| Title font size.
-}
tiFontSize : Float -> TitleProperty
tiFontSize =
    TFontSize


{-| Title font style (italic etc.).
-}
tiFontStyle : String -> TitleProperty
tiFontStyle =
    TFontStyle


{-| Title font weight.
-}
tiFontWeight : FontWeight -> TitleProperty
tiFontWeight =
    TFontWeight


{-| Title position anchor. Can be relative to the full bounding box
([frBounds](#frBounds)) or the group in which the titled visualiztion belongs
([frGroup](#frGroup)).
-}
tiFrame : TitleFrame -> TitleProperty
tiFrame =
    TFrame


{-| Maximum length of the title display in pixel units.
-}
tiLimit : Float -> TitleProperty
tiLimit =
    TLimit


{-| Offset in pixel units of the title relative to the chart body.
-}
tiOffset : Float -> TitleProperty
tiOffset =
    TOffset


{-| Placement of title relative to the chart body.
-}
tiOrient : Side -> TitleProperty
tiOrient =
    TOrient


{-| A list of named styles to apply to title. A named style can be specified via
[coNamedStyle](#coNamedStyle) or [coNamedStyles](#coNamedStyles) if more than one
style is required. Later styles in the list will override earlier styles if there
is a conflict in any of the mark properties specified.
-}
tiStyle : List String -> TitleProperty
tiStyle =
    TStyle


{-| Subtitle text, placed beneath the primary title. For subtitles that span multiple
lines, insert `\n` at line breaks or use a `"""` multi-line string.
-}
tiSubtitle : String -> TitleProperty
tiSubtitle =
    TSubtitle


{-| Color of a subtitle.
-}
tiSubtitleColor : String -> TitleProperty
tiSubtitleColor =
    TSubtitleColor


{-| Font name of a subtitle.
-}
tiSubtitleFont : String -> TitleProperty
tiSubtitleFont =
    TSubtitleFont


{-| Font size of a subtitle.
-}
tiSubtitleFontSize : Float -> TitleProperty
tiSubtitleFontSize =
    TSubtitleFontSize


{-| Font style of a subtitle such as `"normal"` or `"italic"`.
-}
tiSubtitleFontStyle : String -> TitleProperty
tiSubtitleFontStyle =
    TSubtitleFontStyle


{-| Font weight of a subtitle.
-}
tiSubtitleFontWeight : FontWeight -> TitleProperty
tiSubtitleFontWeight =
    TSubtitleFontWeight


{-| Line height in pixels of each line of text in a subtitle.
-}
tiSubtitleLineHeight : Float -> TitleProperty
tiSubtitleLineHeight =
    TSubtitleLineHeight


{-| Padding in pixels between title and subtitle text.
-}
tiSubtitlePadding : Float -> TitleProperty
tiSubtitlePadding =
    TSubtitlePadding


{-| Drawing order of a title relative to the other chart elements. 1 indicates
title is drawn in front of chart marks, 0 indicates it is drawn behind them.
-}
tiZIndex : Int -> TitleProperty
tiZIndex =
    TZIndex


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
ticoAngle =
    TAngle << positiveAngle


{-| Default vertical alignment when placing titles.
-}
ticoBaseline : VAlign -> TitleConfig
ticoBaseline =
    TBaseline


{-| Default color when showing titles.
-}
ticoColor : String -> TitleConfig
ticoColor =
    TColor


{-| Default font when showing titles.
-}
ticoFont : String -> TitleConfig
ticoFont =
    TFont


{-| Default font size when showing titles.
-}
ticoFontSize : Float -> TitleConfig
ticoFontSize =
    TFontSize


{-| Default font style (italic etc.) when showing titles.
-}
ticoFontStyle : String -> TitleConfig
ticoFontStyle =
    TFontStyle


{-| Default font weight when showing titles.
-}
ticoFontWeight : FontWeight -> TitleConfig
ticoFontWeight =
    TFontWeight


{-| Title position anchor. Can be relative to the full bounding box
([frBounds](#frBounds)) or the group in which the titled visualiztion belongs
([frGroup](#frGroup)).
-}
ticoFrame : TitleFrame -> TitleConfig
ticoFrame =
    TFrame


{-| Default maximum length in pixel units when showing titles.
-}
ticoLimit : Float -> TitleConfig
ticoLimit =
    TLimit


{-| Line height (vertical spacing) for multi-line titles.
-}
ticoLineHeight : Float -> TitleConfig
ticoLineHeight =
    TLineHeight


{-| Default offset in pixel units of titles relative to the chart body.
-}
ticoOffset : Float -> TitleConfig
ticoOffset =
    TOffset


{-| Default placement of titles relative to the chart body.
-}
ticoOrient : Side -> TitleConfig
ticoOrient =
    TOrient


{-| A list of named styles to apply to titles. A named style can be specified via
[coNamedStyle](#coNamedStyle) or [coNamedStyles](#coNamedStyles) if more than one
style is required. Later styles in the list will override earlier
styles if there is a conflict in any of the mark properties specified.
-}
ticoStyle : List String -> TitleConfig
ticoStyle =
    TStyle


{-| Default color of a subtitle.
-}
ticoSubtitleColor : String -> TitleProperty
ticoSubtitleColor =
    TSubtitleColor


{-| Default font name of a subtitle.
-}
ticoSubtitleFont : String -> TitleProperty
ticoSubtitleFont =
    TSubtitleFont


{-| Default font size of a subtitle.
-}
ticoSubtitleFontSize : Float -> TitleProperty
ticoSubtitleFontSize =
    TSubtitleFontSize


{-| Default ont style of a subtitle such as `"normal"` or `"italic"`.
-}
ticoSubtitleFontStyle : String -> TitleProperty
ticoSubtitleFontStyle =
    TSubtitleFontStyle


{-| Default font weight of a subtitle.
-}
ticoSubtitleFontWeight : FontWeight -> TitleProperty
ticoSubtitleFontWeight =
    TSubtitleFontWeight


{-| Default line height in pixels of each line of text in a subtitle.
-}
ticoSubtitleLineHeight : Float -> TitleProperty
ticoSubtitleLineHeight =
    TSubtitleLineHeight


{-| Default padding in pixels between title and subtitle text.
-}
ticoSubtitlePadding : Float -> TitleProperty
ticoSubtitlePadding =
    TSubtitlePadding


{-| Default drawing order of titles relative to the other chart elements. 1 indicates
titles are drawn in front of chart marks, 0 indicates they are drawn behind them.
-}
ticoZIndex : Int -> TitleConfig
ticoZIndex =
    TZIndex


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


{-| Specify the maximum number of bins used when discretising time units. Can be
useful as an alternative to explicitly providing a time unit to bin by as it will
be inferred from the temporal domain extent and the number of bins. For example,

    tuMaxBins 366

when applied to a dataset of hourly readings for a full year, will bin into days.

-}
tuMaxBins : Int -> TimeUnit
tuMaxBins =
    TUMaxBins


{-| Specify the the number of steps between time unit bins, in terms of the least
significant unit provided. For example

    tuStep 14 yearMonthDate

will bin temporal data into biweekly weekly groups.

-}
tuStep : Float -> TimeUnit -> TimeUnit
tuStep =
    TUStep


{-| Title to be displayed for a plot. The first parameter is the text of the title,
the second a list of any title properties to configure its appearance. To display
a title over more than one line, insert line breaks with `\n` or use a multi-line
string. For example,

    title "First line\nSecond line" []

or

    title """First line
    Second line""" []

-}
title : String -> List TitleProperty -> ( VLProperty, Spec )
title txt tps =
    ( VLTitle
    , JE.object
        (( "text", multilineTextSpec txt )
            :: List.map titleConfigProperty tps
        )
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
`tMType Nominal`.
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
    ( "$schema", JE.string "https://vega.github.io/schema/vega-lite/v4.json" )
        :: List.map (\( s, v ) -> ( vlPropertyLabel s, v )) spec
        |> JE.object


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


{-| Make a text channel conditional on interactive selection. The first parameter
is a selection condition to evaluate; the second the encoding to apply if that
selection is true; the third parameter is the encoding if the selection is false.
-}
tSelectionCondition : BooleanOp -> List TextChannel -> List TextChannel -> TextChannel
tSelectionCondition =
    TSelectionCondition


{-| Literal string value when encoding with a text property channel. Can be useful
for quick text annotation. Text can be multi-line by inserting a `\n` at line breaks
or by using `"""` multi-line strings. For example,

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


{-| Indicate a data field encoded as a text property is temporal. Equivalent to
`tMType Temporal`.
-}
tTemporal : TextChannel
tTemporal =
    TmType Temporal


{-| Indicate tooltips should be enebled using the encoded data of the mark.

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


{-| Title of a field when encoding with a text or tooltip channel. Multi-line
titles can be specified by adding a `\n` at line breaks.
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
    AlignAlphabetic


{-| Vertically align text marks by the bottom of descenders (e.g. bottom of a 'g').
-}
vaBottom : VAlign
vaBottom =
    AlignBottom


{-| Vertically align text marks by their middle (e.g. middle of an 'x').
-}
vaMiddle : VAlign
vaMiddle =
    AlignMiddle


{-| Vertically align text marks by the top of ascenders (e.g. top of an 'A').
-}
vaTop : VAlign
vaTop =
    AlignTop


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


{-| Depcrecated in favour of [vicoContinuousHeight](#vicoContinuousHeight) or
[vicoDiscreteHeight](#vicoDiscreteHeight).
-}
vicoHeight : Float -> ViewConfig
vicoHeight =
    VContinuousHeight


{-| Configure the default single view style.
-}
vicoBackground : List ViewBackground -> ViewConfig
vicoBackground =
    VBackground


{-| Depcrecated in favour of [vicoContinuousWidth](#vicoContinuousWidth) or
[vicoDiscreteWidth](#vicoDiscreteWidth).
-}
vicoWidth : Float -> ViewConfig
vicoWidth =
    VContinuousWidth


{-| The background style of a single view or layer in a view composition.
-}
viewBackground : List ViewBackground -> ( VLProperty, Spec )
viewBackground vbs =
    ( VLViewBackground, JE.object (List.map viewBackgroundProperty vbs) )


{-| The radius in pixels of rounded corners in single view or layer background.
-}
viewCornerRadius : Float -> ViewBackground
viewCornerRadius =
    VBCornerRadius


{-| Fill color for a single view or layer background.
-}
viewFill : Maybe String -> ViewBackground
viewFill =
    VBFill


{-| Fill opacity for a single view or layer background.
-}
viewFillOpacity : Float -> ViewBackground
viewFillOpacity =
    VBFillOpacity


{-| Overall opacity for a single view or layer background.
-}
viewOpacity : Float -> ViewBackground
viewOpacity =
    VBOpacity


{-| Stroke color for line around a single view or layer background. If `Nothing`
is provided, no strokes are drawn around the view.
-}
viewStroke : Maybe String -> ViewBackground
viewStroke =
    VBStroke


{-| Stroke cap line-ending around a single view or layer background.
-}
viewStrokeCap : StrokeCap -> ViewBackground
viewStrokeCap =
    VBStrokeCap


{-| Stroke dash style for a line around a single view or layer background.
-}
viewStrokeDash : List Float -> ViewBackground
viewStrokeDash =
    VBStrokeDash


{-| Stroke dash offset for line around a single view or layer background.
-}
viewStrokeDashOffset : Float -> ViewBackground
viewStrokeDashOffset =
    VBStrokeDashOffset


{-| Stroke line-joining style around a single view or layer background.
-}
viewStrokeJoin : StrokeJoin -> ViewBackground
viewStrokeJoin =
    VBStrokeJoin


{-| Stroke mitre limit at which to bevel a line join around a single view or
layer background.
-}
viewStrokeMiterLimit : Float -> ViewBackground
viewStrokeMiterLimit =
    VBStrokeMiterLimit


{-| Stroke opacity around a single view or layer background.
-}
viewStrokeOpacity : Float -> ViewBackground
viewStrokeOpacity =
    VBStrokeOpacity


{-| Stroke around a single view or layer background.
-}
viewStrokeWidth : Float -> ViewBackground
viewStrokeWidth =
    VBStrokeWidth


{-| A list of named styles to apply to a single view background. A named style
can be specified via [coNamedStyle](#coNamedStyle) or [coNamedStyles](#coNamedStyles)
if more than one style is required. Later styles in the list will override earlier
styles if there is a conflict in any of the mark properties specified.
-}
viewStyle : List String -> ViewBackground
viewStyle =
    VBStyle


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
with [autosize])(#autosize).

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


{-| Assign consecutive row number to values in a data object to be applied in a window transform.
-}
woRowNumber : WOperation
woRowNumber =
    RowNumber


{-| Year time unit used for discretizing temporal data.
-}
year : TimeUnit
year =
    Year


{-| Year and year quarter time unit used for discretizing temporal data.
-}
yearQuarter : TimeUnit
yearQuarter =
    YearQuarter


{-| Year, quarter and month time unit used for discretizing temporal data.
-}
yearQuarterMonth : TimeUnit
yearQuarterMonth =
    YearQuarterMonth


{-| Year and month time unit used for discretizing temporal data.
-}
yearMonth : TimeUnit
yearMonth =
    YearMonth


{-| Year, month and day of month time unit used for discretizing temporal data.
-}
yearMonthDate : TimeUnit
yearMonthDate =
    YearMonthDate


{-| Year, month, day of month and hour of day time unit used for discretizing temporal data.
-}
yearMonthDateHours : TimeUnit
yearMonthDateHours =
    YearMonthDateHours


{-| Time unit used for discretizing temporal data.
-}
yearMonthDateHoursMinutes : TimeUnit
yearMonthDateHoursMinutes =
    YearMonthDateHoursMinutes


{-| Time unit used for discretizing temporal data.
-}
yearMonthDateHoursMinutesSeconds : TimeUnit
yearMonthDateHoursMinutesSeconds =
    YearMonthDateHoursMinutesSeconds



-- ################################################# Private types and functions


transpose : List (List a) -> List (List a)
transpose xss =
    let
        numCols =
            List.head >> Maybe.withDefault [] >> List.length
    in
    List.foldr (List.map2 (::)) (List.repeat (numCols xss) []) xss



-- Functions to convert types into their string label, labelled spec or spec


anchorLabel : Anchor -> String
anchorLabel an =
    case an of
        AnStart ->
            "start"

        AnMiddle ->
            "middle"

        AnEnd ->
            "end"


arrangementLabel : Arrangement -> String
arrangementLabel arrng =
    case arrng of
        Row ->
            "row"

        Column ->
            "column"

        Flow ->
            "repeat"


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


axisConfigProperty : AxisConfig -> LabelledSpec
axisConfigProperty axisCfg =
    case axisCfg of
        BandPosition x ->
            ( "bandPosition", JE.float x )

        Domain b ->
            ( "domain", JE.bool b )

        DomainColor c ->
            ( "domainColor", JE.string c )

        DomainOpacity n ->
            ( "domainOpacity", JE.float n )

        DomainWidth w ->
            ( "domainWidth", JE.float w )

        MaxExtent n ->
            ( "maxExtent", JE.float n )

        MinExtent n ->
            ( "minExtent", JE.float n )

        Grid b ->
            ( "grid", JE.bool b )

        GridColor c ->
            ( "gridColor", JE.string c )

        GridDash ds ->
            if ds == [] then
                ( "gridDash", JE.null )

            else
                ( "gridDash", JE.list JE.float ds )

        GridOpacity o ->
            ( "gridOpacity", JE.float o )

        GridWidth x ->
            ( "gridWidth", JE.float x )

        Labels b ->
            ( "labels", JE.bool b )

        LabelAlign ha ->
            ( "labelAlign", JE.string (hAlignLabel ha) )

        LabelAngle angle ->
            ( "labelAngle", JE.float angle )

        LabelBaseline va ->
            ( "labelBaseline", JE.string (vAlignLabel va) )

        LabelBound mn ->
            case mn of
                Just n ->
                    if n == 1 then
                        ( "labelBound", JE.bool True )

                    else
                        ( "labelBound", JE.float n )

                Nothing ->
                    ( "labelBound", JE.bool False )

        LabelColor c ->
            ( "labelColor", JE.string c )

        LabelExpr ex ->
            ( "labelExpr", JE.string ex )

        LabelFlush mn ->
            case mn of
                Just n ->
                    if n == 0 then
                        ( "labelFlush", JE.bool True )

                    else
                        ( "labelFlush", JE.float n )

                Nothing ->
                    ( "labelFlush", JE.bool False )

        LabelFlushOffset n ->
            ( "labelFlushOffset", JE.float n )

        LabelFont f ->
            ( "labelFont", JE.string f )

        LabelFontStyle s ->
            ( "labelFontStyle", JE.string s )

        LabelFontSize x ->
            ( "labelFontSize", JE.float x )

        LabelFontWeight fw ->
            ( "labelFontWeight", fontWeightSpec fw )

        LabelLimit x ->
            ( "labelLimit", JE.float x )

        LabelOpacity n ->
            ( "labelOpacity", JE.float n )

        LabelOverlap strat ->
            ( "labelOverlap", overlapStrategySpec strat )

        LabelPadding pad ->
            ( "labelPadding", JE.float pad )

        LabelSeparation x ->
            ( "labelSeparation", JE.float x )

        ShortTimeLabels b ->
            ( "shortTimeLabels", JE.bool b )

        Ticks b ->
            ( "ticks", JE.bool b )

        TickColor c ->
            ( "tickColor", JE.string c )

        TickExtra b ->
            ( "tickExtra", JE.bool b )

        TickOffset n ->
            ( "tickOffset", JE.float n )

        TickOpacity n ->
            ( "tickOpacity", JE.float n )

        TickMinStep n ->
            ( "tickMinStep", JE.float n )

        TickRound b ->
            ( "tickRound", JE.bool b )

        TickSize x ->
            ( "tickSize", JE.float x )

        TickWidth x ->
            ( "tickWidth", JE.float x )

        TitleAlign al ->
            ( "titleAlign", JE.string (hAlignLabel al) )

        TitleAngle angle ->
            ( "titleAngle", JE.float angle )

        TitleAnchor an ->
            ( "titleAnchor", JE.string (anchorLabel an) )

        TitleBaseline va ->
            ( "titleBaseline", JE.string (vAlignLabel va) )

        TitleColor c ->
            ( "titleColor", JE.string c )

        TitleFont f ->
            ( "titleFont", JE.string f )

        TitleFontStyle s ->
            ( "titleFontStyle", JE.string s )

        TitleFontWeight w ->
            ( "titleFontWeight", fontWeightSpec w )

        TitleFontSize x ->
            ( "titleFontSize", JE.float x )

        TitleLimit x ->
            ( "titleLimit", JE.float x )

        TitleLineHeight x ->
            ( "titleLineHeight", JE.float x )

        TitleOpacity n ->
            ( "titleOpacity", JE.float n )

        TitlePadding x ->
            ( "titlePadding", JE.float x )

        TitleX x ->
            ( "titleX", JE.float x )

        TitleY y ->
            ( "titleY", JE.float y )


axisProperty : AxisProperty -> LabelledSpec
axisProperty axisProp =
    case axisProp of
        AxBandPosition n ->
            ( "bandPosition", JE.float n )

        AxDataCondition predicate cap ->
            let
                ( ifProp, elseProp ) =
                    case cap of
                        CAxLabelAlign ha1 ha2 ->
                            ( axisProperty (AxLabelAlign ha1), axisProperty (AxLabelAlign ha2) )

                        CAxLabelBaseline va1 va2 ->
                            ( axisProperty (AxLabelBaseline va1), axisProperty (AxLabelBaseline va2) )

                        CAxLabelColor c1 c2 ->
                            ( axisProperty (AxLabelColor c1), axisProperty (AxLabelColor c2) )

                        CAxLabelFont f1 f2 ->
                            ( axisProperty (AxLabelFont f1), axisProperty (AxLabelFont f2) )

                        CAxLabelFontSize s1 s2 ->
                            ( axisProperty (AxLabelFontSize s1), axisProperty (AxLabelFontSize s2) )

                        CAxLabelFontStyle s1 s2 ->
                            ( axisProperty (AxLabelFontStyle s1), axisProperty (AxLabelFontStyle s2) )

                        CAxLabelFontWeight w1 w2 ->
                            ( axisProperty (AxLabelFontWeight w1), axisProperty (AxLabelFontWeight w2) )

                        CAxLabelOpacity o1 o2 ->
                            ( axisProperty (AxLabelOpacity o1), axisProperty (AxLabelOpacity o2) )

                        CAxLabelPadding p1 p2 ->
                            ( axisProperty (AxLabelPadding p1), axisProperty (AxLabelPadding p2) )

                        CAxTickColor c1 c2 ->
                            ( axisProperty (AxTickColor c1), axisProperty (AxTickColor c2) )

                        CAxTickOpacity o1 o2 ->
                            ( axisProperty (AxTickOpacity o1), axisProperty (AxTickOpacity o2) )

                        CAxTickSize s1 s2 ->
                            ( axisProperty (AxTickSize s1), axisProperty (AxTickSize s2) )

                        CAxTickWidth w1 w2 ->
                            ( axisProperty (AxTickWidth w1), axisProperty (AxTickWidth w2) )

                        CAxGridColor c1 c2 ->
                            ( axisProperty (AxGridColor c1), axisProperty (AxGridColor c2) )

                        CAxGridDash d1 d2 ->
                            ( axisProperty (AxGridDash d1), axisProperty (AxGridDash d2) )

                        CAxGridOpacity o1 o2 ->
                            ( axisProperty (AxGridOpacity o1), axisProperty (AxGridOpacity o2) )

                        CAxGridWidth w1 w2 ->
                            ( axisProperty (AxGridWidth w1), axisProperty (AxGridWidth w2) )
            in
            ( Tuple.first ifProp
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

        AxFormat fmt ->
            ( "format", JE.string fmt )

        AxFormatAsNum ->
            ( "formatType", JE.string "number" )

        AxFormatAsTemporal ->
            ( "formatType", JE.string "time" )

        AxGridColor c ->
            ( "gridColor", JE.string c )

        AxGridDash ds ->
            if ds == [] then
                ( "gridDash", JE.null )

            else
                ( "gridDash", JE.list JE.float ds )

        AxGridOpacity o ->
            ( "gridOpacity", JE.float o )

        AxGridWidth w ->
            ( "gridWidth", JE.float w )

        AxLabels b ->
            ( "labels", JE.bool b )

        AxLabelAlign ha ->
            ( "labelAlign", JE.string (hAlignLabel ha) )

        AxLabelBaseline va ->
            ( "labelBaseline", JE.string (vAlignLabel va) )

        AxLabelBound mn ->
            case mn of
                Just n ->
                    if n == 1 then
                        ( "labelBound", JE.bool True )

                    else
                        ( "labelBound", JE.float n )

                Nothing ->
                    ( "labelBound", JE.bool False )

        AxLabelAngle angle ->
            ( "labelAngle", JE.float angle )

        AxLabelColor s ->
            ( "labelColor", JE.string s )

        AxLabelExpr ex ->
            ( "labelExpr", JE.string ex )

        AxLabelFlush mn ->
            case mn of
                Just n ->
                    if n == 1 then
                        ( "labelFlush", JE.bool True )

                    else
                        ( "labelFlush", JE.float n )

                Nothing ->
                    ( "labelFlush", JE.bool False )

        AxLabelFlushOffset n ->
            ( "labelFlushOffset", JE.float n )

        AxLabelFont s ->
            ( "labelFont", JE.string s )

        AxLabelFontSize n ->
            ( "labelFontSize", JE.float n )

        AxLabelFontStyle s ->
            ( "labelFontStyle", JE.string s )

        AxLabelFontWeight fw ->
            ( "labelFontWeight", fontWeightSpec fw )

        AxLabelLimit n ->
            ( "labelLimit", JE.float n )

        AxLabelOpacity n ->
            ( "labelOpacity", JE.float n )

        AxLabelOverlap strat ->
            ( "labelOverlap", overlapStrategySpec strat )

        AxLabelPadding pad ->
            ( "labelPadding", JE.float pad )

        AxLabelSeparation x ->
            ( "labelSeparation", JE.float x )

        AxDomain b ->
            ( "domain", JE.bool b )

        AxDomainColor c ->
            ( "domainColor", JE.string c )

        AxDomainOpacity n ->
            ( "domainOpacity", JE.float n )

        AxDomainWidth n ->
            ( "domainWidth", JE.float n )

        AxGrid b ->
            ( "grid", JE.bool b )

        AxMaxExtent n ->
            ( "maxExtent", JE.float n )

        AxMinExtent n ->
            ( "minExtent", JE.float n )

        AxOrient side ->
            ( "orient", JE.string (sideLabel side) )

        AxOffset n ->
            ( "offset", JE.float n )

        AxPosition n ->
            ( "position", JE.float n )

        AxZIndex n ->
            ( "zindex", JE.int n )

        AxTicks b ->
            ( "ticks", JE.bool b )

        AxTickColor s ->
            ( "tickColor", JE.string s )

        AxTickCount n ->
            ( "tickCount", JE.int n )

        AxTickExtra b ->
            ( "tickExtra", JE.bool b )

        AxTickOffset n ->
            ( "tickOffset", JE.float n )

        AxTickOpacity n ->
            ( "tickOpacity", JE.float n )

        AxTickRound b ->
            ( "tickRound", JE.bool b )

        AxTickMinStep n ->
            ( "tickMinStep", JE.float n )

        AxTickSize sz ->
            ( "tickSize", JE.float sz )

        AxTickWidth n ->
            ( "tickWidth", JE.float n )

        AxValues vals ->
            ( "values", toList (dataValuesSpecs vals) )

        AxDates dtss ->
            ( "values", JE.list (\ds -> JE.object (List.map dateTimeProperty ds)) dtss )

        AxTitle s ->
            ( "title", multilineTextSpec s )

        AxTitleAlign al ->
            ( "titleAlign", JE.string (hAlignLabel al) )

        AxTitleAngle angle ->
            ( "titleAngle", JE.float angle )

        AxTitleAnchor an ->
            ( "titleAnchor", JE.string (anchorLabel an) )

        AxTitleBaseline va ->
            ( "titleBaseline", JE.string (vAlignLabel va) )

        AxTitleColor s ->
            ( "titleColor", JE.string s )

        AxTitleFont s ->
            ( "titleFont", JE.string s )

        AxTitleFontSize n ->
            ( "titleFontSize", JE.float n )

        AxTitleFontStyle s ->
            ( "titleFontStyle", JE.string s )

        AxTitleFontWeight fw ->
            ( "titleFontWeight", fontWeightSpec fw )

        AxTitleLimit n ->
            ( "titleLimit", JE.float n )

        AxTitleOpacity n ->
            ( "titleOpacity", JE.float n )

        AxTitlePadding pad ->
            ( "titlePadding", JE.float pad )

        AxTitleX n ->
            ( "titleX", JE.float n )

        AxTitleY n ->
            ( "titleY", JE.float n )


bin : List BinProperty -> LabelledSpec
bin bProps =
    if bProps == [] then
        ( "bin", JE.bool True )

    else
        ( "bin", bProps |> List.map binProperty |> JE.object )


bindingSpec : Binding -> LabelledSpec
bindingSpec bnd =
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
            ( "extent", JE.object [ ( "selection", JE.string s ) ] )

        Nice b ->
            ( "nice", JE.bool b )


booleanOpSpec : BooleanOp -> Spec
booleanOpSpec bo =
    case bo of
        Expr ex ->
            JE.string ex

        FilterOp f ->
            filterSpec f

        FilterOpTrans tr f ->
            trFilterSpec tr f

        SelectionName selName ->
            JE.string selName

        Selection sel ->
            JE.object [ ( "selection", JE.string sel ) ]

        And operand1 operand2 ->
            JE.object [ ( "and", JE.list booleanOpSpec [ operand1, operand2 ] ) ]

        Or operand1 operand2 ->
            JE.object [ ( "or", JE.list booleanOpSpec [ operand1, operand2 ] ) ]

        Not operand ->
            JE.object [ ( "not", booleanOpSpec operand ) ]


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

        Axis acs ->
            ( "axis", JE.object (List.map axisConfigProperty acs) )

        AxisX acs ->
            ( "axisX", JE.object (List.map axisConfigProperty acs) )

        AxisY acs ->
            ( "axisY", JE.object (List.map axisConfigProperty acs) )

        AxisLeft acs ->
            ( "axisLeft", JE.object (List.map axisConfigProperty acs) )

        AxisRight acs ->
            ( "axisRight", JE.object (List.map axisConfigProperty acs) )

        AxisTop acs ->
            ( "axisTop", JE.object (List.map axisConfigProperty acs) )

        AxisBottom acs ->
            ( "axisBottom", JE.object (List.map axisConfigProperty acs) )

        AxisBand acs ->
            ( "axisBand", JE.object (List.map axisConfigProperty acs) )

        Legend lcs ->
            ( "legend", JE.object (List.map legendConfigProperty lcs) )

        MarkStyle mps ->
            ( "mark", JE.object (List.map markProperty mps) )

        Projection pps ->
            ( "projection", JE.object (List.map projectionProperty pps) )

        AreaStyle mps ->
            ( "area", JE.object (List.map markProperty mps) )

        BarStyle mps ->
            ( "bar", JE.object (List.map markProperty mps) )

        CircleStyle mps ->
            ( "circle", JE.object (List.map markProperty mps) )

        FacetStyle fps ->
            ( "facet", JE.object (List.map facetConfigProperty fps) )

        ConcatStyle cps ->
            ( "concat", JE.object (List.map concatConfigProperty cps) )

        GeoshapeStyle mps ->
            ( "geoshape", JE.object (List.map markProperty mps) )

        HeaderStyle hps ->
            ( "header", JE.object (List.map headerProperty hps) )

        LineStyle mps ->
            ( "line", JE.object (List.map markProperty mps) )

        PointStyle mps ->
            ( "point", JE.object (List.map markProperty mps) )

        RectStyle mps ->
            ( "rect", JE.object (List.map markProperty mps) )

        RuleStyle mps ->
            ( "rule", JE.object (List.map markProperty mps) )

        SquareStyle mps ->
            ( "square", JE.object (List.map markProperty mps) )

        TextStyle mps ->
            ( "text", JE.object (List.map markProperty mps) )

        TickStyle mps ->
            ( "tick", JE.object (List.map markProperty mps) )

        TitleStyle tcs ->
            ( "title", JE.object (List.map titleConfigProperty tcs) )

        NamedStyle styleName mps ->
            ( "style", JE.object [ ( styleName, JE.object (List.map markProperty mps) ) ] )

        NamedStyles styles ->
            ( "style"
            , JE.object
                (List.map
                    (\( sName, mps ) -> ( sName, JE.object (List.map markProperty mps) ))
                    styles
                )
            )

        Scale scs ->
            ( "scale", JE.object (List.map scaleConfigProperty scs) )

        Stack so ->
            stackOffsetProperty so

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
            ( "trail", JE.object (List.map markProperty mps) )


cursorLabel : Cursor -> String
cursorLabel cur =
    case cur of
        CAuto ->
            "auto"

        CDefault ->
            "default"

        CNone ->
            "none"

        CContextMenu ->
            "context-menu"

        CHelp ->
            "help"

        CPointer ->
            "pointer"

        CProgress ->
            "progress"

        CWait ->
            "wait"

        CCell ->
            "cell"

        CCrosshair ->
            "crosshair"

        CText ->
            "text"

        CVerticalText ->
            "vertical-text"

        CAlias ->
            "alias"

        CCopy ->
            "copy"

        CMove ->
            "move"

        CNoDrop ->
            "no-drop"

        CNotAllowed ->
            "not-allowed"

        CAllScroll ->
            "all-scroll"

        CColResize ->
            "col-resize"

        CRowResize ->
            "row-resize"

        CNResize ->
            "n-resize"

        CEResize ->
            "e-resize"

        CSResize ->
            "s-resize"

        CWResize ->
            "w-resize"

        CNEResize ->
            "ne-resize"

        CNWResize ->
            "nw-resize"

        CSEResize ->
            "se-resize"

        CSWResize ->
            "sw-resize"

        CEWResize ->
            "ew-resize"

        CNSResize ->
            "ns-resize"

        CNESWResize ->
            "nesw-resize"

        CNWSEResize ->
            "nwse-resize"

        CZoomIn ->
            "zoom-in"

        CZoomOut ->
            "zoom-out"

        CGrab ->
            "grab"

        CGrabbing ->
            "grabbing"


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

        Str s ->
            JE.string s

        Boolean b ->
            JE.bool b

        DateTime d ->
            JE.object (List.map dateTimeProperty d)

        NullValue ->
            JE.null


dataValuesSpecs : DataValues -> List Spec
dataValuesSpecs dvs =
    case dvs of
        Numbers xs ->
            List.map JE.float xs

        Strings ss ->
            List.map JE.string ss

        DateTimes dtss ->
            List.map (\ds -> JE.object (List.map dateTimeProperty ds)) dtss

        Booleans bs ->
            List.map JE.bool bs


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
            ( "extent", JE.list dataValueSpec [ mn, mx ] )

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
                    ( "sort", toList (dataValuesSpecs dvs) )

                _ ->
                    ( "sort", JE.object (List.concatMap sortProperties sps) )

        FAggregate op ->
            ( "aggregate", operationSpec op )

        FTimeUnit tu ->
            ( "timeUnit", timeUnitSpec tu )

        FHeader hProps ->
            ( "header", JE.object (List.map headerProperty hProps) )

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
            [ ( "selection", JE.string selName ) ]

        FRange field vals ->
            let
                values =
                    case vals of
                        NumberRange mn mx ->
                            JE.list JE.float [ mn, mx ]

                        DateRange [] [] ->
                            toList [ JE.null, JE.null ]

                        DateRange [] dMax ->
                            toList [ JE.null, JE.object (List.map dateTimeProperty dMax) ]

                        DateRange dMin [] ->
                            toList [ JE.object (List.map dateTimeProperty dMin), JE.null ]

                        DateRange dMin dMax ->
                            JE.list JE.object
                                [ List.map dateTimeProperty dMin
                                , List.map dateTimeProperty dMax
                                ]
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

                        Booleans bs ->
                            JE.list JE.bool bs
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


hAlignLabel : HAlign -> String
hAlignLabel al =
    case al of
        AlignLeft ->
            "left"

        AlignCenter ->
            "center"

        AlignRight ->
            "right"


headerProperty : HeaderProperty -> LabelledSpec
headerProperty hProp =
    case hProp of
        HFormat fmt ->
            ( "format", JE.string fmt )

        HFormatAsNum ->
            ( "formatType", JE.string "number" )

        HFormatAsTemporal ->
            ( "formatType", JE.string "time" )

        HLabelAlign ha ->
            ( "labelAlign", JE.string (hAlignLabel ha) )

        HLabelAnchor a ->
            ( "labelAnchor", JE.string (anchorLabel a) )

        HLabelAngle x ->
            ( "labelAngle", JE.float x )

        HLabelColor s ->
            ( "labelColor", JE.string s )

        HLabelFont s ->
            ( "labelFont", JE.string s )

        HLabelFontSize x ->
            ( "labelFontSize", JE.float x )

        HLabelLimit x ->
            ( "labelLimit", JE.float x )

        HLabelOrient orient ->
            ( "labelOrient", JE.string (sideLabel orient) )

        HLabelPadding x ->
            ( "labelPadding", JE.float x )

        HTitle s ->
            ( "title", multilineTextSpec s )

        HTitleAnchor a ->
            ( "titleAnchor", JE.string (anchorLabel a) )

        HTitleAlign ha ->
            ( "titleAlign", JE.string (hAlignLabel ha) )

        HTitleAngle x ->
            ( "titleAngle", JE.float x )

        HTitleBaseline va ->
            ( "titleBaseline", JE.string (vAlignLabel va) )

        HTitleColor s ->
            ( "titleColor", JE.string s )

        HTitleFont s ->
            ( "titleFont", JE.string s )

        HTitleFontWeight s ->
            ( "titleFontWeight", JE.string s )

        HTitleFontSize x ->
            ( "titleFontSize", JE.float x )

        HTitleLimit x ->
            ( "titleLimit", JE.float x )

        HTitleOrient orient ->
            ( "titleOrient", JE.string (sideLabel orient) )

        HTitlePadding x ->
            ( "titlePadding", JE.float x )


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

        HSelectionCondition selName ifClause elseClause ->
            ( "condition", JE.object (( "selection", booleanOpSpec selName ) :: List.concatMap hyperlinkChannelProperties ifClause) )
                :: List.concatMap hyperlinkChannelProperties elseClause

        HDataCondition predicate ifClause elseClause ->
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

        InPlaceholder el ->
            ( "placeholder", JE.string el )

        Element el ->
            ( "element", JE.string el )


legendConfigProperty : LegendConfig -> LabelledSpec
legendConfigProperty legendConfig =
    case legendConfig of
        LeClipHeight h ->
            ( "clipHeight", JE.float h )

        LeColumnPadding n ->
            ( "columnPadding", JE.float n )

        LeRowPadding n ->
            ( "rowPadding", JE.float n )

        LeColumns n ->
            ( "columns", JE.float n )

        CornerRadius r ->
            ( "cornerRadius", JE.float r )

        FillColor s ->
            ( "fillColor", JE.string s )

        Orient orient ->
            ( "orient", JE.string (legendOrientLabel orient) )

        Offset x ->
            ( "offset", JE.float x )

        StrokeColor s ->
            ( "strokeColor", JE.string s )

        LeStrokeDash xs ->
            if xs == [] then
                ( "strokeDash", JE.null )

            else
                ( "strokeDash", JE.list JE.float xs )

        LeStrokeWidth x ->
            ( "strokeWidth", JE.float x )

        LePadding x ->
            ( "padding", JE.float x )

        GradientDirection d ->
            ( "gradientDirection", JE.string (markOrientationLabel d) )

        GradientLabelBaseline va ->
            ( "gradientLabelBaseline", JE.string (vAlignLabel va) )

        GradientLabelLimit x ->
            ( "gradientLabelLimit", JE.float x )

        GradientLabelOffset x ->
            ( "gradientLabelOffset", JE.float x )

        GradientStrokeColor s ->
            ( "gradientStrokeColor", JE.string s )

        GradientStrokeWidth x ->
            ( "gradientStrokeWidth", JE.float x )

        GradientHeight x ->
            ( "gradientHeight", JE.float x )

        GradientWidth x ->
            ( "gradientWidth", JE.float x )

        LeGridAlign ga ->
            ( "gridAlign", JE.string (compositionAlignmentLabel ga) )

        LeLabelAlign ha ->
            ( "labelAlign", JE.string (hAlignLabel ha) )

        LeLabelBaseline va ->
            ( "labelBaseline", JE.string (vAlignLabel va) )

        LeLabelColor s ->
            ( "labelColor", JE.string s )

        LeLabelFont s ->
            ( "labelFont", JE.string s )

        LeLabelFontSize x ->
            ( "labelFontSize", JE.float x )

        LeLabelLimit x ->
            ( "labelLimit", JE.float x )

        LeLabelOffset x ->
            ( "labelOffset", JE.float x )

        LeLabelOverlap lo ->
            ( "labelOverlap", overlapStrategySpec lo )

        LeShortTimeLabels b ->
            ( "shortTimeLabels", JE.bool b )

        EntryPadding x ->
            ( "entryPadding", JE.float x )

        SymbolDirection d ->
            ( "symbolDirection", JE.string (markOrientationLabel d) )

        SymbolFillColor s ->
            ( "symbolFillColor", JE.string s )

        SymbolBaseFillColor s ->
            ( "symbolBaseFillColor", JE.string s )

        SymbolStrokeColor s ->
            ( "symbolStrokeColor", JE.string s )

        SymbolBaseStrokeColor s ->
            ( "symbolBaseStrokeColor", JE.string s )

        SymbolOffset o ->
            ( "symbolOffset", JE.float o )

        SymbolType s ->
            ( "symbolType", JE.string (symbolLabel s) )

        SymbolSize x ->
            ( "symbolSize", JE.float x )

        SymbolStrokeWidth x ->
            ( "symbolStrokeWidth", JE.float x )

        LeTitleAlign ha ->
            ( "titleAlign", JE.string (hAlignLabel ha) )

        LeTitleBaseline va ->
            ( "titleBaseline", JE.string (vAlignLabel va) )

        LeTitleColor s ->
            ( "titleColor", JE.string s )

        LeTitleFont s ->
            ( "titleFont", JE.string s )

        LeTitleFontSize x ->
            ( "titleFontSize", JE.float x )

        LeTitleFontWeight fw ->
            ( "titleFontWeight", fontWeightSpec fw )

        LeTitleLimit x ->
            ( "titleLimit", JE.float x )

        LeTitleLineHeight x ->
            ( "titleLineHeight", JE.float x )

        LeTitlePadding x ->
            ( "titlePadding", JE.float x )


legendOrientLabel : LegendOrientation -> String
legendOrientLabel orient =
    case orient of
        Left ->
            "left"

        TopLeft ->
            "top-left"

        Top ->
            "top"

        TopRight ->
            "top-right"

        Right ->
            "right"

        BottomRight ->
            "bottom-right"

        Bottom ->
            "bottom"

        BottomLeft ->
            "bottom-left"

        None ->
            "none"


legendProperty : LegendProperty -> LabelledSpec
legendProperty legendProp =
    case legendProp of
        LClipHeight h ->
            ( "clipHeight", JE.float h )

        LColumnPadding n ->
            ( "columnPadding", JE.float n )

        LRowPadding n ->
            ( "rowPadding", JE.float n )

        LColumns n ->
            ( "columns", JE.float n )

        LCornerRadius r ->
            ( "cornerRadius", JE.float r )

        LFillColor s ->
            ( "fillColor", JE.string s )

        LDirection d ->
            ( "direction", JE.string (markOrientationLabel d) )

        LType lType ->
            case lType of
                Gradient ->
                    ( "type", JE.string "gradient" )

                Symbol ->
                    ( "type", JE.string "symbol" )

        LFormat s ->
            ( "format", JE.string s )

        LFormatAsNum ->
            ( "formatType", JE.string "number" )

        LFormatAsTemporal ->
            ( "formatType", JE.string "time" )

        LGradientLength n ->
            ( "gradientLength", JE.float n )

        LGradientThickness n ->
            ( "gradientThickness", JE.float n )

        LGradientStrokeColor s ->
            ( "gradientStrokeColor", JE.string s )

        LGradientStrokeWidth n ->
            ( "gradientStrokeWidth", JE.float n )

        LGridAlign ga ->
            ( "gridAlign", JE.string (compositionAlignmentLabel ga) )

        LLabelAlign ha ->
            ( "labelAlign", JE.string (hAlignLabel ha) )

        LLabelBaseline va ->
            ( "labelBaseline", JE.string (vAlignLabel va) )

        LLabelColor s ->
            ( "labelColor", JE.string s )

        LLabelFont s ->
            ( "labelFont", JE.string s )

        LLabelFontSize x ->
            ( "labelFontSize", JE.float x )

        LLabelLimit x ->
            ( "labelLimit", JE.float x )

        LLabelOffset x ->
            ( "labelOffset", JE.float x )

        LLabelOverlap lo ->
            ( "labelOverlap", overlapStrategySpec lo )

        LOffset x ->
            ( "offset", JE.float x )

        LOrient orient ->
            ( "orient", JE.string (legendOrientLabel orient) )

        LPadding x ->
            ( "padding", JE.float x )

        LStrokeColor s ->
            ( "strokeColor", JE.string s )

        LStrokeWidth x ->
            ( "strokeWidth", JE.float x )

        LSymbolFillColor s ->
            ( "symbolFillColor", JE.string s )

        LSymbolStrokeColor s ->
            ( "symbolStrokeColor", JE.string s )

        LSymbolType s ->
            ( "symbolType", JE.string (symbolLabel s) )

        LSymbolSize x ->
            ( "symbolSize", JE.float x )

        LSymbolStrokeWidth x ->
            ( "symbolStrokeWidth", JE.float x )

        LTickCount x ->
            ( "tickCount", JE.float x )

        LTitle s ->
            if s == "" then
                ( "title", JE.null )

            else
                ( "title", multilineTextSpec s )

        LTitleAlign ha ->
            ( "titleAlign", JE.string (hAlignLabel ha) )

        LTitleBaseline va ->
            ( "titleBaseline", JE.string (vAlignLabel va) )

        LTitleColor s ->
            ( "titleColor", JE.string s )

        LTitleFont s ->
            ( "titleFont", JE.string s )

        LTitleFontSize x ->
            ( "titleFontSize", JE.float x )

        LTitleFontWeight fw ->
            ( "titleFontWeight", fontWeightSpec fw )

        LTitleLimit x ->
            ( "titleLimit", JE.float x )

        LTitlePadding x ->
            ( "titlePadding", JE.float x )

        LValues vals ->
            let
                list =
                    case vals of
                        LNumbers xs ->
                            JE.list JE.float xs

                        LDateTimes ds ->
                            JE.list (\d -> JE.object (List.map dateTimeProperty d)) ds

                        LStrings ss ->
                            JE.list JE.string ss
            in
            ( "values", list )

        LeX n ->
            ( "legendX", JE.float n )

        LeY n ->
            ( "legendY", JE.float n )

        LZIndex n ->
            ( "zindex", JE.int n )


lineMarkerSpec : LineMarker -> Spec
lineMarkerSpec pm =
    case pm of
        LMNone ->
            JE.bool False

        LMMarker mps ->
            JE.object (List.map markProperty mps)


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
                :: List.map markProperty mProps
                |> JE.object
            )


markChannelProperties : MarkChannel -> List LabelledSpec
markChannelProperties field =
    case field of
        MName s ->
            [ ( "field", JE.string s ) ]

        MRepeat arr ->
            [ ( "field", JE.object [ ( "repeat", JE.string (arrangementLabel arr) ) ] ) ]

        MmType t ->
            [ ( "type", JE.string (measurementLabel t) ) ]

        MScale sps ->
            if sps == [] then
                [ ( "scale", JE.null ) ]

            else
                [ ( "scale", JE.object (List.map scaleProperty sps) ) ]

        MLegend lps ->
            if lps == [] then
                [ ( "legend", JE.null ) ]

            else
                [ ( "legend", JE.object (List.map legendProperty lps) ) ]

        MBin bps ->
            [ bin bps ]

        MSort sps ->
            case sps of
                [] ->
                    [ ( "sort", JE.null ) ]

                [ Ascending ] ->
                    [ ( "sort", JE.string "ascending" ) ]

                [ Descending ] ->
                    [ ( "sort", JE.string "descending" ) ]

                [ CustomSort dvs ] ->
                    [ ( "sort", toList (dataValuesSpecs dvs) ) ]

                _ ->
                    [ ( "sort", JE.object (List.concatMap sortProperties sps) ) ]

        MBinned ->
            [ ( "bin", JE.string "binned" ) ]

        MSelectionCondition selName ifClause elseClause ->
            ( "condition"
            , JE.object
                (( "selection", booleanOpSpec selName )
                    :: List.concatMap markChannelProperties ifClause
                )
            )
                :: List.concatMap markChannelProperties elseClause

        MDataCondition tests elseClause ->
            let
                testClause ( predicate, ifClause ) =
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


markInterpolationLabel : MarkInterpolation -> String
markInterpolationLabel interp =
    case interp of
        Linear ->
            "linear"

        LinearClosed ->
            "linear-closed"

        Stepwise ->
            "step"

        StepBefore ->
            "step-before"

        StepAfter ->
            "step-after"

        Basis ->
            "basis"

        BasisOpen ->
            "basis-open"

        BasisClosed ->
            "basis-closed"

        Cardinal ->
            "cardinal"

        CardinalOpen ->
            "cardinal-open"

        CardinalClosed ->
            "cardinal-closed"

        Bundle ->
            "bundle"

        Monotone ->
            "monotone"


markLabel : Mark -> String
markLabel m =
    case m of
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


markProperty : MarkProperty -> LabelledSpec
markProperty mProp =
    case mProp of
        MFilled b ->
            ( "filled", JE.bool b )

        MClip b ->
            ( "clip", JE.bool b )

        MColor col ->
            ( "color", JE.string col )

        MCornerRadius r ->
            ( "cornerRadius", JE.float r )

        MCornerRadiusEnd r ->
            ( "cornerRadiusEnd", JE.float r )

        MCornerRadiusBL r ->
            ( "cornerRadiusBottomLeft", JE.float r )

        MCornerRadiusBR r ->
            ( "cornerRadiusBottomRight", JE.float r )

        MCornerRadiusTL r ->
            ( "cornerRadiusTopLeft", JE.float r )

        MCornerRadiusTR r ->
            ( "cornerRadiusTopRight", JE.float r )

        MCursor cur ->
            ( "cursor", JE.string (cursorLabel cur) )

        MExtent ext ->
            ( "extent", extentSpec ext )

        MHRef s ->
            ( "href", JE.string s )

        MRemoveInvalid b ->
            if b then
                ( "invalid", JE.string "filter" )

            else
                ( "invalid", JE.null )

        MFill col ->
            if String.trim col == "" then
                ( "fill", JE.null )

            else
                ( "fill", JE.string col )

        MFillGradient cGrad props ->
            ( "fill"
            , JE.object
                (( "gradient", JE.string (colorGradientLabel cGrad) )
                    :: List.map gradientProperty props
                )
            )

        MColorGradient cGrad props ->
            ( "color"
            , JE.object
                (( "gradient", JE.string (colorGradientLabel cGrad) )
                    :: List.map gradientProperty props
                )
            )

        MStrokeGradient cGrad props ->
            ( "stroke"
            , JE.object
                (( "gradient", JE.string (colorGradientLabel cGrad) )
                    :: List.map gradientProperty props
                )
            )

        MStroke col ->
            if String.trim col == "" then
                ( "stroke", JE.null )

            else
                ( "stroke", JE.string col )

        MStrokeCap sc ->
            ( "strokeCap", JE.string (strokeCapLabel sc) )

        MStrokeJoin sj ->
            ( "strokeJoin", JE.string (strokeJoinLabel sj) )

        MStrokeMiterLimit ml ->
            ( "strokeMiterLimit", JE.float ml )

        MOpacity x ->
            ( "opacity", JE.float x )

        MFillOpacity x ->
            ( "fillOpacity", JE.float x )

        MStrokeOpacity x ->
            ( "strokeOpacity", JE.float x )

        MStrokeWidth x ->
            ( "strokeWidth", JE.float x )

        MStrokeDash xs ->
            if xs == [] then
                ( "strokeDash", JE.null )

            else
                ( "strokeDash", JE.list JE.float xs )

        MStrokeDashOffset x ->
            ( "strokeDashOffset", JE.float x )

        MStyle styles ->
            ( "style", JE.list JE.string styles )

        MInterpolate interp ->
            ( "interpolate", JE.string (markInterpolationLabel interp) )

        MTension x ->
            ( "tension", JE.float x )

        MOrient orient ->
            ( "orient", JE.string (markOrientationLabel orient) )

        MShape sym ->
            ( "shape", JE.string (symbolLabel sym) )

        MSize x ->
            ( "size", JE.float x )

        MAngle x ->
            ( "angle", JE.float x )

        MAlign al ->
            ( "align", JE.string (hAlignLabel al) )

        MBaseline va ->
            ( "baseline", JE.string (vAlignLabel va) )

        MdX dx ->
            ( "dx", JE.float dx )

        MdY dy ->
            ( "dy", JE.float dy )

        MFont fnt ->
            ( "font", JE.string fnt )

        MFontSize x ->
            ( "fontSize", JE.float x )

        MFontStyle fSty ->
            ( "fontStyle", JE.string fSty )

        MFontWeight w ->
            ( "fontWeight", fontWeightSpec w )

        MRadius x ->
            ( "radius", JE.float x )

        MText txt ->
            ( "text", JE.string txt )

        MLimit x ->
            ( "limit", JE.float x )

        MEllipsis s ->
            ( "ellipsis", JE.string s )

        MDir td ->
            ( "dir", JE.string (textDirectionLabel td) )

        MTheta x ->
            ( "theta", JE.float x )

        MBinSpacing x ->
            ( "binSpacing", JE.float x )

        MContinuousBandSize x ->
            ( "continuousBandSize", JE.float x )

        MDiscreteBandSize x ->
            ( "discreteBandSize", JE.float x )

        MShortTimeLabels b ->
            ( "shortTimeLabels", JE.bool b )

        MBandSize x ->
            ( "bandSize", JE.float x )

        MThickness x ->
            ( "thickness", JE.float x )

        MRule props ->
            case props of
                [] ->
                    ( "rule", JE.bool False )

                _ ->
                    ( "rule", JE.object (List.map markProperty props) )

        MBorders props ->
            ( "borders", JE.object (List.map markProperty props) )

        MMedian props ->
            case props of
                [] ->
                    ( "median", JE.bool False )

                _ ->
                    ( "median", JE.object (List.map markProperty props) )

        MBox props ->
            case props of
                [] ->
                    ( "box", JE.bool False )

                _ ->
                    ( "box", JE.object (List.map markProperty props) )

        MOutliers props ->
            case props of
                [] ->
                    ( "outliers", JE.bool False )

                _ ->
                    ( "outliers", JE.object (List.map markProperty props) )

        MTicks props ->
            ( "ticks", JE.object (List.map markProperty props) )

        MTooltip ttContent ->
            if ttContent == TTNone then
                ( "tooltip", JE.null )

            else
                ( "tooltip", JE.object [ ( "content", JE.string (ttContentLabel ttContent) ) ] )

        MPoint pm ->
            ( "point", pointMarkerSpec pm )

        MLine lm ->
            ( "line", lineMarkerSpec lm )

        MWidth w ->
            ( "width", JE.float w )

        MHeight h ->
            ( "height", JE.float h )

        MX x ->
            ( "x", JE.float x )

        MY y ->
            ( "y", JE.float y )

        MX2 x ->
            ( "x2", JE.float x )

        MY2 y ->
            ( "y2", JE.float y )

        MOrder b ->
            ( "order", JE.bool b )

        MXOffset o ->
            ( "xOffset", JE.float o )

        MX2Offset o ->
            ( "x2Offset", JE.float o )

        MYOffset o ->
            ( "yOffset", JE.float o )

        MY2Offset o ->
            ( "y2Offset", JE.float o )

        MAspect b ->
            ( "aspect", JE.bool b )


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


orderChannelProperty : OrderChannel -> LabelledSpec
orderChannelProperty oDef =
    case oDef of
        OName s ->
            ( "field", JE.string s )

        ORepeat arr ->
            ( "field", JE.object [ ( "repeat", JE.string (arrangementLabel arr) ) ] )

        OmType measure ->
            ( "type", JE.string (measurementLabel measure) )

        OBin bps ->
            bin bps

        OAggregate op ->
            ( "aggregate", operationSpec op )

        OTimeUnit tu ->
            ( "timeUnit", timeUnitSpec tu )

        OSort sps ->
            case sps of
                [] ->
                    ( "sort", JE.null )

                [ Ascending ] ->
                    ( "sort", JE.string "ascending" )

                [ Descending ] ->
                    ( "sort", JE.string "descending" )

                [ CustomSort dvs ] ->
                    ( "sort", toList (dataValuesSpecs dvs) )

                _ ->
                    ( "sort", JE.object (List.concatMap sortProperties sps) )


overlapStrategySpec : OverlapStrategy -> Spec
overlapStrategySpec strat =
    case strat of
        ONone ->
            JE.bool False

        OParity ->
            JE.string "parity"

        OGreedy ->
            JE.string "greedy"


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
                JE.object (List.map markProperty mps)


positiveAngle : Float -> Float
positiveAngle a =
    if a < 0 then
        a + 360

    else
        a


projectionLabel : Projection -> String
projectionLabel proj =
    case proj of
        Albers ->
            "albers"

        AlbersUsa ->
            "albersUsa"

        AzimuthalEqualArea ->
            "azimuthalEqualArea"

        AzimuthalEquidistant ->
            "azimuthalEquidistant"

        ConicConformal ->
            "conicConformal"

        ConicEqualArea ->
            "conicEqualarea"

        ConicEquidistant ->
            "conicEquidistant"

        Custom projName ->
            projName

        EqualEarth ->
            "equalEarth"

        Equirectangular ->
            "equirectangular"

        Gnomonic ->
            "gnomonic"

        Identity ->
            "identity"

        Mercator ->
            "mercator"

        NaturalEarth1 ->
            "naturalEarth1"

        Orthographic ->
            "orthographic"

        Stereographic ->
            "stereographic"

        TransverseMercator ->
            "transverseMercator"


projectionProperty : ProjectionProperty -> LabelledSpec
projectionProperty pp =
    case pp of
        PType proj ->
            ( "type", JE.string (projectionLabel proj) )

        PClipAngle numOrNull ->
            case numOrNull of
                Just x ->
                    ( "clipAngle", JE.float x )

                Nothing ->
                    ( "clipAngle", JE.null )

        PClipExtent rClip ->
            case rClip of
                NoClip ->
                    ( "clipExtent", JE.null )

                LTRB l t r b ->
                    ( "clipExtent", JE.list JE.float [ l, t, r, b ] )

        PReflectX b ->
            ( "reflectX", JE.bool b )

        PReflectY b ->
            ( "reflectY", JE.bool b )

        PCenter lon lat ->
            ( "center", JE.list JE.float [ lon, lat ] )

        PrScale sc ->
            ( "scale", JE.float sc )

        PrTranslate tx ty ->
            ( "translate", JE.list JE.float [ tx, ty ] )

        PrRotate lambda phi gamma ->
            ( "rotate", JE.list JE.float [ lambda, phi, gamma ] )

        PPrecision pr ->
            ( "precision", JE.float pr )

        PCoefficient x ->
            ( "coefficient", JE.float x )

        PDistance x ->
            ( "distance", JE.float x )

        PFraction x ->
            ( "fraction", JE.float x )

        PLobes n ->
            ( "lobes", JE.int n )

        PParallel x ->
            ( "parallel", JE.float x )

        PRadius x ->
            ( "radius", JE.float x )

        PRatio x ->
            ( "ratio", JE.float x )

        PSpacing x ->
            ( "spacing", JE.float x )

        PTilt x ->
            ( "tilt", JE.float x )


positionChannelProperty : PositionChannel -> LabelledSpec
positionChannelProperty pDef =
    case pDef of
        PName s ->
            ( "field", JE.string s )

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
                    ( "sort", toList (dataValuesSpecs dvs) )

                _ ->
                    ( "sort", JE.object (List.concatMap sortProperties sps) )

        PBand x ->
            ( "band", JE.float x )

        PScale sps ->
            if sps == [] then
                ( "scale", JE.null )

            else
                ( "scale", JE.object (List.map scaleProperty sps) )

        PAxis aps ->
            if aps == [] then
                ( "axis", JE.null )

            else
                ( "axis", JE.object (List.map axisProperty aps) )

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
            ( "category", JE.object [ schemeProperty schemeName [] ] )

        RDiverging schemeName ->
            ( "diverging", JE.object [ schemeProperty schemeName [] ] )

        RHeatmap schemeName ->
            ( "heatmap", JE.object [ schemeProperty schemeName [] ] )

        ROrdinal schemeName ->
            ( "ordinal", JE.object [ schemeProperty schemeName [] ] )

        RRamp schemeName ->
            ( "ramp", JE.object [ schemeProperty schemeName [] ] )

        RSymbol schemeName ->
            ( "symbol", JE.object [ schemeProperty schemeName [] ] )


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
            ( "extent", JE.list dataValueSpec [ mn, mx ] )

        RgAs iField dField ->
            ( "as", JE.list JE.string [ iField, dField ] )


repeatFieldsProperty : RepeatFields -> LabelledSpec
repeatFieldsProperty fields =
    case fields of
        RowFields fs ->
            ( "row", JE.list JE.string fs )

        ColumnFields fs ->
            ( "column", JE.list JE.string fs )


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

        SCRangeStep numOrNull ->
            case numOrNull of
                Just x ->
                    ( "rangeStep", JE.float x )

                Nothing ->
                    ( "rangeStep", JE.null )

        SCRound b ->
            ( "round", JE.bool b )

        SCTextXRangeStep x ->
            ( "textXRangeStep", JE.float x )

        SCUseUnaggregatedDomain b ->
            ( "useUnaggregatedDomain", JE.bool b )


scaleDomainSpec : ScaleDomain -> Spec
scaleDomainSpec sdType =
    case sdType of
        DNumbers ns ->
            JE.list JE.float ns

        DDateTimes ds ->
            JE.list (\d -> JE.object (List.map dateTimeProperty d)) ds

        DStrings cats ->
            JE.list JE.string cats

        DSelection selName ->
            JE.object [ ( "selection", JE.string selName ) ]

        Unaggregated ->
            JE.string "unaggregated"


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

        ScBinLinear ->
            "bin-linear"

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
            JE.object [ ( "interval", timeUnitSpec tu ), ( "step", JE.int step ) ]

        NTrue ->
            JE.bool True

        NFalse ->
            JE.bool False

        NTickCount n ->
            JE.int n


scaleProperty : ScaleProperty -> LabelledSpec
scaleProperty scaleProp =
    case scaleProp of
        SType sType ->
            ( "type", JE.string (scaleLabel sType) )

        SDomain sdType ->
            ( "domain", scaleDomainSpec sdType )

        SRange range ->
            case range of
                RNumbers xs ->
                    ( "range", JE.list JE.float xs )

                RStrings ss ->
                    ( "range", JE.list JE.string ss )

                RName s ->
                    ( "range", JE.string s )

        SScheme schName extent ->
            schemeProperty schName extent

        SAlign x ->
            ( "align", JE.float x )

        SPadding x ->
            ( "padding", JE.float x )

        SBase x ->
            ( "base", JE.float x )

        SExponent x ->
            ( "exponent", JE.float x )

        SDomainMid x ->
            ( "domainMid", JE.float x )

        SConstant x ->
            ( "constant", JE.float x )

        SPaddingInner x ->
            ( "paddingInner", JE.float x )

        SPaddingOuter x ->
            ( "paddingOuter", JE.float x )

        SRangeStep numOrNull ->
            case numOrNull of
                Just x ->
                    ( "rangeStep", JE.float x )

                Nothing ->
                    ( "rangeStep", JE.null )

        SRound b ->
            ( "round", JE.bool b )

        SClamp b ->
            ( "clamp", JE.bool b )

        SInterpolate interp ->
            ( "interpolate", cInterpolateSpec interp )

        SNice ni ->
            ( "nice", scaleNiceSpec ni )

        SZero b ->
            ( "zero", JE.bool b )

        SReverse b ->
            ( "reverse", JE.bool b )


schemeProperty : String -> List Float -> LabelledSpec
schemeProperty schName extent =
    case extent of
        [] ->
            ( "scheme", JE.string schName )

        [ n ] ->
            ( "scheme", JE.object [ ( "name", JE.string schName ), ( "count", JE.float n ) ] )

        [ mn, mx ] ->
            ( "scheme", JE.object [ ( "name", JE.string schName ), ( "extent", JE.list JE.float [ mn, mx ] ) ] )

        _ ->
            -- |> Debug.log ("scScheme should have 0, 1 or 2 numbers but you provided " ++ Debug.toString extent)
            ( "scheme", JE.string schName )


selectionLabel : Selection -> String
selectionLabel seType =
    case seType of
        SeSingle ->
            "single"

        SeMulti ->
            "multi"

        SeInterval ->
            "interval"


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
            if xs == [] then
                ( "strokeDash", JE.null )

            else
                ( "strokeDash", JE.list JE.float xs )

        SMStrokeDashOffset x ->
            ( "strokeDashOffset", JE.float x )

        SMCursor cur ->
            ( "cursor", JE.string (cursorLabel cur) )


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
            [ ( "bind", JE.object (List.map bindingSpec binds) ) ]

        Nearest b ->
            [ ( "nearest", JE.bool b ) ]

        Toggle ex ->
            [ ( "toggle", JE.string ex ) ]

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


sideLabel : Side -> String
sideLabel side =
    case side of
        STop ->
            "top"

        SBottom ->
            "bottom"

        SLeft ->
            "left"

        SRight ->
            "right"


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

        CustomSort dvs ->
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


strokeCapLabel : StrokeCap -> String
strokeCapLabel cap =
    case cap of
        CButt ->
            "butt"

        CRound ->
            "round"

        CSquare ->
            "square"


strokeJoinLabel : StrokeJoin -> String
strokeJoinLabel jn =
    case jn of
        JMiter ->
            "miter"

        JRound ->
            "round"

        JBevel ->
            "bevel"


stopSpec : ( Float, String ) -> Spec
stopSpec ( x, c ) =
    JE.object [ ( "offset", JE.float x ), ( "color", JE.string c ) ]


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

        TSelectionCondition selName ifClause elseClause ->
            ( "condition"
            , JE.object
                (( "selection", booleanOpSpec selName )
                    :: List.concatMap textChannelProperties ifClause
                )
            )
                :: List.concatMap textChannelProperties elseClause

        TDataCondition tests elseClause ->
            let
                testClause ( predicate, ifClause ) =
                    JE.object
                        (( "test", booleanOpSpec predicate )
                            :: List.concatMap textChannelProperties ifClause
                        )
            in
            ( "condition", JE.list testClause tests )
                :: List.concatMap textChannelProperties elseClause

        TString s ->
            [ ( "value", multilineTextSpec s ) ]


textDirectionLabel : TextDirection -> String
textDirectionLabel td =
    case td of
        LeftToRight ->
            "ltr"

        RightToLeft ->
            "rtl"


tfLabel : TitleFrame -> String
tfLabel tf =
    case tf of
        FrGroup ->
            "group"

        FrBounds ->
            "bounds"


timeUnitLabel : TimeUnit -> String
timeUnitLabel tu =
    case tu of
        Year ->
            "year"

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

        Date ->
            "date"

        Day ->
            "day"

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

        _ ->
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


titleConfigProperty : TitleConfig -> LabelledSpec
titleConfigProperty titleCfg =
    case titleCfg of
        TAnchor an ->
            ( "anchor", JE.string (anchorLabel an) )

        TAngle x ->
            ( "angle", JE.float x )

        TBaseline va ->
            ( "baseline", JE.string (vAlignLabel va) )

        TColor clr ->
            ( "color", JE.string clr )

        TFont fnt ->
            ( "font", JE.string fnt )

        TFontSize x ->
            ( "fontSize", JE.float x )

        TFontStyle s ->
            ( "fontStyle", JE.string s )

        TFrame tf ->
            ( "frame", JE.string (tfLabel tf) )

        TFontWeight w ->
            ( "fontWeight", fontWeightSpec w )

        TLimit x ->
            ( "limit", JE.float x )

        TLineHeight x ->
            ( "lineHeight", JE.float x )

        TOffset x ->
            ( "offset", JE.float x )

        TOrient sd ->
            ( "orient", JE.string (sideLabel sd) )

        TStyle styles ->
            ( "style", JE.list JE.string styles )

        TSubtitle s ->
            ( "subtitle", multilineTextSpec s )

        TSubtitleColor s ->
            ( "subtitleColor", JE.string s )

        TSubtitleFont s ->
            ( "subtitleFont", JE.string s )

        TSubtitleFontSize x ->
            ( "subtitleFontSize", JE.float x )

        TSubtitleFontStyle s ->
            ( "subtitleFontStyle", JE.string s )

        TSubtitleFontWeight w ->
            ( "subtitleFontWeight", fontWeightSpec w )

        TSubtitleLineHeight x ->
            ( "subtitleLineHeight", JE.float x )

        TSubtitlePadding x ->
            ( "subtitlePadding", JE.float x )

        TZIndex n ->
            ( "zindex", JE.int n )


multilineTextSpec : String -> Spec
multilineTextSpec tText =
    case String.split "\n" tText of
        [] ->
            JE.string ""

        [ s ] ->
            JE.string s

        ss ->
            JE.list JE.string ss



-- Provides an equivalent ot the Elm 0.18 Json list function.


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


ttContentLabel : TooltipContent -> String
ttContentLabel ttContent =
    case ttContent of
        TTEncoding ->
            "encoding"

        TTData ->
            "data"

        TTNone ->
            "null"


vAlignLabel : VAlign -> String
vAlignLabel al =
    case al of
        AlignTop ->
            "top"

        AlignMiddle ->
            "middle"

        AlignBottom ->
            "bottom"

        AlignAlphabetic ->
            "alphabetic"


viewBackgroundProperty : ViewBackground -> LabelledSpec
viewBackgroundProperty vb =
    case vb of
        VBStyle styles ->
            ( "style", JE.list JE.string styles )

        VBCornerRadius r ->
            ( "cornerRadius", JE.float r )

        VBFill ms ->
            case ms of
                Just s ->
                    ( "fill", JE.string s )

                Nothing ->
                    ( "fill", JE.string "" )

        VBFillOpacity x ->
            ( "fillOpacity", JE.float x )

        VBOpacity x ->
            ( "opacity", JE.float x )

        VBStroke ms ->
            case ms of
                Just s ->
                    ( "stroke", JE.string s )

                Nothing ->
                    ( "stroke", JE.string "" )

        VBStrokeOpacity x ->
            ( "strokeOpacity", JE.float x )

        VBStrokeCap cap ->
            ( "strokeCap", JE.string (strokeCapLabel cap) )

        VBStrokeJoin jn ->
            ( "strokeJoin", JE.string (strokeJoinLabel jn) )

        VBStrokeWidth x ->
            ( "strokeWidth", JE.float x )

        VBStrokeDash xs ->
            if xs == [] then
                ( "strokeDash", JE.null )

            else
                ( "strokeDash", JE.list JE.float xs )

        VBStrokeDashOffset x ->
            ( "strokeDashOffset", JE.float x )

        VBStrokeMiterLimit x ->
            ( "strokeMiterLimit", JE.float x )


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
            [ ( "cursor", JE.string (cursorLabel cur) ) ]

        VFill ms ->
            case ms of
                Just s ->
                    [ ( "fill", JE.string s ) ]

                Nothing ->
                    [ ( "fill", JE.string "" ) ]

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
                    [ ( "stroke", JE.string "" ) ]

        VStrokeOpacity x ->
            [ ( "strokeOpacity", JE.float x ) ]

        VStrokeCap cap ->
            [ ( "strokeCap", JE.string (strokeCapLabel cap) ) ]

        VStrokeJoin jn ->
            [ ( "strokeJoin", JE.string (strokeJoinLabel jn) ) ]

        VStrokeWidth x ->
            [ ( "strokeWidth", JE.float x ) ]

        VStrokeDash xs ->
            if xs == [] then
                [ ( "strokeDash", JE.null ) ]

            else
                [ ( "strokeDash", JE.list JE.float xs ) ]

        VStrokeDashOffset x ->
            [ ( "strokeDashOffset", JE.float x ) ]

        VStrokeMiterLimit x ->
            [ ( "strokeMiterLimit", JE.float x ) ]

        VBackground vbs ->
            List.map viewBackgroundProperty vbs


vlPropertyLabel : VLProperty -> String
vlPropertyLabel spec =
    case spec of
        VLName ->
            "name"

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
            ( "keyvals", toList (dataValuesSpecs dVals) )

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
