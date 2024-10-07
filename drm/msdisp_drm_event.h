/* Copyright (C) 2023 MacroSilicon Technology Co., Ltd.
 *
 * This software is licensed under the terms of the GNU General Public
 * License version 2, as published by the Free Software Foundation, and
 * may be copied, distributed, and modified under those terms.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * msdisp_drm_event.h -- Drm driver for MacroSilicon chip 913x and 912x
 */

#ifndef __MSDISP_DRM_EVENT_H__
#define __MSDISP_DRM_EVENT_H__

#include <drm/drm_file.h>

// drm request custom event type starts from 0x80000000
#define MSDISP_EVENT_TYPE_BASE                  0x90000000
#define MSDISP_EVENT_TYPE_ENABLE				(MSDISP_EVENT_TYPE_BASE + 1)
#define MSDISP_EVENT_TYPE_DISABLE				(MSDISP_EVENT_TYPE_BASE + 2)
#define MSDISP_EVENT_TYPE_UPDATE				(MSDISP_EVENT_TYPE_BASE + 3)


struct msdisp_drm_event {
    struct drm_event base;
    union {
		struct {
			unsigned int format;
			unsigned short width;
			unsigned short height;
			unsigned char rate;
			unsigned char resv[3];
		}enable;

		struct {
            unsigned int len;
			unsigned int resv[2];
		}update;

		struct {
			unsigned int resv[3];
		}disable;
	} para;
};

#endif