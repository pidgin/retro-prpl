 /**
 * @file qq_crypt.h
 *
 * purple
 *
 * Purple is the legal property of its developers, whose names are too numerous
 * to list here.  Please refer to the COPYRIGHT file distributed with this
 * source distribution.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301,  USA
 */

#ifndef _QQ_CRYPT_H_
#define _QQ_CRYPT_H_

#include <glib.h>

gint qq_encrypt(guint8* crypted, const guint8* const plain, const gint plain_len, const guint8* const key);

gint qq_decrypt(guint8 *plain, const guint8* const crypted, const gint crypted_len, const guint8* const key);
#endif
