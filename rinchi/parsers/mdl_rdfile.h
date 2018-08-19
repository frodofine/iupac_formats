#ifndef IUPAC_RINCHI_MDL_RDFILE_HEADER_GUARD
#define IUPAC_RINCHI_MDL_RDFILE_HEADER_GUARD

#ifdef MSVC
#pragma region InChI-Trust Licence
/*
 * Reaction International Chemical Identifier (RInChI)
 * Version 1
 * Software version 1.00
 * Tue, 21 Mar 2017
 * 
 * The RInChI library and programs are free software developed under the
 * auspices of the International Union of Pure and Applied Chemistry (IUPAC).
 * 
 * IUPAC/InChI-Trust Licence No.1.0 for the 
 * Reaction International Chemical Identifier (RInChI) Software version 1.0
 * Copyright (C) IUPAC and InChI Trust Limited
 * 
 * This library is free software; you can redistribute it and/or modify it 
 * under the terms of the IUPAC/InChI Trust InChI Licence No.1.0, 
 * or any later version.
 * 
 * Please note that this library is distributed WITHOUT ANY WARRANTIES 
 * whatsoever, whether expressed or implied.  See the IUPAC/InChI Trust
 * Licence for the International Chemical Identifier (InChI) Software
 * ("IUPAC/InChI-Trust InChI Licence No. 1.0" in "LICENCE.TXT")
 * for more details.
 * 
 * You should have received a copy of the IUPAC/InChI Trust InChI 
 * Licence No. 1.0 with this library; if not, please write to:
 * 
 *     The InChI Trust
 *     8 Cavendish Avenue
 *     Cambridge CB1 7US
 *     UK
 *
 * or email to: alan@inchi-trust.org.
 *
 */
#pragma endregion
#endif

/** Constants defining tags in MDL RD files. **/

namespace rinchi {

	const std::string MDL_RDFILE_IDENTIFIER("$RDFILE 1");
	const std::string MDL_RDTAG_DATM("$DATM");

	const std::string MDL_RDTAG_RDFILE("$RDFILE");
	const std::string MDL_RDTAG_RFMT("$RFMT");

	const std::string MDL_RDTAG_DTYPE("$DTYPE");
	const std::string MDL_RDLINE_MFMT("$DATUM $MFMT");

} // end of namespace

#endif
